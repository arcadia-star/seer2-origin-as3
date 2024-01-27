package com.taomee.seer2.app.lobby.messageHandler {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.RemoteActor;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.net.message.IMessageHandler;

import flash.utils.ByteArray;

public class MessageHandlerSetPetFollow implements IMessageHandler {

    private static const FOLLOWING_FLAG:int = 1;


    public function MessageHandlerSetPetFollow() {
        super();
    }

    public function setup():void {
        Connection.addCommandListener(CommandSet.PET_SET_FOLLOWING_1019, this.onMessage);
    }

    public function onMessage(param1:MessageEvent):void {
        var _loc6_:uint = 0;
        var _loc7_:PetInfo = null;
        var _loc8_:uint = 0;
        var _loc9_:PetInfo = null;
        var _loc2_:ByteArray = param1.message.getRawDataCopy();
        var _loc3_:uint = _loc2_.readUnsignedInt();
        var _loc4_:uint = _loc2_.readUnsignedInt();
        var _loc5_:uint;
        if ((_loc5_ = _loc2_.readUnsignedByte()) == 1) {
            _loc6_ = _loc2_.readUnsignedInt();
            (_loc7_ = new PetInfo()).catchTime = _loc2_.readUnsignedInt();
            _loc7_.resourceId = _loc2_.readUnsignedInt();
            _loc7_.sex = _loc2_.readUnsignedByte();
            _loc7_.level = _loc2_.readUnsignedByte();
            _loc7_.character = _loc2_.readUnsignedInt();
            _loc7_.potential = _loc2_.readUnsignedInt();
            _loc7_.flag = _loc2_.readUnsignedInt();
            _loc7_.petRideChipId = _loc2_.readUnsignedInt();
            _loc7_.chipPutOnTime = _loc2_.readUnsignedInt();
            _loc7_.evolveLevel = _loc2_.readUnsignedInt();
            this.createFollowingPet(_loc3_, _loc7_);
        } else if (_loc5_ == 0) {
            this.finishFollowingPet(_loc3_, _loc4_);
        } else if (_loc5_ == 2) {
            this.removePetRIde(_loc3_, _loc4_);
        } else if (_loc5_ == 3) {
            _loc8_ = _loc2_.readUnsignedInt();
            (_loc9_ = new PetInfo()).catchTime = _loc2_.readUnsignedInt();
            _loc9_.resourceId = _loc2_.readUnsignedInt();
            _loc9_.sex = _loc2_.readUnsignedByte();
            _loc9_.level = _loc2_.readUnsignedByte();
            _loc9_.character = _loc2_.readUnsignedInt();
            _loc9_.potential = _loc2_.readUnsignedInt();
            _loc9_.flag = _loc2_.readUnsignedInt();
            _loc9_.petRideChipId = _loc2_.readUnsignedInt();
            _loc9_.chipPutOnTime = _loc2_.readUnsignedInt();
            _loc9_.isPetRiding = true;
            _loc9_.evolveLevel = _loc2_.readUnsignedInt();
            this.createPetRide(_loc3_, _loc9_);
        }
    }

    private function finishFollowingPet(param1:uint, param2:uint):void {
        var _loc3_:RemoteActor = null;
        if (param1 == ActorManager.actorInfo.id) {
            ActorManager.getActor().getInfo().setFollowingPetInfo(null);
        } else {
            _loc3_ = ActorManager.getRemoteActor(param1);
            if (_loc3_ != null) {
                _loc3_.getInfo().setFollowingPetInfo(null);
            }
        }
    }

    private function createFollowingPet(param1:uint, param2:PetInfo):void {
        var _loc3_:Actor = null;
        if (param1 == ActorManager.actorInfo.id) {
            _loc3_ = ActorManager.getActor();
        } else {
            _loc3_ = ActorManager.getRemoteActor(param1);
        }
        if (_loc3_ != null) {
            _loc3_.getInfo().setFollowingPetInfo(param2);
        }
    }

    private function createPetRide(param1:uint, param2:PetInfo):void {
        var _loc3_:Actor = null;
        if (param1 == ActorManager.actorInfo.id) {
            _loc3_ = ActorManager.getActor();
        } else {
            _loc3_ = ActorManager.getRemoteActor(param1);
        }
        if (_loc3_ != null) {
            _loc3_.getInfo().setPetRidePetInfo(param2);
        }
    }

    private function removePetRIde(param1:int, param2:uint):void {
        var _loc3_:RemoteActor = null;
        if (param1 == ActorManager.actorInfo.id) {
            ActorManager.getActor().getInfo().setPetRidePetInfo(null);
        } else {
            _loc3_ = ActorManager.getRemoteActor(param1);
            if (_loc3_ != null) {
                _loc3_.getInfo().setPetRidePetInfo(null);
            }
        }
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.PET_SET_FOLLOWING_1019, this.onMessage);
    }
}
}
