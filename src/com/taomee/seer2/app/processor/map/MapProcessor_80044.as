package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class MapProcessor_80044 extends MapProcessor {


    private const FIGHT_ID:uint = 570;

    private const RANDOM_INDEX:uint = 56;

    private const PET_LIST:Array = [93, 150, 155, 349];

    private var pet:SpawnedPet;

    public function MapProcessor_80044(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
        Connection.send(CommandSet.RANDOM_EVENT_1140, this.RANDOM_INDEX, 0);
    }

    private function onRandomStatus(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
        var _loc2_:IDataInput = param1.message.getRawDataCopy();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        this.createPet(_loc4_ - 1);
    }

    private function createPet(param1:uint):void {
        this.pet = new SpawnedPet(this.PET_LIST[param1], this.FIGHT_ID, 100);
        MobileManager.addMobile(this.pet, MobileType.SPAWNED_PET);
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
