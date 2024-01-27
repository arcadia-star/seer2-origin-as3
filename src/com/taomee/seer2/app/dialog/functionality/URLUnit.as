package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.core.ui.UIManager;

import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

public class URLUnit extends BaseUnit {


    public function URLUnit() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.type = FunctionalityType.URL;
    }

    override protected function addIcon():void {
        _icon = UIManager.getSprite("UI_DialogReward");
        addChild(_icon);
    }

    override protected function onBtnClick(param1:MouseEvent):void {
        navigateToURL(new URLRequest(params), "_blank");
        DialogPanel.hide();
    }
}
}
