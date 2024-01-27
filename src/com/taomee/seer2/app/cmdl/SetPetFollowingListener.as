package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.ByteArray;

import org.taomee.bean.BaseBean;
import org.taomee.utils.InvalidateCallback;

public class SetPetFollowingListener extends BaseBean {

    private static const SET_PET_FOLLOW_FLAG:int = 1;


    public function SetPetFollowingListener() {
        super();
    }

    override public function start():void {
        Connection.addCommandListener(CommandSet.PET_SET_FOLLOWING_1019, this.onData);
        finish();
    }

    private function onData(param1:MessageEvent):void {
        var _loc4_:uint = 0;
        var _loc5_:uint = 0;
        var _loc6_:Boolean = false;
        var _loc2_:ByteArray = param1.message.getRawDataCopy();
        var _loc3_:uint = _loc2_.readUnsignedInt();
        if (_loc3_ == ActorManager.actorInfo.id) {
            _loc4_ = _loc2_.readUnsignedInt();
            if ((_loc5_ = _loc2_.readUnsignedByte()) == 0) {
                _loc6_ = false;
                this.changePetInfoFollowingStatus(_loc4_, _loc6_);
            } else if (_loc5_ == 1) {
                _loc6_ = true;
                this.changePetInfoFollowingStatus(_loc4_, _loc6_);
            } else if (_loc5_ == 2) {
                this.changePetInfoRidingStatus(_loc4_, 2, _loc3_);
            } else if (_loc5_ == 3) {
                this.changePetInfoRidingStatus(_loc4_, 3, _loc3_);
            }
        }
    }

    private function changePetInfoFollowingStatus(param1:uint, param2:Boolean):void {
        var newFollowingPetInfo:PetInfo = null;
        var id:uint = param1;
        var isFollowing:Boolean = param2;
        var oldFollowingPetInfo:PetInfo = PetInfoManager.getFollowingPetInfo();
        newFollowingPetInfo = PetInfoManager.getPetInfoFromBag(id);
        if (oldFollowingPetInfo != null) {
            oldFollowingPetInfo.isFollowing = false;
        }
        if (newFollowingPetInfo != null) {
            newFollowingPetInfo.isFollowing = isFollowing;
            InvalidateCallback.addFunc(function ():void {
                PetInfoManager.dispatchEvent(PetInfoEvent.PET_SET_FOLLOW, newFollowingPetInfo);
            });
        }
    }

    private function changePetInfoRidingStatus(param1:uint, param2:int, param3:int):void {
        var newPetInfo:PetInfo = null;
        var petId:uint = param1;
        var isRiding:int = param2;
        var userId:int = param3;
        var oldPetInfo:PetInfo = PetInfoManager.getRidingPetInfo();
        newPetInfo = PetInfoManager.getPetInfoFromBag(petId);
        if (oldPetInfo != null) {
            oldPetInfo.isPetRiding = false;
        }
        if (newPetInfo != null) {
            newPetInfo.isPetRiding = isRiding == 3 ? true : false;
            InvalidateCallback.addFunc(function ():void {
                PetInfoManager.dispatchEvent(PetInfoEvent.PET_SET_RIDE, newPetInfo, userId);
            });
        }
    }
}
}
