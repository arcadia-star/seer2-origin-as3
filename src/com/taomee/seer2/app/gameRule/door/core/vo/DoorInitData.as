package com.taomee.seer2.app.gameRule.door.core.vo {
import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
import com.taomee.seer2.app.pet.data.PetInfo;

public class DoorInitData {


    public var npcName:String = "";

    public var npcPets:Vector.<PetInfo>;

    public var playerName:String = "";

    private var _playerPets:Vector.<PetInfo>;

    public var supportInstance:IUpDoorSupport;

    public var doorLevel:uint = 0;

    public var doorRule:uint;

    public var doorType:uint;

    public function DoorInitData() {
        super();
    }

    public function get playerPets():Vector.<PetInfo> {
        return this._playerPets;
    }

    public function set playerPets(param1:Vector.<PetInfo>):void {
        this._playerPets = this.sortSelftIDs(param1);
    }

    private function sortSelftIDs(param1:Vector.<PetInfo>):Vector.<PetInfo> {
        var compareFunction:Function = null;
        var petList:Vector.<PetInfo> = param1;
        compareFunction = function (param1:PetInfo, param2:PetInfo):int {
            var _loc3_:uint = param1.catchTime;
            var _loc4_:uint = param2.catchTime;
            if (_loc3_ > _loc4_) {
                return 1;
            }
            return -1;
        };
        petList = petList.sort(compareFunction);
        return petList;
    }
}
}
