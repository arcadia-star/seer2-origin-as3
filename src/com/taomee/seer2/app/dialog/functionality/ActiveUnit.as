package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.app.actives.IActiveProcess;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.core.ui.UIManager;

import flash.events.MouseEvent;
import flash.system.ApplicationDomain;

public class ActiveUnit extends BaseUnit {


    public function ActiveUnit() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.type = FunctionalityType.ACTIVE;
    }

    override protected function addIcon():void {
        _icon = UIManager.getSprite("UI_DialogReward");
        addChild(_icon);
    }

    override protected function onBtnClick(param1:MouseEvent):void {
        var _loc2_:String = "com.taomee.seer2.app.actives.ActiveProcess_" + params;
        var _loc3_:Class = ApplicationDomain.currentDomain.getDefinition(_loc2_) as Class;
        var _loc4_:IActiveProcess;
        (_loc4_ = new _loc3_()).start();
        DialogPanel.hide("");
    }
}
}
