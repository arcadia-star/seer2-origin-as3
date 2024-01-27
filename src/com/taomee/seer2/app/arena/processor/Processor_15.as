package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;

import flash.utils.IDataInput;

public class Processor_15 extends ArenaProcessor {


    public function Processor_15(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_NOTIFY_MON_POS_15, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        this.parserLeftTeamData(_loc2_);
        this.parserRightTeamData(_loc2_);
        fightController.checkRightFighterChanged();
    }

    private function parserLeftTeamData(param1:IDataInput):void {
        var _loc5_:uint = 0;
        var _loc6_:uint = 0;
        var _loc7_:uint = 0;
        var _loc8_:uint = 0;
        var _loc9_:ArenaScene = null;
        var _loc10_:Fighter = null;
        var _loc11_:ChangeFighterInfo = null;
        var _loc2_:Vector.<ChangeFighterInfo> = new Vector.<ChangeFighterInfo>();
        var _loc3_:uint = uint(param1.readUnsignedInt());
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = uint(param1.readUnsignedInt());
            _loc6_ = uint(param1.readUnsignedInt());
            _loc7_ = uint(param1.readUnsignedInt());
            _loc8_ = uint(_loc4_ + 1);
            _loc10_ = (_loc9_ = SceneManager.active as ArenaScene).arenaData.getFighter(_loc5_, _loc6_);
            if (_loc6_ != 0) {
                _loc2_.push(new ChangeFighterInfo(_loc5_, _loc6_, _loc7_, _loc8_));
            }
            _loc4_++;
        }
        while (_loc2_.length > 0) {
            _loc11_ = _loc2_.shift();
            fightController.changeFighter(_loc11_.userId, _loc11_.petCatchTime, _loc11_.angerValue, _loc11_.position);
        }
    }

    private function parserRightTeamData(param1:IDataInput):void {
        var _loc4_:uint = 0;
        var _loc5_:uint = 0;
        var _loc6_:uint = 0;
        var _loc7_:uint = 0;
        var _loc8_:ArenaScene = null;
        var _loc9_:Fighter = null;
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(param1.readUnsignedInt());
            _loc6_ = uint(param1.readUnsignedInt());
            _loc7_ = uint(_loc3_ + 1);
            _loc9_ = (_loc8_ = SceneManager.active as ArenaScene).arenaData.getFighter(_loc4_, _loc5_);
            if (_loc5_ != 0) {
                fightController.changeFighter(_loc4_, _loc5_, _loc6_, _loc7_);
            }
            _loc3_++;
        }
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_NOTIFY_MON_POS_15, this.processor);
    }
}
}

class ChangeFighterInfo {


    public var userId:uint;

    public var petCatchTime:Number;

    public var angerValue:uint;

    public var position:uint;

    public function ChangeFighterInfo(param1:uint, param2:Number, param3:uint, param4:uint) {
        this.userId = param1;
        this.petCatchTime = param2;
        this.angerValue = param3;
        this.position = param4;
        super();
    }
}
