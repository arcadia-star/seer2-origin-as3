package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.app.utils.MovieClipUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class Interactive_13 extends BaseAniamationInteractive {


    private var _car:MovieClip;

    private var _mouse:MovieClip;

    private var _mouseHint:MovieClip;

    private var _num:int;

    public function Interactive_13() {
        super();
    }

    override protected function paramAnimation():void {
        this._car = _animation["car"];
        this._mouse = _animation["mouse"];
        this._mouseHint = _animation["mouseHint"];
        this._mouse.buttonMode = true;
        this._num = 0;
        this._mouse.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        ++this._num;
        if (this._num < 10) {
            this._car.gotoAndPlay(2);
        } else {
            this._mouseHint.visible = false;
            this._mouse.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._mouse.buttonMode = false;
            this.win();
        }
    }

    private function win():void {
        MovieClipUtil.playMc(this._car, 9, this._car.totalFrames, function ():void {
            _isSuccess = true;
            dispose();
        }, true);
    }

    override public function dispose():void {
        if (this._mouse) {
            this._mouse.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._mouse = null;
        }
        this._num = 0;
        this._car = null;
        super.dispose();
    }
}
}
