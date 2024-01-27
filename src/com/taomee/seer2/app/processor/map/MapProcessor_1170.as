package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.dialog.functionality.BaseUnit;
import com.taomee.seer2.app.dialog.functionality.CustomUnit;
import com.taomee.seer2.app.manager.OnlyFlagManager;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.pet.MysteryNpcYiTeManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.activity.yiteFigthPve.YiTeEndingGetInfo;
import com.taomee.seer2.app.processor.activity.yiteFigthPve.YiteFightPveEntry;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_1170 extends MapProcessor {


    private var _yiteFightPve:YiteFightPveEntry;

    private var _introduction:SimpleButton;

    private var _baodating:SimpleButton;

    private var _yitePvp:SimpleButton;

    private var _baoNpc:Mobile;

    private var _mapmodel:MapModel;

    private const yiteID:int = 183;

    private var yiteNpc:Mobile;

    private var _tipRight:MovieClip;

    public function MapProcessor_1170(param1:MapModel) {
        super(param1);
        this._mapmodel = param1;
    }

    override public function init():void {
        super.init();
        this._yiteFightPve = new YiteFightPveEntry();
        this._introduction = _map.content["introduction"];
        this._introduction.addEventListener(MouseEvent.CLICK, this.onIntroduction);
        this._yitePvp = _map.content["yitePvp"];
        this._yitePvp.addEventListener(MouseEvent.CLICK, this.onYitePvp);
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onActorArriveShow);
    }

    protected function gotoShop(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("ShopPanel"), "");
    }

    private function onYitePvp(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("YitePvpFight"), "正在打开...");
    }

    private function onIntroduction(param1:MouseEvent):void {
        var _loc2_:Object = new Object();
        _loc2_.index = 100;
        ModuleManager.showModule(URLUtil.getAppModule("StartYiteFightPvePanel"), "正在打开...", _loc2_);
    }

    private function onActorArriveShow(param1:DialogPanelEvent):void {
        var a:BaseUnit = null;
        var b:BaseUnit = null;
        var unit1:CustomUnit = null;
        var unit2:CustomUnit = null;
        var e:DialogPanelEvent = param1;
        if (uint(e.content) == 151) {
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
            if (MysteryNpcYiTeManager.isActivityON) {
                a = DialogPanel.functionalityBox.getUnit("小道消息");
                b = DialogPanel.functionalityBox.getUnit("活动规则");
                if (!a) {
                    unit1 = new CustomUnit(FunctionalityType.ACTIVE, "小道消息", "151");
                    DialogPanel.functionalityBox.addUnit(unit1);
                }
                if (!b) {
                    unit2 = new CustomUnit(FunctionalityType.ACTIVE, "活动规则", "guize");
                    DialogPanel.functionalityBox.addUnit(unit2);
                }
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUint);
            } else {
                NpcDialog.show(151, "包打听", [[0, "暂时没有得到小道消息，过会儿再来吧"]], ["活动规则", "那我再逛逛"], [function ():void {
                    ModuleManager.showModule(URLUtil.getAppModule("YiTeZaChangZi"), "");
                }, null]);
            }
        }
    }

    private function onUint(param1:DialogPanelEvent):void {
        var e:DialogPanelEvent = param1;
        if (e.content.params == "guize") {
            ModuleManager.showModule(URLUtil.getAppModule("YiTeZaChangZi"), "");
        }
        if (e.content.params == String(151)) {
            NpcDialog.show(151, "包打听", [[0, "神伊特带着它的NONO来破坏我们的闭幕式了！它们处处搞破坏，还偷走了" + "<font color=\'#ff00ff\'>战魂</font>" + "和" + "<font color=\'#ff00ff\'>宝藏</font>" + "，打赢他才可以夺回来，你有兴趣吗？"]], ["这我很感兴趣"], [function ():void {
                NpcDialog.show(151, "包打听", [[0, "嘿嘿，如果你感兴趣的话可以给我5000赛尔豆，我就告诉你此时此刻他在哪里。你得赶快去，不然他要逃走了。"]], ["花费5000赛尔豆打听消息", " 还是算了"], [function ():void {
                    var id:* = MysteryNpcYiTeManager.currentYiTeMapId;
                    var isOn:* = MysteryNpcYiTeManager.isActivityON;
                    if (!id || !isOn) {
                        AlertManager.showAlert("它现在已经不知去向了！");
                        return;
                    }
                    if (ActorManager.actorInfo.coins >= 5000) {
                        SwapManager.swapItem(1155, 1, function (param1:IDataInput):void {
                            new SwapInfo(param1, false);
                            ServerMessager.addMessage("你花费了5000赛尔豆");
                            var _loc2_:* = MysteryNpcYiTeManager.currentYiTeMapId;
                            var _loc3_:* = new Date(TimeManager.getServerTime() * 1000);
                            var _loc4_:* = int(_loc3_.minutes / 15);
                            var _loc5_:* = 14 + _loc4_ * 15 - _loc3_.minutes;
                            var _loc6_:*;
                            (_loc6_ = {}).mapid = _loc2_;
                            _loc6_.leftTime = _loc5_;
                            ModuleManager.showModule(URLUtil.getAppModule("MysteryBaodating"), "", _loc6_);
                        });
                    } else {
                        AlertManager.showAlert("没有足够的赛尔豆");
                    }
                }, null]);
            }]);
        }
    }

    private function clickYiTe(param1:MouseEvent):void {
        var onlyNum:int = 0;
        var e:MouseEvent = param1;
        if (YiTeEndingGetInfo.getInstance().selfRank == -1) {
            NpcDialog.show(this.yiteID, "颁奖嘉宾", [[0, "耶？你没有参加过比赛"]], ["打搅两位伊特老大了，闪！"], [null]);
        } else {
            onlyNum = YiTeEndingGetInfo.getInstance().selfRank == 0 ? 698 : 699;
            OnlyFlagManager.RequestFlag(function ():void {
                var userTeamName:String = null;
                var userName:String = null;
                var rank:String = null;
                var diag:String = null;
                if (OnlyFlagManager.getFlag(onlyNum) == 1) {
                    YiTeEndingGetInfo.getInstance().hasGetAward = 1;
                    NpcDialog.show(yiteID, "颁奖嘉宾", [[0, "耶？奖品已经领过了。"]], ["打搅两位伊特老大了，闪！"], [null]);
                } else {
                    YiTeEndingGetInfo.getInstance().hasGetAward = 0;
                    if (YiTeEndingGetInfo.getInstance().currentTeamID == 603030) {
                        userTeamName = "<font color=\'#ff00ff\'>光战队</font>";
                    }
                    if (YiTeEndingGetInfo.getInstance().currentTeamID == 603031) {
                        userTeamName = "<font color=\'#ff00ff\'>影战队</font>";
                    }
                    userName = "<font color=\'#ff00ff\'>" + ActorManager.actorInfo.nick + "</font>";
                    rank = YiTeEndingGetInfo.getInstance().selfRank == 0 ? "<font color=\'#ff00ff\'>冠军</font>" : "<font color=\'#ff00ff\'>亚军</font>";
                    diag = userTeamName + "的" + userName + "?" + "就是你吗？不错！谢谢你捍卫了我们伊特家族的荣誉和信仰！请接受属于你的" + rank + "奖励！";
                    NpcDialog.show(yiteID, "颁奖嘉宾", [[0, diag]], ["我要领奖!", "想一下获奖感言再领."], [function ():void {
                        var teamID:*;
                        var ranknum:*;
                        var award:* = undefined;
                        var mvPath:* = undefined;
                        if (YiTeEndingGetInfo.getInstance().selfRank == 0) {
                            award = "你的奖品是：伊特金锦旗（手部装扮）、伊特龙甲套装、精灵成长精华（20W经验）、1级物攻、特攻、物防、特防药剂各4个";
                        } else if (YiTeEndingGetInfo.getInstance().selfRank == 1) {
                            award = "你的奖品是：伊特银锦旗（手部装扮）、精灵成长精片（10W经验）、1级物攻、特攻、物防、特防药剂各2个";
                        }
                        teamID = YiTeEndingGetInfo.getInstance().currentTeamID;
                        ranknum = YiTeEndingGetInfo.getInstance().selfRank;
                        if (teamID == 603030) {
                            mvPath = ranknum == 0 ? "getaward/guangGuan" : "getaward/yingGuan";
                        }
                        if (teamID == 603031) {
                            mvPath = ranknum == 0 ? "getaward/yingGuan" : "getaward/guangGuan";
                        }
                        NpcDialog.show(yiteID, "颁奖嘉宾", [[0, award]], ["奖品超赞的！给我给我都给我！"], [function ():void {
                            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation(mvPath), function ():void {
                                getAward();
                            }, true, false, 2);
                        }]);
                    }, null]);
                }
            });
        }
    }

    private function getAward():void {
        var onlyNum:int = 0;
        var swapid:int = YiTeEndingGetInfo.getInstance().selfRank == 0 ? 1163 : 1164;
        onlyNum = YiTeEndingGetInfo.getInstance().selfRank == 0 ? 698 : 699;
        SwapManager.swapItem(swapid, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            OnlyFlagManager.updataFlag(onlyNum, 1);
            YiTeEndingGetInfo.getInstance().hasGetAward = 1;
        });
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
