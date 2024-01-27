package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.arena.util.FightState;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class Processor_12 extends ArenaProcessor {


    public function Processor_12(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_ESCAPE_NOTIFY_12, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:uint = uint(param1.message.getRawData().readUnsignedInt());
        if (fightController.leftTeam.containsFightUser(_loc2_)) {
            fightController.changeFighterState(FightState.ESCAPE);
            fightController.leftMainFighter.disappear(FightSide.LEFT);
            if (fightController.leftSubFighter != null) {
                fightController.leftSubFighter.disappear(FightSide.LEFT);
            }
        } else {
            fightController.changeFighterState(FightState.OPPOSITE_ESCAPE);
            fightController.rightMainFighter.disappear(FightSide.RIGHT);
            if (fightController.rightSubFighter != null) {
                fightController.rightSubFighter.disappear(FightSide.LEFT);
            }
        }
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_ESCAPE_NOTIFY_12, this.processor);
    }
}
}
