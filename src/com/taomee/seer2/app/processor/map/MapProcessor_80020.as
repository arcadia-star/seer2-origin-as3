package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.RabitDressAct.RabitDressAct;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_80020 extends TitleMapProcessor {


    private var _rabitAct:RabitDressAct;

    private var sceneInteractiveVec:Vector.<MovieClip>;

    public function MapProcessor_80020(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var _loc1_:int = 0;
        this._rabitAct = new RabitDressAct(_map);
        this.sceneInteractiveVec = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 2) {
            this.sceneInteractiveVec.push(_map.ground["interactive" + _loc1_]);
            this.sceneInteractiveVec[_loc1_].gotoAndStop(1);
            this.sceneInteractiveVec[_loc1_].buttonMode = true;
            this.sceneInteractiveVec[_loc1_].mouseChildren = false;
            this.sceneInteractiveVec[_loc1_].addEventListener(MouseEvent.CLICK, this.playMc);
            _loc1_++;
        }
    }

    private function playMc(param1:MouseEvent):void {
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        mc = event.target as MovieClip;
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            mc.gotoAndStop(1);
        });
    }

    override public function dispose():void {
        this._rabitAct.dispose();
        this._rabitAct = null;
        var _loc1_:int = 0;
        while (_loc1_ < 2) {
            this.sceneInteractiveVec[_loc1_].removeEventListener(MouseEvent.CLICK, this.playMc);
            _loc1_++;
        }
        super.dispose();
    }
}
}
