package com.taomee.seer2.app.lobby.messageHandler {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.config.PetRideShopConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.item.EquipItem;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.net.message.IMessageHandler;

import flash.utils.IDataInput;

public class MessageHandlerEquipChange implements IMessageHandler {


    public function MessageHandlerEquipChange() {
        super();
    }

    public function setup():void {
        Connection.addCommandListener(CommandSet.EQUIP_CHANGE_1098, this.onMessage);
    }

    public function onMessage(param1:MessageEvent):void {
        var _loc11_:Actor = null;
        var _loc12_:uint = 0;
        var _loc13_:EquipItem = null;
        var _loc14_:PetInfo = null;
        var _loc15_:int = 0;
        var _loc16_:EquipItem = null;
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:Vector.<EquipItem> = new Vector.<EquipItem>();
        var _loc6_:uint = 0;
        while (_loc6_ < _loc4_) {
            _loc12_ = uint(_loc2_.readUnsignedInt());
            _loc13_ = new EquipItem(_loc12_);
            _loc5_.push(_loc13_);
            _loc6_++;
        }
        var _loc7_:uint = uint(_loc2_.readUnsignedInt());
        var _loc8_:uint = 0;
        var _loc9_:int = 0;
        while (_loc9_ < _loc7_) {
            _loc8_ = uint(_loc2_.readUnsignedInt());
            _loc9_++;
        }
        var _loc10_:*;
        if (_loc10_ = _loc3_ == ActorManager.actorInfo.id) {
            _loc11_ = ActorManager.getActor();
            this.updateItemManager(_loc5_);
            _loc11_.getNono().nonoInfo.equipId = _loc8_;
            _loc11_.getNono().updateNonoView();
        } else {
            _loc11_ = ActorManager.getRemoteActor(_loc3_);
        }
        if (_loc11_) {
            if (_loc14_ = _loc11_.getInfo().ridingPetInfo) {
                _loc15_ = PetRideShopConfig.getEquipIdByChipBackId(_loc14_.petRideChipId);
                _loc16_ = new EquipItem(_loc15_);
                if (_loc11_.getInfo().vipInfo.isVip() == false) {
                    if (TimeManager.getServerTime() - _loc14_.chipPutOnTime <= 7 * 24 * 60 * 60) {
                        if (_loc14_.isPetRiding && Boolean(_loc16_)) {
                            _loc5_.push(_loc16_);
                            if (_loc10_) {
                                this.updateItemManager(_loc5_);
                            }
                        }
                    }
                } else if (_loc14_.isPetRiding && Boolean(_loc16_)) {
                    _loc5_.push(_loc16_);
                    if (_loc10_) {
                        this.updateItemManager(_loc5_);
                    }
                }
            }
            _loc11_.getInfo().updateEquipVec(_loc5_);
            _loc11_.getNono().nonoInfo.equipId = _loc8_;
            _loc11_.getNono().updateNonoView();
        }
    }

    private function updateItemManager(param1:Vector.<EquipItem>):void {
        var _loc3_:EquipItem = null;
        var _loc4_:EquipItem = null;
        var _loc2_:Vector.<EquipItem> = ItemManager.getEquipVec();
        for each(_loc3_ in _loc2_) {
            _loc3_.isEquiped = false;
            for each(_loc4_ in param1) {
                if (_loc3_.referenceId == _loc4_.referenceId) {
                    _loc3_.isEquiped = true;
                    break;
                }
            }
        }
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.EQUIP_CHANGE_1098, this.onMessage);
    }
}
}
