package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.gameRule.spt.SptTeMiTiSupport;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_1220 extends MapProcessor {


    private var MAXNUM:int = 25;

    private var oldNum:int;

    private var _npc:SpawnedPet;

    private var fightID:int = 1454;

    public function MapProcessor_1220(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var result:uint = 0;
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_470);
        SptTeMiTiSupport.getInstance().init(_map);
        TweenNano.delayedCall(6, function ():void {
            randomWild();
        });
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightID == FightManager.currentFightRecord.initData.positionIndex) {
                result = FightManager.fightWinnerSide;
                if (result == FightSide.RIGHT) {
                    ModuleManager.showAppModule("ShiHunBeastTipsPanel", {"idx": 2});
                } else if (result == FightSide.LEFT) {
                    ServerMessager.addMessage("收集到1个粘液~");
                    ActiveCountManager.requestActiveCountList([205477, 205476, 205478], function (param1:Parser_1142):void {
                        var par:Parser_1142 = param1;
                        if (par.infoVec[1] == 31 && par.infoVec[2] == 0) {
                            NpcDialog.show(400, "赛尔", [[0, "终于收集齐所有粘液！快去找斯坦因博士吧！ "]], ["把粘液送去给斯坦因博士"], [function ():void {
                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunFirst_1"), function ():void {
                                    NpcDialog.show(106, "斯坦因博士", [[0, "蚀魂兽正在用虫族的方式向外界传递着信息。 "]], [" 也许它遇到危险！我们必须尽快找到蚀魂兽！"], [function ():void {
                                        SwapManager.swapItem(3642, 1, function (param1:IDataInput):void {
                                            new SwapInfo(param1);
                                            ModuleManager.showAppModule("BagginsLogPanel");
                                        });
                                    }]);
                                });
                            }]);
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
                    if (param1.infoVec[0] == 15) {
                        _npc = new SpawnedPet(148, -1, 0);
                        _npc.setPostion(new Point(670, 520));
                        _npc.addEventListener(MouseEvent.CLICK, subNum, false, 1000);
                        MobileManager.addMobile(_npc, MobileType.SPAWNED_PET);
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
                    if (par.infoVec[1] == 31 && par.infoVec[2] == 0) {
                        NpcDialog.show(400, "赛尔", [[0, "终于收集齐所有粘液！快去找斯坦因博士吧！ "]], ["把粘液送去给斯坦因博士"], [function ():void {
                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunFirst_1"), function ():void {
                                NpcDialog.show(106, "斯坦因博士", [[0, "蚀魂兽正在用虫族的方式向外界传递着信息。 "]], [" 也许它遇到危险！我们必须尽快找到蚀魂兽！"], [function ():void {
                                    SwapManager.swapItem(3642, 1, function (param1:IDataInput):void {
                                        new SwapInfo(param1);
                                        ModuleManager.showAppModule("BagginsLogPanel");
                                    });
                                }]);
                            });
                        }]);
                    }
                });
            }, null, new SpecialInfo(1, 4));
        });
    }

    override public function dispose():void {
        SptTeMiTiSupport.getInstance().dispose();
    }
}
}
