package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.app.rightToolbar.RightToolbarTimeCheck;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class TorchRelayorToolbar extends RightToolbar {


    public function TorchRelayorToolbar() {
        super();
    }

    public static function playFullMovie():void {
        RightToolbarTimeCheck.openUIBuf(2);
        ModuleManager.toggleModule(URLUtil.getAppModule("TorchRelayPanel"), "……");
    }

    override protected function onClick(param1:MouseEvent):void {
        playFullMovie();
    }
}
}
