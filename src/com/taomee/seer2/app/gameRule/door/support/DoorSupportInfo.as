package com.taomee.seer2.app.gameRule.door.support {
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.gameRule.door.BinaryDoor;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;

public class DoorSupportInfo {


    public var doorRule:int;

    public var doorType:int;

    public var doorStartPanel:String;

    public var currentDoorLevel:uint = 1;

    public var reset:Boolean = false;

    public var neverToMaxLevel:Boolean = true;

    private var _targetMapId:uint;

    public function DoorSupportInfo(param1:int, param2:int, param3:uint, param4:String) {
        this.doorRule = param1;
        this.doorType = param2;
        this._targetMapId = param3;
        this.doorStartPanel = param4;
        super();
    }

    public function get fightMode():int {
        if (this.doorType == DoorType.Door_NORMAL) {
            return FightMode.FIGHT_DOOR_NORMAL;
        }
        if (this.doorType == DoorType.Door_50V50) {
            return FightMode.FIGHT_DOOR_50V50;
        }
        if (this.doorType == DoorType.PVP_Door_50V50) {
            return FightMode.FIGHT_PVP_DOOR_50V50;
        }
        if (this.doorType == DoorType.PVP_Door_NORMAL) {
            return FightMode.FIGHT_PVP_DOOR_NORMAL;
        }
        return 0;
    }

    public function get targetMapId():uint {
        if (this.doorRule == DoorRule.BINARY_DOOR && this.doorType == DoorType.Door_NORMAL) {
            if (this.currentDoorLevel <= 21) {
                this._targetMapId = BinaryDoor.BINARY_SCENE_MAPID_1;
            } else {
                this._targetMapId = BinaryDoor.BINARY_SCENE_MAPID_2;
            }
        }
        return this._targetMapId;
    }

    public function set targetMapId(param1:uint):void {
        this._targetMapId = param1;
    }
}
}
