package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class Processor_8 extends ArenaProcessor {


    public function Processor_8(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_CHANGED_NOTIFY_8, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:Parser_8 = new Parser_8(_loc2_);
        fightController.changeFighter(_loc3_.userId, _loc3_.fighterId, _loc3_.angerValue, 1);
        fightController.leftTeam.getFighter(_loc3_.userId, _loc3_.fighterId).updateAnger(_loc3_.angerValue);
        var _loc4_:Boolean;
        if ((_loc4_ = fightController.leftTeam.containsFighter(_loc3_.userId, _loc3_.fighterId)) == true) {
            _secne.leftTeam.mainFighter.updateFighterBuffer(_loc3_.parserFighterBuffInfo(_loc2_));
            arenaUIController.updateStatusPanel();
        }
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_CHANGED_NOTIFY_8, this.processor);
    }
}
}

import com.taomee.seer2.app.arena.data.FighterBuffInfo;

import flash.utils.IDataInput;


