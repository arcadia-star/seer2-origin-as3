package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.alone.Alone50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.alone.AloneDoorSupport;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class AloneDoor extends BaseDoor {


    public function AloneDoor(param1:SimpleButton, param2:uint) {
        super(param1, param2, DoorRule.ALONE_DOOR);
        _doorName = "孤独之门";
        _doorInformation = new DoorLevelInfomation();
        _doorNormalId = 273;
        _door50V50Id = 274;
        _lastDoorRule = DoorRule.ATLETICO_DOOR;
        _doorTotalLevel = 4;
        _hasContinueButton = false;
    }

    override protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        if (_doorType == DoorType.Door_NORMAL) {
            _doorSupport = AloneDoorSupport.getInstance();
        } else if (_doorType == DoorType.Door_50V50) {
            _doorSupport = Alone50V50DoorSupport.getInstance();
        }
        super.onDoorEntryClickHandler(param1);
    }

    override protected function requestDailyLimit():void {
        super.requestDailyLimit();
        _currentLevelHistory = 1;
    }
}
}
