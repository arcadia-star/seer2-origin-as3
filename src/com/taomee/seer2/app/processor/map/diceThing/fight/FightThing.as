package com.taomee.seer2.app.processor.map.diceThing.fight {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;

public class FightThing extends BaseDiceThing {


    public function FightThing(param1:DiceThingInfo) {
        super(param1);
        eventInfo.currentSeat = param1.currentSeat;
    }

    override public function setUpThing():void {
        if (PetInfoManager.getFirstPetInfo().hp <= 1) {
            AlertManager.showAlert("您的首发精灵体力不够", this.fightOver);
            return;
        }
        var _loc1_:String = "find";
        switch (thingInfo.fightType) {
            case "npc":
                FightManager.startFightWithNPC(thingInfo.strikeId);
                break;
            case "wild":
                FightManager.startFightWithWild(thingInfo.strikeId);
                break;
            default:
                _loc1_ = "nofind";
        }
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        FightManager.addEventListener(FightStartEvent.START_ERROR, this.fightOver);
    }

    private function fightOver(param1:FightStartEvent = null):void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.fightOver);
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
    }

    override public function dispose():void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.fightOver);
        super.dispose();
    }
}
}
