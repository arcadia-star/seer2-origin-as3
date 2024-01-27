package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class Processor_11 extends ArenaProcessor {


    public function Processor_11(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_FEATRUE_RESULT_11, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc7_:Array = null;
        var _loc8_:Fighter = null;
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        var _loc6_:int;
        if ((_loc6_ = int(_loc2_.readUnsignedByte())) == 0) {
            (_loc7_ = _secne.arenaData.hpPackage11).push({
                "userId": _loc3_,
                "fighterId": _loc4_,
                "fighterHp": _loc5_
            });
        } else {
            (_loc8_ = _secne.arenaData.getFighter(_loc3_, _loc4_)).fighterInfo.hp = _loc5_;
        }
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_FEATRUE_RESULT_11, this.processor);
    }
}
}
