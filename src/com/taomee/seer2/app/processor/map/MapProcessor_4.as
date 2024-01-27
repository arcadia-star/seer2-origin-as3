package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_4 extends TitleMapProcessor {

    private static const MOVESKYCONST:int = 1;

    private static const MOVESKYMAX:int = 0;

    private static const MOVESKYMIN:int = -500;


    private var _starrySky:MovieClip;

    private var _moveSkyType:int;

    private var _skyInterval:int;

    public function MapProcessor_4(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
    }

    private function initStarrySky():void {
        this._skyInterval = 0;
        this._starrySky = _map.far["starrySky"];
        this._starrySky.addEventListener(Event.ENTER_FRAME, this.moveSky);
    }

    private function moveSky(param1:Event):void {
        ++this._skyInterval;
        if (this._skyInterval == 2) {
            this._skyInterval = 0;
            if (this._starrySky.x == MOVESKYMAX) {
                this._moveSkyType = 1;
            }
            if (this._starrySky.x == MOVESKYMIN) {
                this._moveSkyType = 0;
            }
            if (this._moveSkyType == 1) {
                this._starrySky.x -= MOVESKYCONST;
            } else {
                this._starrySky.x += MOVESKYCONST;
            }
            return;
        }
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
