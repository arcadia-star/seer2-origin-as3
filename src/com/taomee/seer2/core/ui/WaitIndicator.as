package com.taomee.seer2.core.ui {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

public class WaitIndicator extends Sprite {


    private var _mc:MovieClip;

    public function WaitIndicator() {
        super();
        this._mc = UIManager.getMovieClip("UI_WaitForServer");
        this._mc.gotoAndStop(1);
        addChild(this._mc);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedToStage);
    }

    public function dispose():void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedToStage);
        if (this._mc) {
            this._mc.gotoAndStop(1);
            this._mc = null;
        }
    }

    private function onAddedToStage(param1:Event):void {
        this._mc.gotoAndPlay(2);
    }

    private function onRemovedToStage(param1:Event):void {
        this._mc.gotoAndStop(1);
    }
}
}
