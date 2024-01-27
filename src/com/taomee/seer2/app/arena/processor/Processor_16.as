package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class Processor_16 extends ArenaProcessor {


    public function Processor_16(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_UPDATE_ANGER_16, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        this.updateAnger(_loc3_, _loc4_, _loc5_);
        var _loc6_:uint = uint(_loc2_.readUnsignedInt());
        var _loc7_:uint = uint(_loc2_.readUnsignedInt());
        var _loc8_:uint = uint(_loc2_.readUnsignedInt());
        this.updateAnger(_loc6_, _loc7_, _loc8_);
        arenaUIController.updateAngerBar();
    }

    private function updateAnger(param1:uint, param2:uint, param3:uint):void {
        var _loc4_:Fighter;
        (_loc4_ = _secne.arenaData.getFighter(param1, param2)).updateAnger(param3);
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_UPDATE_ANGER_16, this.processor);
    }
}
}
