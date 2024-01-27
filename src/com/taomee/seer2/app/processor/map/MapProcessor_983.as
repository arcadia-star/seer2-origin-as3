package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.MineManger;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_983 extends MapProcessor {


    private const ARMY_ID:uint = 202997;

    private const SWAP_RANK_REWARD:uint = 1759;

    private const NPC_IDS:Array = [3, 190, 195];

    private const NPC_NAME:Array = ["上尉门罗", "金", "上尉罗文"];

    private const ARMY_NAME:Array = ["激浪队", "热火队", "原野队"];

    private const RANK_NAME:Array = ["冠军", "亚军", "季军"];

    private const REWARD_DES:Array = ["<font color=\'#ff0000\'>冠军称号及勋章、1个冠军金翼、80W经验、50块争霸赛奖牌、20万赛尔豆、1个至尊资质果实、2个战斗药包！</font>", "<font color=\'#ff0000\'>亚军称号及勋章、1个亚军银翼、40W经验、20块争霸赛奖牌、10万赛尔豆、2个高级资质果实、1个战斗药包！ </font>", "<font color=\'#ff0000\'>季军称号及勋章、1个季军铜翼、20W经验、10块争霸赛奖牌、5万赛尔豆、1个初级资质果实！</font>"];

    private var _scoreGate:SimpleButton;

    private var _ruleGate:SimpleButton;

    private var _awardOne:SimpleButton;

    private var _awardTwo:SimpleButton;

    private var _actBtn:SimpleButton;

    private var _awardState:Vector.<int>;

    private const AWARD_STATE_DAY:Vector.<int> = Vector.<int>([764, 765]);

    private const AWARD_MINE:Vector.<int> = Vector.<int>([254, 255]);

    private var army_value:uint;

    private var army_Name:String;

    private var hasGet:Boolean;

    private var yueMiYa:Mobile;

    private var seMiYa:Mobile;

    private var miya:Array;

    private const npcIdList:Array = [596, 600];

    private const fightidList:Array = [568, 569];

    private const npcnameList:Array = ["约咪娅", "瑟咪娅"];

    private const npcStringList:Array = ["咪娅咪娅，我是约咪娅！哦吼~快点冲啊，快来给我加油！", "赛跑赛跑！不停的向前跑，我是瑟咪娅，我为赛跑代言。"];

    private const miyaPosition:Array = [new Point(353, 448), new Point(552, 448)];

    public function MapProcessor_983(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.petKingInit();
        this.createMiya();
        this.initOver();
    }

    private function initOver():void {
        StatisticsManager.sendNovice("0x10034060");
        this._actBtn = _map.content["allActBtn"];
        this._actBtn.addEventListener(MouseEvent.CLICK, this.showActPanel);
        ActiveCountManager.requestActiveCountList([this.ARMY_ID, 203101], this.getArmy);
    }

    private function showActPanel(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("PetkingMatch2ConcludePanel"), "");
    }

    private function getArmy(param1:Parser_1142):void {
        this.army_value = param1.infoVec[0];
        this.hasGet = Boolean(param1.infoVec[1]);
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
    }

    private function onActorArriveShow(param1:NpcEvent):void {
        var date:uint;
        var npcid:uint = 0;
        var npcName:String = null;
        var event:NpcEvent = param1;
        npcid = uint(event.npcDefinition.id);
        npcName = String(this.NPC_NAME[this.NPC_IDS.indexOf(npcid)]);
        if (this.NPC_IDS.indexOf(npcid) == -1) {
            return;
        }
        date = new Date(2013, 7, 24, 13).getTime() / 1000;
        if (this.army_value == 0) {
            NpcDialog.show(npcid, npcName, [[0, "哦？" + ActorManager.actorInfo.nick + "….名单里没有你哦，你应该没有参加过今年的比赛吧。你可以去参加颁奖礼上其他有奖活动。 "]], ["哦，知道了"]);
            return;
        }
        if (TimeManager.getServerTime() < date) {
            NpcDialog.show(npcid, npcName, [[0, "颁奖典礼将在8月24日13:00开始哦（有神秘嘉宾哦）。现在你可以先去参加典礼的其它活动 "]], ["哦，知道了"], [function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("PetkingMatch2ConcludePanel"));
            }]);
            return;
        }
        if (this.army_value - 1 != this.NPC_IDS.indexOf(npcid)) {
            NpcDialog.show(npcid, npcName, [[0, "你不是我们队的队员哦，请去找另外两位队长领奖吧！"]], ["打搅了！闪！"]);
            return;
        }
        if (this.hasGet) {
            NpcDialog.show(npcid, npcName, [[0, "奖品已经领过啦。记得参加明年的争霸赛，奖品一定更丰富！"]], ["哦…我领过啦？队长您记性还真好哇。"]);
        } else {
            NpcDialog.show(npcid, npcName, [[0, "经过数周的激战，我们的第二届精灵争霸赛落下帷幕了，祝贺你 " + ActorManager.actorInfo.nick + "！ " + this.ARMY_NAME[this.army_value - 1] + "为你而自豪。 请接受属于你的" + this.RANK_NAME[this.army_value - 1] + "奖励！"]], ["我要领奖！", "想一下获奖感言再领..."], [function ():void {
                NpcDialog.show(npcid, npcName, [[0, "你的" + RANK_NAME[army_value - 1] + "奖品是:" + REWARD_DES[army_value - 1]]], ["谢谢队长 我会更加努力的！"], [function ():void {
                    SwapManager.swapItem(SWAP_RANK_REWARD, 1, getReward);
                }]);
            }]);
        }
    }

    private function getReward(param1:IDataInput):void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("petKingMatch2OverFull"));
        new SwapInfo(param1);
        this.hasGet = true;
    }

    private function petKingInit():void {
        this._scoreGate = _map.content["scoreGate"];
        this._ruleGate = _map.content["ruleGate"];
        this._scoreGate.addEventListener(MouseEvent.CLICK, this.onGate);
        this._ruleGate.addEventListener(MouseEvent.CLICK, this.onGate);
    }

    private function onGate(param1:MouseEvent):void {
        switch (param1.currentTarget) {
            case this._scoreGate:
                ModuleManager.showModule(URLUtil.getAppModule("PetKingMainPanel"), "正在打开精灵争霸赛积分面板...");
                break;
            case this._ruleGate:
                ModuleManager.showModule(URLUtil.getAppModule("PetKingRulePanel"), "正在打开精灵争霸赛规则面板...");
        }
    }

    private function onAward(param1:MouseEvent):void {
        var data:LittleEndianByteArray = null;
        var curTarget:SimpleButton = null;
        var evt:MouseEvent = param1;
        this._awardOne.mouseEnabled = false;
        this._awardTwo.mouseEnabled = false;
        if (!this._awardState) {
            data = new LittleEndianByteArray();
            data.writeUnsignedInt(2);
            data.writeUnsignedInt(this.AWARD_STATE_DAY[0]);
            data.writeUnsignedInt(this.AWARD_STATE_DAY[1]);
            curTarget = evt.currentTarget as SimpleButton;
            DayLimitListManager.getDoCount(data, function (param1:DayLimitListInfo):void {
                _awardState = new Vector.<int>();
                _awardState.push(param1.getCount(AWARD_STATE_DAY[0]));
                _awardState.push(param1.getCount(AWARD_STATE_DAY[1]));
                awardHandle(curTarget);
            });
        } else {
            this.awardHandle(evt.currentTarget as SimpleButton);
        }
    }

    private function awardHandle(param1:SimpleButton):void {
        var target:SimpleButton = param1;
        if (target == this._awardOne) {
            if (this._awardState[0] == 0) {
                MineManger.getMineItem(this.AWARD_MINE[0], function (param1:Parser_1060):void {
                    param1.showResult(true, null, true);
                    _awardState[0] = 1;
                    _awardOne.mouseEnabled = true;
                    _awardTwo.mouseEnabled = true;
                }, function ():void {
                    _awardOne.mouseEnabled = true;
                    _awardTwo.mouseEnabled = true;
                });
            } else {
                AlertManager.showAlert("今天已领取过了!");
                this._awardOne.mouseEnabled = true;
                this._awardTwo.mouseEnabled = true;
            }
        }
        if (target == this._awardTwo) {
            if (this._awardState[1] == 0) {
                MineManger.getMineItem(this.AWARD_MINE[1], function (param1:Parser_1060):void {
                    param1.showResult(true, null, true);
                    _awardState[1] = 1;
                    _awardOne.mouseEnabled = true;
                    _awardTwo.mouseEnabled = true;
                }, function ():void {
                    _awardOne.mouseEnabled = true;
                    _awardTwo.mouseEnabled = true;
                });
            } else {
                AlertManager.showAlert("今天已领取过了!");
                this._awardOne.mouseEnabled = true;
                this._awardTwo.mouseEnabled = true;
            }
        }
    }

    private function petKingDispose():void {
        if (this._scoreGate) {
            this._scoreGate.removeEventListener(MouseEvent.CLICK, this.onGate);
            this._scoreGate = null;
        }
        if (this._ruleGate) {
            this._ruleGate.removeEventListener(MouseEvent.CLICK, this.onGate);
            this._ruleGate = null;
        }
        if (this._awardOne) {
            this._awardOne.removeEventListener(MouseEvent.CLICK, this.onAward);
            this._awardOne = null;
        }
        if (this._awardTwo) {
            this._awardTwo.removeEventListener(MouseEvent.CLICK, this.onAward);
            this._awardTwo = null;
        }
    }

    private function createMiya():void {
        var _loc1_:Mobile = null;
        this.miya = [];
        var _loc2_:int = 0;
        while (_loc2_ < 2) {
            _loc1_ = new Mobile();
            _loc1_.resourceUrl = URLUtil.getNpcSwf(this.npcIdList[_loc2_]);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK, this.onNpcClick);
            _loc1_.setPostion(this.miyaPosition[_loc2_]);
            MobileManager.addMobile(_loc1_, MobileType.NPC);
            this.miya.push(_loc1_);
            _loc2_++;
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var index:int = 0;
        var left:int = 0;
        var e:MouseEvent = param1;
        index = this.miya.indexOf(e.currentTarget as Mobile);
        left = 0;
        DayLimitManager.getDoCount(796, function (param1:uint):void {
            if (ActorManager.actorInfo.vipInfo.isVip()) {
                left = 10 - param1;
            } else {
                left = 6 - param1;
            }
        });
        NpcDialog.show(this.npcIdList[index], this.npcnameList[index], [[0, this.npcStringList[index]]], ["给" + this.npcnameList[index] + "加油", "游戏规则", "我休息一下"], [function ():void {
            if (left > 0) {
                NpcDialog.show(npcIdList[index], npcnameList[index], [[0, "嘿嘿，人生就是不停的向前跑，一路上少不了加油声，准备好和我战斗给我加油了吗？对了你还可以捕捉我，我5回合会逃跑哟！"]], ["开始加油战斗", ["我准备一下"]], [function ():void {
                    FightManager.startFightWithWild(fightidList[index]);
                }]);
            } else {
                NpcDialog.show(npcIdList[index], npcnameList[index], [[0, "感谢你今天给我加油了这么多次，你可以明天再来给我加油哟！"]], ["明天再来"]);
            }
        }, function ():void {
            ModuleManager.toggleModule(URLUtil.getAppModule("MiyaForwardPanel"));
        }, null]);
    }

    private function disposeMiya():void {
        var _loc1_:int = 0;
        while (_loc1_ < this.miya.length) {
            (this.miya[_loc1_] as Mobile).removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            MobileManager.removeMobile(this.miya[_loc1_], MobileType.NPC);
            _loc1_++;
        }
        this.miya = null;
    }

    override public function dispose():void {
        this.petKingDispose();
        this.disposeMiya();
        super.dispose();
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
        if (this._actBtn) {
            this._actBtn.removeEventListener(MouseEvent.CLICK, this.showActPanel);
        }
    }
}
}
