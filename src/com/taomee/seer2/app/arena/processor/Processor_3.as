package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.data.FighterTurnResultInfo;
import com.taomee.seer2.app.arena.data.TurnResultInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class Processor_3 extends ArenaProcessor {


    public function Processor_3(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_HURT_NOTIFY_3, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:TurnResultInfo = new TurnResultInfo(param1.message.getRawData());
        if (this.checkDummyAtk(_loc2_) == false) {
            fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function checkDummyAtk(param1:TurnResultInfo):Boolean {
        var _loc3_:FighterTurnResultInfo = null;
        var _loc2_:Vector.<FighterTurnResultInfo> = param1.fighterTurnResultInfoVec;
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isAtker && _loc3_.skillId == 0) {
                return true;
            }
        }
        return false;
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_HURT_NOTIFY_3, this.processor);
    }
}
}
