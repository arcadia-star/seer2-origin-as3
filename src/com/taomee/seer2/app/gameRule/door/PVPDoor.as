package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class PVPDoor extends BaseDoor {


    public var beforeClickHandler:Function;

    public var afterClickHandler:Function;

    public function PVPDoor(param1:SimpleButton, param2:uint, param3:uint, param4:Function = null, param5:Function = null) {
        super(param1, param2, param3);
        this.beforeClickHandler = param4;
        this.afterClickHandler = param5;
        TooltipManager.remove(_entryButton);
    }

    override public function dispose():void {
        this.beforeClickHandler = null;
        this.afterClickHandler = null;
        super.dispose();
    }

    override protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        var _loc2_:Boolean = true;
        if (this.beforeClickHandler != null) {
            _loc2_ = this.beforeClickHandler(this);
        }
        if (_loc2_ == false) {
            return;
        }
        var _loc3_:Object = {
            "doorType": _doorType,
            "doorRule": _doorRule
        };
        if (_doorRule == DoorRule.TRAIL_DOOR) {
            _loc3_["minSelectedPetCount"] = 1;
            _loc3_["maxSelectedPetCount"] = 1;
            _loc3_["selectable"] = true;
        } else if (_doorRule == DoorRule.WARRIOR_DOOR) {
            _loc3_["minSelectedPetCount"] = 3;
            _loc3_["maxSelectedPetCount"] = 3;
            _loc3_["selectable"] = true;
        } else if (_doorRule == DoorRule.ATLETICO_DOOR) {
            _loc3_["minSelectedPetCount"] = 3;
            _loc3_["maxSelectedPetCount"] = 3;
            _loc3_["selectable"] = true;
        } else if (_doorRule == DoorRule.HERO_DOOR) {
            _loc3_["minSelectedPetCount"] = 1;
            _loc3_["maxSelectedPetCount"] = 1;
            _loc3_["selectable"] = false;
        } else if (_doorRule == DoorRule.BINARY_DOOR) {
            _loc3_["minSelectedPetCount"] = 2;
            _loc3_["maxSelectedPetCount"] = 2;
            _loc3_["selectable"] = true;
        } else if (_doorRule == DoorRule.WANWANG_DOOR) {
            SceneManager.changeScene(SceneType.LOBBY, 3850);
            return;
        }
        ModuleManager.toggleModule(URLUtil.getAppModule("PVPDoorIntroPanel"), "正在打开门战介绍面板...", _loc3_);
        if (this.afterClickHandler != null) {
            this.afterClickHandler();
        }
    }
}
}
