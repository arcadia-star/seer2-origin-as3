package com.taomee.seer2.app.team {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.init.LoginInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1089;
import com.taomee.seer2.app.notify.NoticeManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.team.data.TeamMainInfo;
import com.taomee.seer2.app.team.data.TeamMemberDataList;
import com.taomee.seer2.app.team.events.TeamEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.IDataInput;

import org.taomee.bean.BaseBean;

public class TeamManager extends BaseBean {

    public static const CHECK_MEMBER_LIST_COMPLETE:String = "checkMemberListComplete";

    public static const QUERY_MEMBER_LIST_COMPLETE:String = "queryMemberListComplete";

    public static const READY_TO_JOIN_TEAM:String = "readyToJoinTeam";

    public static var teamEffectStatusArr:Array;

    public static var teamCoins:uint;

    public static var teamCapacity:uint;

    public static var fightBossStatus:Boolean;

    private static var _teamInfo:TeamMainInfo;

    private static var _memberList:TeamMemberDataList;

    private static var _dispatcher:EventDispatcher = new EventDispatcher();


    public function TeamManager() {
        super();
    }

    private static function onMapDispose(param1:SceneEvent):void {
        if (SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.active.mapModel.id == 60) {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, onCustomUnitClick);
        }
    }

    private static function onMapComplete(param1:SceneEvent):void {
        if (SceneManager.active.type == SceneType.LOBBY && SceneManager.active.mapModel.id == 60) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, onCustomUnitClick);
        }
    }

    private static function onCustomUnitClick(param1:DialogPanelEvent):void {
        if (param1.content.params == "createTeam") {
            onCreateTeam();
        } else if (param1.content.params == "manageTeam") {
            onManagerTeam();
        }
    }

    private static function onManagerTeam():void {
        if (_teamInfo.userPost == TeamTitle.CAPTAIN) {
            NpcDialog.show(6, "克拉克", [[0, "请务必牢记队长的职责！"]], ["以后再说"]);
            NpcDialog.addFunctionUnit("", "修改战队资料", "", function ():void {
                NpcDialog.show(6, "克拉克", [[0, "修改战队资料需要2000赛尔豆。"]], ["修改战队资料。", "以后再说。"], [function ():void {
                    if (ActorManager.getActor().getInfo().coins < 2000) {
                        NpcDialog.show(6, "克拉克", [[0, "修改战队资料需要2000赛尔豆。"]], ["我知道了"]);
                    } else {
                        ModuleManager.showModule(URLUtil.getAppModule("TeamCreatePanel"), "加载战队创建面板", 1);
                    }
                }, null]);
            });
            NpcDialog.addFunctionUnit("", "移交队长", "", function ():void {
                NpcDialog.show(6, "克拉克", [[0, "输入你要移交的队员的米米号。"]], ["我再看看别的"]);
                NpcDialog.addInputUnit(transferCaptain);
            });
            NpcDialog.addFunctionUnit("", "申请解散战队", "", function ():void {
                var now:uint = 0;
                var txt:String = null;
                if (_teamInfo.dissolveDay == 0) {
                    NpcDialog.show(6, "克拉克", [[0, "战队就是一个大家庭，你要解散它么？"]], ["申请解散战队", "我再看看别的"], [function ():void {
                        dissolveTeam(0);
                    }, null]);
                } else {
                    now = new Date().getTime() / 1000;
                    txt = int(7 - (now - teamInfo.dissolveDay) / 24 / 3600).toString() + "天之后战队将会解散！";
                    NpcDialog.show(6, "克拉克", [[0, txt]], ["中止解散战队", "再见"], [function ():void {
                        dissolveTeam(1);
                    }, null]);
                }
            });
        } else {
            NpcDialog.show(6, "克拉克", [[0, "管理战队是战队队长的权力和义务。"]], ["嗯，我点错了。"]);
        }
    }

    private static function onCreateTeam():void {
        if (_teamInfo.id > 0) {
            NpcDialog.show(6, "克拉克", [[0, "你已经加入了一个战队。只有没有加入战队的赛尔才能创建战队。"]], ["对不起，我走错了……"]);
        } else {
            NpcDialog.show(6, "克拉克", [[0, "创建战队需要训练师等级≥8级，成功创建战队还将扣除5000赛尔豆。你，准备好了么？"]], ["以后再来", "时刻准备着！"], [null, function ():void {
                var _loc1_:* = ActorManager.getActor().getInfo();
                if (_loc1_.coins < 5000) {
                    NpcDialog.show(6, "克拉克", [[0, "创建战队需要5000赛尔豆。"]], ["我知道了"]);
                } else if (_loc1_.trainerLevel < 8) {
                    NpcDialog.show(6, "克拉克", [[0, "只有训练师等级≥8级，才能够担当起战队队长的责任。"]], ["我知道了"]);
                } else {
                    ModuleManager.showModule(URLUtil.getAppModule("TeamCreatePanel"), "加载战队创建面板", 0);
                }
            }]);
        }
    }

    public static function modifyTeamInfo():void {
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc1_.writeUTFBytes(_teamInfo.name);
        _loc1_.length = 25;
        Connection.addCommandListener(CommandSet.TEAM_MODIFYINFO_1120, onModifyTeamInfo);
        Connection.send(CommandSet.TEAM_MODIFYINFO_1120, _teamInfo.id, _loc1_, _teamInfo.logoFront, _teamInfo.logoBack, _teamInfo.logoColor);
    }

    private static function onModifyTeamInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_MODIFYINFO_1120, onModifyTeamInfo);
        AlertManager.showAlert("修改战队资料成功");
        ActorManager.getActor().getInfo().coins = ActorManager.getActor().getInfo().coins - 2000;
    }

    private static function transferCaptain(param1:int):void {
        var userId:int = param1;
        NpcDialog.show(6, "克拉克", [[0, "你确定要移交队长？ 米米号：<font color=\'#FFFF99\' size=\'14\'>" + userId + "</font>"]], ["确定", "取消"], [function ():void {
            if (userId == ActorManager.actorInfo.id) {
                AlertManager.showAlert("不能移交队长给自己");
                return;
            }
            Connection.addCommandListener(CommandSet.TEAM_TRANSFERCAPTAIN_1119, onTransferCaptain);
            Connection.send(CommandSet.TEAM_TRANSFERCAPTAIN_1119, userId);
        }, null]);
    }

    private static function onTransferCaptain(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_TRANSFERCAPTAIN_1119, onTransferCaptain);
        _teamInfo.userPost = TeamTitle.MEMBER;
        NpcDialog.show(6, "克拉克", [[0, "移交队长成功。"]], ["嗯，我知道啦"]);
    }

    private static function dissolveTeam(param1:int):void {
        var _loc2_:ByteArray = new ByteArray();
        _loc2_.writeByte(param1);
        Connection.addCommandListener(CommandSet.TEAM_DISSOLVE_1118, onDissolveTeam);
        Connection.send(CommandSet.TEAM_DISSOLVE_1118, _loc2_);
    }

    private static function onDissolveTeam(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_DISSOLVE_1118, onDissolveTeam);
        var _loc2_:int = int(param1.message.getRawDataCopy().readUnsignedByte());
        if (_loc2_ == 0) {
            _teamInfo.dissolveDay = new Date().getTime() / 1000;
            NpcDialog.show(6, "克拉克", [[0, "七天之后战队将会解散！"]], ["再见"]);
        } else {
            _teamInfo.dissolveDay = 0;
            NpcDialog.show(6, "克拉克", [[0, "战队解散停止！"]], ["再见"]);
        }
    }

    public static function createTeam():void {
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc1_.writeUTFBytes(_teamInfo.name);
        _loc1_.length = 25;
        Connection.addCommandListener(CommandSet.TEAM_CREATE_1083, onTeamCreate);
        Connection.send(CommandSet.TEAM_CREATE_1083, _loc1_, _teamInfo.logoFront, _teamInfo.logoBack, _teamInfo.logoColor);
    }

    private static function onTeamCreate(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_CREATE_1083, onTeamCreate);
        var _loc2_:IDataInput = param1.message.getRawData();
        _teamInfo.id = _loc2_.readUnsignedInt();
        _teamInfo.userPost = TeamTitle.CAPTAIN;
        ActorManager.getActor().getInfo().coins = _loc2_.readUnsignedInt();
        ServerMessager.addMessage("恭喜你成功创建了" + _teamInfo.name + "战队！");
        AlertManager.showTeamCreComAlert("点击屏幕下方战队按钮即可回到战队基地");
        dispatchEvent(TeamEvent.CREATE);
    }

    public static function inviteTeam(param1:int):void {
        Connection.addCommandListener(CommandSet.TEAM_INVITE_JOIN_1084, onInviteSucess);
        Connection.send(CommandSet.TEAM_INVITE_JOIN_1084, param1);
    }

    private static function onInviteSucess(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_INVITE_JOIN_1084, onInviteSucess);
        ServerMessager.addMessage("你的邀请已经发出");
    }

    private static function onTeamNotify(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        var _loc6_:String = String(_loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN));
        var _loc7_:TeamMainInfo = new TeamMainInfo();
        TeamMainInfo.readBaseInfo(_loc7_, _loc2_);
        var _loc8_:int = int(_loc2_.readUnsignedInt());
        TeamMainInfo.readMsgInfo(_loc7_, _loc2_);
        switch (_loc4_) {
            case 1084:
                processInvite(_loc4_, _loc5_, _loc6_, _loc7_);
                break;
            case 1092:
                processLeaveTeam(_loc3_, "你已经被踢出了战队");
                dispatchEvent(TeamEvent.QUIT);
                break;
            case 1086:
                processReplyInvite(_loc5_, _loc6_, _loc8_);
                break;
            case 1118:
                processLeaveTeam(_loc3_, "你所在战队已被队长解散");
                dispatchEvent(TeamEvent.DISOLVE);
                break;
            case 1119:
                processTransferCaptain(_loc3_, _loc6_, _loc8_);
                break;
            case 1166:
                processApplyJoinTeam(_loc4_, _loc5_, _loc6_, _loc7_, _loc8_);
                break;
            case 1571:
                rejectJonin(_loc4_, _loc5_, _loc6_, _loc7_);
        }
    }

    private static function rejectJonin(param1:uint, param2:uint, param3:String, param4:TeamMainInfo):void {
        NoticeManager.addTeamNotice(param1, param2, param4, param3);
    }

    private static function processInvite(param1:uint, param2:uint, param3:String, param4:TeamMainInfo):void {
        NoticeManager.addTeamNotice(param1, param2, param4, param3);
    }

    private static function processReplyInvite(param1:uint, param2:String, param3:int):void {
        if (param3 == 0) {
            ServerMessager.addMessage(param2 + "拒绝了你的邀请");
        }
    }

    private static function processLeaveTeam(param1:int, param2:String):void {
        var userId:int = param1;
        var tip:String = param2;
        if (userId == ActorManager.actorInfo.id) {
            _teamInfo.clear();
            if (SceneManager.currentSceneType == SceneType.TEAM) {
                AlertManager.showAlert(tip, function ():void {
                    SceneManager.changeScene(SceneType.HOME, ActorManager.actorInfo.id);
                });
            } else {
                AlertManager.showAlert(tip);
            }
        }
    }

    private static function processApplyJoinTeam(param1:uint, param2:uint, param3:String, param4:TeamMainInfo, param5:uint):void {
        NoticeManager.addTeamNotice(param1, param2, param4, param3, param5);
    }

    public static function processTransferCaptain(param1:int, param2:String, param3:int):void {
        if (param1 == ActorManager.actorInfo.id) {
            if (param3 == 1) {
                _teamInfo.userPost = TeamTitle.CAPTAIN;
                AlertManager.showAlert(param2 + "把队长的职位移交给你了。");
            }
        }
        dispatchEvent(TeamEvent.TRANFER_LEADER);
    }

    public static function replyInviteTeam(param1:int, param2:int, param3:int, param4:Function = null, param5:Function = null):void {
        var onInviteReply:Function = null;
        var onInviteReplyError:Function = null;
        var inviterId:int = param1;
        var teamId:int = param2;
        var isAccept:int = param3;
        var joinSuccess:Function = param4;
        var joinError:Function = param5;
        onInviteReply = function (param1:MessageEvent):void {
            Connection.removeErrorHandler(CommandSet.TEAM_INVITE_REPLY_1086, onInviteReplyError);
            Connection.removeCommandListener(CommandSet.TEAM_INVITE_REPLY_1086, onInviteReply);
            var _loc2_:IDataInput = param1.message.getRawData();
            var _loc3_:* = _loc2_.readUnsignedInt() == 1;
            if (_loc3_) {
                if (joinSuccess != null) {
                    joinSuccess();
                    joinSuccess = null;
                }
                _teamInfo.id = _loc2_.readUnsignedInt();
                _teamInfo.userPost = _loc2_.readUnsignedByte();
                ServerMessager.addMessage("你已成功加入战队");
                AlertManager.showAlert("点击屏幕下方战队按钮即可回到战队基地");
                dispatchEvent(TeamEvent.ADD);
            }
        };
        onInviteReplyError = function (param1:MessageEvent):void {
            Connection.removeErrorHandler(CommandSet.TEAM_INVITE_REPLY_1086, onInviteReplyError);
            Connection.removeCommandListener(CommandSet.TEAM_INVITE_REPLY_1086, onInviteReply);
            AlertManager.showAlert("你已加入别的战队");
            if (joinError != null) {
                joinError();
                joinError = null;
            }
        };
        Connection.addErrorHandler(CommandSet.TEAM_INVITE_REPLY_1086, onInviteReplyError);
        Connection.addCommandListener(CommandSet.TEAM_INVITE_REPLY_1086, onInviteReply);
        Connection.send(CommandSet.TEAM_INVITE_REPLY_1086, inviterId, teamId, isAccept);
    }

    public static function quitTeam():void {
        Connection.addCommandListener(CommandSet.TEAM_QUIT_1093, onTeamQuit);
        Connection.send(CommandSet.TEAM_QUIT_1093);
    }

    public static function rejectJoinTeam(param1:int, param2:String = ""):void {
        var len:int;
        var onReject:Function = null;
        var userId:int = param1;
        var msg:String = param2;
        onReject = function (param1:MessageEvent):void {
            Connection.removeCommandListener(CommandSet.TEAM_Reject_1571, onReject);
            ServerMessager.addMessage("你拒绝了【" + userId + "】的申请");
        };
        var data:ByteArray = new ByteArray();
        data.writeUTFBytes(msg);
        data.position = 0;
        if (data.length >= 60) {
            AlertManager.showAlert("你输入的信息太长了哦！");
            return;
        }
        len = int(data.length);
        Connection.addCommandListener(CommandSet.TEAM_Reject_1571, onReject);
        Connection.send(CommandSet.TEAM_Reject_1571, userId, len, data);
    }

    private static function onTeamQuit(param1:MessageEvent):void {
        var evt:MessageEvent = param1;
        Connection.removeCommandListener(CommandSet.TEAM_QUIT_1093, onTeamQuit);
        _teamInfo.id = 0;
        _teamInfo.userPost = 0;
        AlertManager.showAlert("你已经退出了战队", function ():void {
            SceneManager.changeScene(SceneType.HOME, ActorManager.actorInfo.id);
        });
        dispatchEvent(TeamEvent.QUIT);
    }

    public static function kickMember(param1:uint):void {
        Connection.addCommandListener(CommandSet.TEAM_MEMBER_KICK_1092, onMemberKick);
        Connection.send(CommandSet.TEAM_MEMBER_KICK_1092, param1);
    }

    private static function onMemberKick(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_MEMBER_KICK_1092, onMemberKick);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        _memberList.remove(_loc3_);
        ServerMessager.addMessage("你已经把" + _loc3_ + "踢出了战队");
    }

    public static function apllyJoinTeam(param1:uint, param2:String, param3:Function = null, param4:Function = null):void {
        var len:int;
        var onApplySuccess:Function = null;
        var onApplyError:Function = null;
        var teamId:uint = param1;
        var msg:String = param2;
        var onSuccess:Function = param3;
        var onFail:Function = param4;
        onApplySuccess = function (param1:MessageEvent):void {
            Connection.removeErrorHandler(CommandSet.TEAM_APPLY_JOIN_1166, onApplyError);
            Connection.removeCommandListener(CommandSet.TEAM_APPLY_JOIN_1166, onApplySuccess);
            AlertManager.showAlert("申请成功，等待队长确认");
            if (onSuccess != null) {
                onSuccess();
                onSuccess = null;
            }
        };
        onApplyError = function (param1:MessageEvent):void {
            Connection.removeErrorHandler(CommandSet.TEAM_APPLY_JOIN_1166, onApplyError);
            Connection.removeCommandListener(CommandSet.TEAM_APPLY_JOIN_1166, onApplySuccess);
            switch (param1.message.statusCode) {
                case 114:
                    AlertManager.showAlert("你已经在一个战队了，不能申请加入其他战队");
                    break;
                case 172:
                    AlertManager.showAlert("该战队已经解散，请申请其他战队");
            }
            if (onFail != null) {
                onFail();
                onFail = null;
            }
        };
        var data:ByteArray = new ByteArray();
        data.writeUTFBytes(msg);
        data.position = 0;
        if (data.length >= 60) {
            AlertManager.showAlert("你输入的信息太长了哦！");
            return;
        }
        len = int(data.length);
        Connection.addErrorHandler(CommandSet.TEAM_APPLY_JOIN_1166, onApplyError);
        Connection.addCommandListener(CommandSet.TEAM_APPLY_JOIN_1166, onApplySuccess);
        Connection.send(CommandSet.TEAM_APPLY_JOIN_1166, teamId, len, data);
    }

    public static function queryTeamList():void {
        Connection.addCommandListener(CommandSet.TEAM_MEMBER_LIST_1089, onQuestTeamList);
        Connection.send(CommandSet.TEAM_MEMBER_LIST_1089);
    }

    private static function onQuestTeamList(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.TEAM_MEMBER_LIST_1089, onQuestTeamList);
        var _loc2_:Parser_1089 = new Parser_1089(param1.message.getRawData());
        dispatchEvent(QUERY_MEMBER_LIST_COMPLETE, _loc2_);
    }

    public static function checkOnlineList(param1:Vector.<uint>):void {
        var _loc3_:uint = 0;
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeUnsignedInt(param1.length);
        for each(_loc3_ in param1) {
            _loc2_.writeUnsignedInt(_loc3_);
        }
        Connection.addCommandListener(CommandSet.CHECK_ONLINE_1023, onCheckOnline);
        Connection.send(CommandSet.CHECK_ONLINE_1023, _loc2_);
    }

    private static function onCheckOnline(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CHECK_ONLINE_1023, onCheckOnline);
        var _loc2_:Vector.<int> = new Vector.<int>();
        var _loc3_:Vector.<int> = new Vector.<int>();
        var _loc4_:IDataInput;
        var _loc5_:int = int((_loc4_ = param1.message.getRawData()).readUnsignedInt());
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            _loc2_.push(_loc4_.readUnsignedInt());
            _loc3_.push(_loc4_.readUnsignedShort());
            _loc6_++;
        }
        _memberList.update(_loc2_);
        _memberList.updateServerInfo(_loc2_, _loc3_);
        dispatchEvent(CHECK_MEMBER_LIST_COMPLETE);
    }

    public static function getMemberList():TeamMemberDataList {
        return _memberList;
    }

    public static function get teamId():int {
        return _teamInfo.id;
    }

    public static function get teamTitle():int {
        return _teamInfo.userPost;
    }

    public static function get teamInfo():TeamMainInfo {
        return _teamInfo;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:String, param2:* = null):void {
        if (_dispatcher.hasEventListener(param1)) {
            _dispatcher.dispatchEvent(new TeamEvent(param1, param2));
        }
    }

    override public function start():void {
        _teamInfo = LoginInfo.userInfo.teamInfo;
        _memberList = new TeamMemberDataList();
        Connection.addCommandListener(CommandSet.TEAM_INVITE_NOTIFY_1085, onTeamNotify);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, onMapDispose);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapComplete);
        finish();
    }
}
}
