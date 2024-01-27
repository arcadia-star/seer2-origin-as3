package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.config.FindPetConfig;
import com.taomee.seer2.app.config.info.FindPetInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.events.MouseEvent;

public class FindPetAct {

    private static var _instance:FindPetAct;


    private var info:FindPetInfo;

    private var pet:SpawnedPet;

    public function FindPetAct() {
        super();
    }

    public static function get instance():FindPetAct {
        if (!_instance) {
            _instance = new FindPetAct();
        }
        return _instance;
    }

    public function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
    }

    private function onSwitchComplete(param1:SceneEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.getCreateState);
        Connection.removeCommandListener(CommandSet.PET_SPAWN_1103, this.createPet);
        if (this.pet) {
            this.pet.removeEventListener(MouseEvent.CLICK, this.fightCheck);
        }
        if (TimeManager.getServerTime() > FindPetConfig.endTime) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
            return;
        }
        var _loc2_:int = int(SceneManager.active.mapID);
        this.info = FindPetConfig.getCreateInfo(_loc2_);
        if (this.info) {
            Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.getCreateState);
            Connection.send(CommandSet.RANDOM_EVENT_1140, this.info.probabilityId, 0);
        }
    }

    private function getCreateState(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.getCreateState);
        var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
        if (_loc2_.id != 0 && _loc2_.index == this.info.probabilityId) {
            Connection.addCommandListener(CommandSet.PET_SPAWN_1103, this.createPet);
        }
    }

    private function createPet(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.PET_SPAWN_1103, this.createPet);
        this.pet = new SpawnedPet(this.info.petId, this.info.fightId, this.info.lev);
        this.pet.mouseChildren = false;
        this.pet.addEventListener(MouseEvent.CLICK, this.fightCheck, false, 1000);
        MobileManager.addMobile(this.pet, MobileType.SPAWNED_PET);
    }

    private function fightCheck(param1:MouseEvent):void {
        var _loc4_:Date = null;
        var _loc5_:String = null;
        var _loc6_:int = 0;
        var _loc7_:Array = null;
        var _loc8_:Boolean = false;
        var _loc9_:int = 0;
        var _loc2_:SpawnedPet = param1.target as SpawnedPet;
        var _loc3_:* = false;
        if (TimeManager.getServerTime() > FindPetConfig.endTime) {
            _loc3_ = true;
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
        } else if (TimeManager.getServerTime() > this.info.end) {
            _loc3_ = true;
        }
        if (!_loc3_) {
            if ((_loc5_ = (_loc4_ = new Date(TimeManager.getServerTime() * 1000)).minutes.toString()).length == 1) {
                _loc5_ = "0" + _loc5_;
            }
            _loc6_ = int(String(_loc4_.hours) + _loc5_);
            _loc7_ = this.info.timeList[_loc4_.day];
            _loc8_ = false;
            _loc9_ = 0;
            while (_loc9_ < _loc7_.length) {
                if (_loc6_ > _loc7_[_loc9_]["start"] && _loc6_ < _loc7_[_loc9_]["end"]) {
                    _loc8_ = true;
                }
                _loc9_++;
            }
            _loc3_ = !_loc8_;
        }
        if (_loc3_) {
            _loc2_.removeEventListener(MouseEvent.CLICK, this.fightCheck);
            MobileManager.removeMobile(_loc2_, MobileType.SPAWNED_PET);
            param1.stopImmediatePropagation();
        }
    }
}
}
