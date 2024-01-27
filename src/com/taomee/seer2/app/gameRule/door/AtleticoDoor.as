package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.atletico.Atletico50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.atletico.AtleticoDoorSupport;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class AtleticoDoor extends BaseDoor {


    public function AtleticoDoor(param1:SimpleButton, param2:uint) {
        super(param1, param2, DoorRule.ATLETICO_DOOR);
        _doorName = "竞技之门";
        _doorInformation = new DoorLevelInfomation();
        _doorNormalId = 67;
        _door50V50Id = 68;
        _lastDoorRule = DoorRule.WARRIOR_DOOR;
    }

    override protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        if (_doorType == DoorType.Door_NORMAL) {
            _doorSupport = AtleticoDoorSupport.getInstance();
        } else if (_doorType == DoorType.Door_50V50) {
            _doorSupport = Atletico50V50DoorSupport.getInstance();
        }
        super.onDoorEntryClickHandler(param1);
    }
}
}
