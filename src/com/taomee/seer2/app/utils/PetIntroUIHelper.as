package com.taomee.seer2.app.utils {
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class PetIntroUIHelper {


    private var _mcIntroUI:MovieClip;

    private var _closeIntroBtn:SimpleButton;

    public function PetIntroUIHelper(param1:MovieClip, param2:SimpleButton) {
        super();
        this._mcIntroUI = param1;
        this._mcIntroUI.visible = false;
        this._closeIntroBtn = param1["closeBtn"];
        param2.addEventListener(MouseEvent.CLICK, this.onShowIntro);
    }

    protected function onShowIntro(param1:MouseEvent):void {
        this._mcIntroUI.visible = true;
        this._closeIntroBtn.addEventListener(MouseEvent.CLICK, this.onHideIntro);
    }

    protected function onHideIntro(param1:MouseEvent):void {
        this._closeIntroBtn.removeEventListener(MouseEvent.CLICK, this.onHideIntro);
        this._mcIntroUI.visible = false;
    }
}
}
