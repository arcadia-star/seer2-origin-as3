package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.OptimizeManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.events.MouseEvent;

public class MapProcessor_80300 extends MapProcessor {


    public function MapProcessor_80300(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        OptimizeManager.startOptimize();
        this.initBitMap();
    }

    private function initBitMap():void {
        var _loc1_:Mobile = null;
        for each(_loc1_ in MobileManager.getMobileVec(MobileType.NPC)) {
            _loc1_.addEventListener(MouseEvent.ROLL_OVER, this.onNpcOver);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT, this.onNpcOut);
            _loc1_.animation.gotoAndStop(1);
        }
    }

    private function onNpcOver(param1:MouseEvent):void {
        var _loc2_:Mobile = param1.currentTarget as Mobile;
        _loc2_.animation.gotoAndPlay(2);
    }

    private function onNpcOut(param1:MouseEvent):void {
        var _loc2_:Mobile = param1.currentTarget as Mobile;
        _loc2_.animation.gotoAndStop(1);
    }

    override public function dispose():void {
        var _loc1_:Mobile = null;
        OptimizeManager.dispose();
        for each(_loc1_ in MobileManager.getMobileVec(MobileType.NPC)) {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER, this.onNpcOver);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT, this.onNpcOut);
        }
        super.dispose();
    }
}
}
