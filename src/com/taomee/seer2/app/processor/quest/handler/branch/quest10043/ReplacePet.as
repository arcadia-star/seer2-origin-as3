package com.taomee.seer2.app.processor.quest.handler.branch.quest10043 {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.pet.PetDefinition;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class ReplacePet {


    public function ReplacePet() {
        super();
    }

    public static function replacePet():void {
        Connection.addCommandListener(CommandSet.REPLACE_PET_1185, onReplacePet);
    }

    private static function onReplacePet(param1:MessageEvent):void {
        var _loc8_:SkillInfo = null;
        var _loc14_:Actor = null;
        var _loc15_:PetInfo = null;
        Connection.removeCommandListener(CommandSet.REPLACE_PET_1185, onReplacePet);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        var _loc6_:uint = uint(_loc2_.readUnsignedInt());
        var _loc7_:Vector.<SkillInfo> = Vector.<SkillInfo>([]);
        var _loc9_:int = 0;
        while (_loc9_ < _loc6_) {
            _loc8_ = new SkillInfo(_loc2_.readUnsignedInt());
            _loc7_.push(_loc8_);
            _loc9_++;
        }
        var _loc10_:uint = uint(_loc2_.readUnsignedInt());
        var _loc11_:Vector.<SkillInfo> = Vector.<SkillInfo>([]);
        var _loc12_:int = 0;
        while (_loc12_ < _loc10_) {
            _loc8_ = new SkillInfo(_loc2_.readUnsignedInt());
            _loc11_.push(_loc8_);
            _loc12_++;
        }
        var _loc13_:PetDefinition = PetConfig.getPetDefinition(_loc5_);
        if (_loc3_ == ActorManager.actorInfo.id) {
            if (Boolean((_loc14_ = ActorManager.getActor()).getFollowingPet()) && _loc14_.getFollowingPet().getInfo().resourceId == 45) {
                _loc14_.getFollowingPet().getInfo().petDefinition = _loc13_;
                _loc14_.getFollowingPet().getInfo().resourceId = _loc5_;
                _loc14_.getFollowingPet().resourceUrl = URLUtil.getPetSwf(_loc5_);
                _loc14_.getFollowingPet().getInfo().replacePetSkill(_loc7_, _loc11_);
            } else if ((_loc15_ = PetInfoManager.getFirstPetInfo()).resourceId == 45) {
                _loc15_.petDefinition = _loc13_;
                _loc15_.resourceId = _loc5_;
                _loc14_.getFollowingPet().getInfo().replacePetSkill(_loc7_, _loc11_);
            }
            if (_loc14_.getFollowingPet().getInfo().isStarting) {
                PetInfoManager.setFirst(_loc4_);
            }
        } else if (Boolean((_loc14_ = ActorManager.getRemoteActor(_loc3_)).getFollowingPet()) && _loc14_.getFollowingPet().getInfo().resourceId == 45) {
            _loc14_.getFollowingPet().getInfo().petDefinition = _loc13_;
            _loc14_.getFollowingPet().getInfo().resourceId = _loc5_;
            _loc14_.getFollowingPet().resourceUrl = URLUtil.getPetSwf(_loc5_);
        }
    }
}
}
