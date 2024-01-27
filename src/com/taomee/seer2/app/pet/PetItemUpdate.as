package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.data.PetItemInfo;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class PetItemUpdate {


    public function PetItemUpdate() {
        super();
    }

    public static function setup():void {
        Connection.addCommandListener(CommandSet.UPDATE_PET_ITEM_INFO_1235, onUpdatePet);
    }

    private static function onUpdatePet(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            updatePetItem(_loc2_);
            _loc4_++;
        }
    }

    private static function updatePetItem(param1:IDataInput):void {
        var _loc4_:PetInfo = null;
        var _loc5_:uint = 0;
        var _loc6_:PetItemInfo = null;
        var _loc7_:int = 0;
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:Vector.<PetInfo> = PetInfoManager.getTotalBagPetInfo();
        for each(_loc4_ in _loc3_) {
            if (_loc4_.catchTime == _loc2_) {
                _loc4_.itemList = Vector.<PetItemInfo>([]);
                _loc5_ = uint(param1.readUnsignedInt());
                _loc7_ = 0;
                while (_loc7_ < _loc5_) {
                    (_loc6_ = new PetItemInfo()).itemId = param1.readUnsignedInt();
                    _loc6_.itemCurrCount = param1.readUnsignedInt();
                    _loc4_.itemList.push(_loc6_);
                    _loc7_++;
                }
                PetInfoManager.dispatchEvent(PetInfoEvent.PET_FIGHT_ITEM, _loc4_);
                return;
            }
        }
    }
}
}
