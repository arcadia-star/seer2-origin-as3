package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_1210 extends MapProcessor {


    private var oldNum:int;

    private var _npc:SpawnedPet;

    private var fightID:int = 1450;

    public function MapProcessor_1210(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var result:uint = 0;
        GrabXiaoYueSeAct.getInstance().setup(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_469);
        this.randomWild();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightID == FightManager.currentFightRecord.initData.positionIndex) {
                result = FightManager.fightWinnerSide;
                if (result == FightSide.RIGHT) {
                    ModuleManager.showAppModule("ShiHunBeastTipsPanel", {"idx": 2});
                } else if (result == FightSide.LEFT) {
                    ServerMessager.addMessage("收集到1个粘液~");
                    ActiveCountManager.requestActiveCountList([205476], function (param1:Parser_1142):void {
                        if (param1.infoVec[0] == 1) {
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
                    if (param1.infoVec[0] == 0) {
                        _npc = new SpawnedPet(414, -1, 0);
                        _npc.setPostion(new Point(721, 576));
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
                    if (par.infoVec[1] == 1) {
                        ModuleManager.showAppModule("ShiHunBeastTipsPanel", {"idx": 1});
                    }
                });
            }, null, new SpecialInfo(1, 0));
        });
    }

    override public function dispose():void {
        GrabXiaoYueSeAct.getInstance().dispose();
        super.dispose();
    }
}
}
