package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class MapProcessor_3800 extends MapProcessor {


    private var _npc:Mobile;

    public function MapProcessor_3800(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var maxSion:int = 0;
        super.init();
        maxSion = VipManager.vipInfo.isVip() ? 15 : 10;
        ActiveCountManager.requestActiveCount(203301, function (param1:uint, param2:uint):void {
            var type:uint = param1;
            var limitCount:uint = param2;
            DayLimitManager.getDoCount(834, function (param1:uint):void {
                var count:uint = param1;
                var ccount:uint = count > maxSion ? uint(maxSion) : count;
                maxSion += limitCount;
                var currSion:int = maxSion - ccount;
                if (currSion < 1) {
                    AlertManager.showAlert("神力不足1点，返回基地", function ():void {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                    });
                } else {
                    _npc = MobileManager.getMobile(518, MobileType.NPC);
                    _npc.addEventListener(MouseEvent.CLICK, onNpc);
                    ActiveCountManager.requestActiveCount(203302, function (param1:uint, param2:uint):void {
                        var type:uint = param1;
                        var count:uint = param2;
                        if (count >= 10) {
                            AlertManager.showAlert("已经累计胜利了10场，返回基地", function ():void {
                                SceneManager.changeScene(SceneType.LOBBY, 70);
                            });
                        }
                    });
                }
            });
        });
    }

    private function onNpc(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        AlertManager.showConfirm("挑战狼妖将扣除1点神力，确认挑战吗", function ():void {
            FightManager.startFightWithWild(619);
        });
    }
}
}
