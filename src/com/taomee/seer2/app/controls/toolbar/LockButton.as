package com.taomee.seer2.app.controls.toolbar {
import com.taomee.seer2.core.ui.UIManager;

import flash.events.MouseEvent;

public class LockButton extends ToolBarButton {


    public function LockButton() {
        super();
    }

    override protected function createChildren():void {
        _button = UIManager.getMovieClip("UI_Toolbar_LockBtn");
        _button.x = 905;
        _button.y = 25;
        addChild(_button);
    }

    override protected function initTip():void {
    }

    override protected function excuteIteractive(param1:MouseEvent):void {
    }
}
}
