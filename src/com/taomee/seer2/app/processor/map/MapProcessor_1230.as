package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_1230 extends MapProcessor {


    private var _npc:Mobile;

    private var _arrow0:Sprite;

    private var _arrow1:Sprite;

    private var MAXNUM:int = 20;

    private var oldNum:int;

    private var _npc1:SpawnedPet;

    private var fightID:int = 1452;

    private var _npc106:Mobile;

    private var _mark:AcceptableMark;

    public function MapProcessor_1230(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var result:uint = 0;
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_479);
        this._arrow0 = _map.content["arrow0"];
        this._arrow1 = _map.content["arrow1"];
        if (!QuestManager.isAccepted(66) || QuestManager.isComplete(66)) {
            this._arrow0.visible = false;
            this._arrow1.visible = false;
        }
        this._npc = new Mobile();
        this._npc.width = 75;
        this._npc.height = 115;
        this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
        this._npc.label = "马丽奥";
        this._npc.setPostion(new Point(160, 330));
        this._npc.resourceUrl = URLUtil.getNpcSwf(325);
        this._npc.buttonMode = true;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        this.randomWild();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightID == FightManager.currentFightRecord.initData.positionIndex) {
                result = FightManager.fightWinnerSide;
                if (result == FightSide.RIGHT) {
                    ModuleManager.showAppModule("ShiHunBeastTipsPanel", {"idx": 2});
                } else if (result == FightSide.LEFT) {
                    ServerMessager.addMessage("收集到1个粘液~");
                    ActiveCountManager.requestActiveCountList([205476], function (param1:Parser_1142):void {
                        if (param1.infoVec[0] == 7) {
                            ModuleManager.showAppModule("ShiHunBeastTipsPanel", {"idx": 1});
                        }
                    });
                }
            }
        }
    }

    private function randomWild():void {
        DayLimitManager.getDoCount(1569, function (param1:int):void {
            var count:int = param1;
            if (count == 0) {
                ActiveCountManager.requestActiveCountList([205476], function (param1:Parser_1142):void {
                    if (param1.infoVec[0] == 3) {
                        _npc1 = new SpawnedPet(203, -1, 0);
                        _npc1.setPostion(new Point(203, 576));
                        _npc1.addEventListener(MouseEvent.CLICK, subNum, false, 1000);
                        MobileManager.addMobile(_npc1, MobileType.SPAWNED_PET);
                    }
                });
            }
        });
    }

    protected function subNum(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        ActiveCountManager.requestActiveCountList([205477], function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            oldNum = par.infoVec[0];
            SwapManager.swapItem(3640, 1, function (param1:IDataInput):void {
                var data:IDataInput = param1;
                new SwapInfo(data);
                ActiveCountManager.requestActiveCountList([205477, 205476, 205478], function (param1:Parser_1142):void {
                    var par:Parser_1142 = param1;
                    if (par.infoVec[0] - oldNum > 0) {
                        ServerMessager.addMessage("运气真好！粘液滴在了地上~");
                    } else {
                        DayLimitManager.getDoCount(1570, function (param1:int):void {
                            if (param1 == 1) {
                                FightManager.startFightWithWild(fightID);
                            }
                        });
                    }
                    if (par.infoVec[1] == 7) {
                        ModuleManager.showAppModule("ShiHunBeastTipsPanel", {"idx": 1});
                    }
                });
            }, null, new SpecialInfo(1, 2));
        });
    }

    private function createNpc106():void {
        this._npc106 = new Mobile();
        this._npc106.setPostion(new Point(529, 365));
        this._npc106.label = "斯坦因博士";
        this._npc106.resourceUrl = URLUtil.getNpcSwf(106);
        this._npc106.buttonMode = true;
        this._mark = new AcceptableMark();
        this._npc106.addChild(this._mark);
        this._mark.y = -100;
        MobileManager.addMobile(this._npc106, MobileType.NPC);
        this._npc106.addEventListener(MouseEvent.CLICK, this.dialogShow);
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(106, "斯坦因博士", [[0, "你看着好眼熟，我们是不是在哪见过？哦！我想起来了。  "]], [" 果然是斯坦因博士！我真是聪明！"], [function ():void {
            NpcDialog.show(400, "赛尔", [[0, "巴金斯日志提示我们有蚀魂兽的信息，博士你有什么情报吗？ "]], ["博士总有第一手消息。"], [function ():void {
                NpcDialog.show(106, "斯坦因博士", [[0, "没错，最近的确有一些迹象指引我来到这里。  "]], ["快告诉我吧！"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunFirst_0"), function ():void {
                        NpcDialog.show(106, "斯坦因博士", [[0, "这迹象应该和虫群氏族的灵兽——蚀魂兽有着联系。  "]], ["蚀魂兽已经消失了很多年，为什么现在又出现了？"], [function ():void {
                            NpcDialog.show(106, "斯坦因博士", [[0, "我已经一把年纪了，雷达上的目标跑的太快，只有年轻人才能追的上它们。具体情况等你们去调查一下才能知道！快去快回！  "]], ["那好吧，我这就去！"], [function ():void {
                                if (_mark != null) {
                                    DisplayObjectUtil.removeFromParent(_mark);
                                }
                                ServerBufferManager.updateServerBuffer(ServerBufferType.SHIHUNBEAST_FIRST_CHARPTER, 1, 2);
                                ModuleManager.showAppModule("BagginsLogPanel", {"idx": 2});
                            }]);
                        }]);
                    });
                }]);
            }]);
        }]);
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (Boolean(DateUtil.isInHourScope(12, 13, 0, 0) || DateUtil.isInHourScope(18, 19, 0, 0))) {
            NpcDialog.show(325, "马丽奥", [[0, "嘻嘻嘻，来陪我玩游戏吧，我有好多游戏可以和你一起玩哟~"]], ["后花园游乐场", "我不喜欢玩游戏"], [function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("GardenParkPanel"), "正在打开后花园主面板...");
            }]);
        } else {
            NpcDialog.show(325, "马丽奥", [[0, "嘻嘻嘻，现在还没有到游乐场开放的时间哟，请每日的<font color=\'#ff3300\'>12:00至13:00、18:00至19:00</font>来找我玩吧。"]], ["那我过会再来吧"], []);
        }
    }
}
}
