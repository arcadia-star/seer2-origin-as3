package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.data.BuffResultInfo;
import com.taomee.seer2.app.arena.data.BuffResultInfoRoundData;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class Processor_9 extends ArenaProcessor {


    public function Processor_9(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_BUFF_RESULT_NOTIFY_9, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:BuffResultInfo = new BuffResultInfo();
        _loc3_.userId = _loc2_.readUnsignedInt();
        _loc3_.fighterId = _loc2_.readUnsignedInt();
        _loc3_.isDying = _loc2_.readUnsignedByte() == 1;
        var _loc4_:Vector.<BuffResultInfoRoundData> = new Vector.<BuffResultInfoRoundData>();
        var _loc5_:int = int(_loc2_.readUnsignedInt());
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            _loc4_.push(new BuffResultInfoRoundData(_loc2_));
            _loc6_++;
        }
        _loc3_.buffResultInfoRoundDatas = _loc4_;
        fightController.addBuffResultInfo(_loc3_);
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_BUFF_RESULT_NOTIFY_9, this.processor);
    }
}
}
