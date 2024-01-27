package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;
import com.taomee.seer2.app.gameRule.door.hero.Hero50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.hero.HeroDoorSupport;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class HeroDoor extends BaseDoor {


    public function HeroDoor(param1:SimpleButton, param2:uint) {
        super(param1, param2, DoorRule.HERO_DOOR);
        _doorName = "英雄之门";
        _doorInformation = new DoorLevelInfomation();
        _doorNormalId = 273;
        _door50V50Id = 274;
        _lastDoorRule = DoorRule.ATLETICO_DOOR;
        _doorTotalLevel = 21;
        _hasContinueButton = true;
    }

    override protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        if (_doorType == DoorType.Door_NORMAL) {
            _doorSupport = HeroDoorSupport.getInstance();
        } else if (_doorType == DoorType.Door_50V50) {
            _doorSupport = Hero50V50DoorSupport.getInstance();
        }
        super.onDoorEntryClickHandler(param1);
    }
}
}
