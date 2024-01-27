package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;
import com.taomee.seer2.app.gameRule.door.trails.Trail50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class TrailDoor extends BaseDoor {


    public function TrailDoor(param1:SimpleButton, param2:uint) {
        super(param1, param2, DoorRule.TRAIL_DOOR);
        _doorName = "试炼之门";
        _doorInformation = new DoorLevelInfomation();
        _doorNormalId = 33;
        _door50V50Id = 34;
        _lastDoorRule = -1;
    }

    override protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        if (_doorType == DoorType.Door_NORMAL) {
            _doorSupport = TrailDoorSupport.getInstance();
        } else if (_doorType == DoorType.Door_50V50) {
            _doorSupport = Trail50V50DoorSupport.getInstance();
        }
        super.onDoorEntryClickHandler(param1);
    }
}
}
