package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.config.FitConfig;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class Processor_1502 extends ArenaProcessor {


    public function Processor_1502(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_USE_SKILL_1502, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc8_:Fighter = null;
        var _loc9_:Fighter = null;
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = ActorManager.actorInfo.id;
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        var _loc6_:Fighter;
        if ((_loc6_ = _secne.leftTeam.getFighter(_loc3_, _loc4_)) == null) {
            _loc6_ = _secne.leftTeam.getChangeFighter(_loc3_, _loc4_);
        }
        var _loc7_:SkillInfo;
        if ((_loc7_ = _loc6_.fighterInfo.getSkillInfo(_loc5_)) != null) {
            _loc6_.fighterInfo.fightAnger -= _loc7_.anger;
        }
        if (FitConfig.formSkillIdGetPetFitDefinition(_loc5_)) {
            if (_loc3_ == ActorManager.actorInfo.id) {
                _loc8_ = _secne.leftTeam.getFighter(_loc3_, _loc4_);
                _loc9_ = _secne.leftTeam.getFighterToBounchId(FitConfig.formSkillIdGetPetFitDefinition(_loc5_).id);
                if (_loc8_ == null || _loc9_ == null) {
                    return;
                }
                if (_loc5_ == 11618 || _loc5_ == 11619) {
                    _loc9_.fighterInfo.hp = _loc9_.fighterInfo.maxHp;
                    return;
                }
            }
        }
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_USE_SKILL_1502, this.processor);
    }
}
}
