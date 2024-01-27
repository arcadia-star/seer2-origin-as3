package com.taomee.seer2.app.dream {
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class DreamSystemTeleport extends Teleport {


    public function DreamSystemTeleport() {
        super();
    }

    override public function setData(param1:XML):void {
        super.setData(param1);
    }

    override public function onMouseClick(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("DreamTeleportPanel"), "");
        param1.stopImmediatePropagation();
    }

    override public function dispose():void {
        super.dispose();
    }

    protected function cancelHandler():void {
    }
}
}
