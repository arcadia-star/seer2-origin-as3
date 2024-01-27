package com.taomee.seer2.app.processor.map.diceThing.fight {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
import com.taomee.seer2.core.net.MessageEvent;

public class RandomFightThing extends BaseDiceThing {


    private const FIGHT_INDEX:Array = [949, 950, 951, 952, 953, 954];

    public function RandomFightThing(param1:DiceThingInfo) {
        super(param1);
    }

    override public function setUpThing():void {
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.getRandom);
        Connection.send(CommandSet.RANDOM_EVENT_1140, 91, 0);
    }

    private function getRandom(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.getRandom);
        var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawData());
        var _loc3_:uint = _loc2_.id;
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        FightManager.addEventListener(FightStartEvent.START_ERROR, this.fightOver);
        FightManager.startFightWithWild(this.FIGHT_INDEX[_loc3_ - 1]);
    }

    private function fightOver(param1:FightStartEvent = null):void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.fightOver);
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
    }

    override public function dispose():void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.getRandom);
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.fightOver);
        super.dispose();
    }
}
}
