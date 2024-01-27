package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class Processor_19 extends ArenaProcessor {

    public static var isChangeIng:Boolean;


    public function Processor_19(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_CHANGE_PET_19, this.processor);
        Connection.blockCommand(CommandSet.FIGHT_CHANGE_PET_19);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc4_:uint = 0;
        var _loc5_:uint = 0;
        var _loc6_:uint = 0;
        var _loc7_:int = 0;
        var _loc9_:Fighter = null;
        var _loc10_:Boolean = false;
        var _loc11_:Fighter = null;
        var _loc12_:Boolean = false;
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        var _loc8_:int = 0;
        while (_loc8_ < _loc3_) {
            _loc4_ = uint(_loc2_.readUnsignedInt());
            _loc7_ = int(_loc2_.readUnsignedByte());
            _loc5_ = uint(_loc2_.readUnsignedInt());
            _loc6_ = uint(_loc2_.readUnsignedInt());
            if (_loc4_ == ActorManager.actorInfo.id) {
                if (_loc7_ == 0) {
                    fightController.leftTeam.mainFighter.fighterInfo.isChangeStatus = 1;
                    isChangeIng = true;
                    arenaUIController.changeTeam("changePet", _loc5_, _loc6_);
                    (_loc9_ = fightController.leftTeam.getFighter(_loc4_, _loc6_)).fighterInfo.hp = _loc9_.fighterInfo.maxHp;
                    fightController.changeFighter(_loc4_, _loc9_.fighterInfo.catchTime, _loc9_.fighterInfo.fightAnger, 1);
                    fightController.leftTeam.getFighter(_loc4_, _loc9_.fighterInfo.catchTime).updateAnger(_loc9_.fighterInfo.fightAnger);
                    if ((_loc10_ = fightController.leftTeam.containsFighter(_loc4_, _loc9_.fighterInfo.catchTime)) == true) {
                        _secne.leftTeam.mainFighter.updateFighterBuffer(_secne.leftTeam.mainFighter.fighterInfo.fightBuffInfoVec);
                        arenaUIController.updateStatusPanel();
                    }
                } else if (_loc7_ == 1) {
                    arenaUIController.changeTeam("die", _loc5_, _loc6_);
                }
            } else if (_loc7_ == 0) {
                fightController.rightTeam.mainFighter.fighterInfo.isChangeStatus = 1;
                _loc11_ = fightController.rightTeam.getFighter(_loc4_, _loc6_);
                fightController.changeFighter(_loc4_, _loc11_.fighterInfo.catchTime, _loc11_.fighterInfo.fightAnger, 1);
                fightController.rightTeam.getFighter(_loc4_, _loc11_.fighterInfo.catchTime).updateAnger(_loc11_.fighterInfo.fightAnger);
                if ((_loc12_ = fightController.rightTeam.containsFighter(_loc4_, _loc11_.fighterInfo.catchTime)) == true) {
                    _secne.rightTeam.mainFighter.updateFighterBuffer(_secne.rightTeam.mainFighter.fighterInfo.fightBuffInfoVec);
                    arenaUIController.updateStatusPanel();
                }
            }
            _loc8_++;
        }
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_CHANGE_PET_19, this.processor);
    }
}
}
