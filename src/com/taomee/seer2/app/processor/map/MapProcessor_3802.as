package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

public class MapProcessor_3802 extends MapProcessor {


    private var _bloodTxt:TextField;

    private var _bossMC:MovieClip;

    public function MapProcessor_3802(param1:MapModel) {
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
                if (currSion < 2) {
                    AlertManager.showAlert("神力不足2点，返回基地", function ():void {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                    });
                } else {
                    _bloodTxt = _map.content["bloodTxt"];
                    _bossMC = _map.content["bossMC"];
                    ActiveCountManager.requestActiveCount(203305, function (param1:uint, param2:uint):void {
                        var type:uint = param1;
                        var count:uint = param2;
                        if (count > 700000) {
                            AlertManager.showAlert("累计伤害值已经达到700000，返回基地", function ():void {
                                SceneManager.changeScene(SceneType.LOBBY, 70);
                            });
                        } else {
                            _bloodTxt.text = count + "/700000";
                            _bossMC.buttonMode = true;
                            _bossMC.addEventListener(MouseEvent.CLICK, onBoss);
                        }
                    });
                }
            });
        });
    }

    private function onBoss(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this.isBagHave()) {
            AlertManager.showConfirm("挑战魔化的月神需要扣除2点神力，确认挑战吗？", function ():void {
                FightManager.startFightWithWild(621);
            });
        } else {
            AlertManager.showAlert("背包中必须携带一只狼妖");
        }
    }

    private function isBagHave():Boolean {
        var _loc2_:PetInfo = null;
        var _loc1_:Boolean = false;
        for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
            if (_loc2_.resourceId == 269 || _loc2_.resourceId == 270 || _loc2_.resourceId == 271) {
                _loc1_ = true;
            }
        }
        return _loc1_;
    }
}
}
