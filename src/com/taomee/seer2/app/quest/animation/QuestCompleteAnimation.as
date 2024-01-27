package com.taomee.seer2.app.quest.animation {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;

public class QuestCompleteAnimation {


    private var _mc:MovieClip;

    public function QuestCompleteAnimation(param1:int = 0) {
        super();
        if (param1 == 1) {
            this._mc = UIManager.getMovieClip("UI_Quest_StarComplete");
        } else {
            this._mc = UIManager.getMovieClip("UI_QuestComplete");
        }
        this._mc.x = 120;
        this._mc.y = 95;
        this._mc.gotoAndStop(1);
    }

    public function play():void {
        this._mc.addEventListener(Event.ENTER_FRAME, this.onAnimationEnd);
        LayerManager.topLayer.addChild(this._mc);
        this._mc.gotoAndPlay(2);
    }

    private function onAnimationEnd(param1:Event):void {
        if (this._mc.currentFrame == this._mc.totalFrames) {
            this._mc.removeEventListener(Event.ENTER_FRAME, this.onAnimationEnd);
            DisplayObjectUtil.removeFromParent(this._mc);
        }
    }
}
}
