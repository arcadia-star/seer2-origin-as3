package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.binary.BinaryDoorSupport;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class BinaryDoor extends BaseDoor {

    public static const BINARY_SCENE_MAPID_1:uint = 420;

    public static const BINARY_SCENE_MAPID_2:uint = 421;


    public function BinaryDoor(param1:SimpleButton, param2:uint) {
        super(param1, param2, DoorRule.BINARY_DOOR);
        _doorName = "双子之门";
        _doorInformation = new DoorLevelInfomation();
        _doorNormalId = 298;
        _door50V50Id = 299;
        _lastDoorRule = DoorRule.BINARY_DOOR;
        _doorTotalLevel = 42;
        _hasContinueButton = true;
    }

    override protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        if (_doorType == DoorType.Door_NORMAL) {
            _doorSupport = BinaryDoorSupport.getInstance();
        } else if (_doorType == DoorType.Door_50V50) {
            return;
        }
        super.onDoorEntryClickHandler(param1);
    }
}
}
