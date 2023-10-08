package com.taomee.seer2.app.utils
{
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.pet.PetDefinition;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class PetUtil
   {
      
      private static const CONTRACT_LIST:Vector.<uint> = Vector.<uint>([147,148,149,150,152,151,153,429,1257,430,431]);
      
      private static const ONLY_PET_LIST:Vector.<int> = Vector.<int>([355]);
      
      private static const PUT_BAG_DEFAULT:int = 0;
      
      private static const PUT_BAG_FROM_PET:int = 1;
      
      private static const PUT_BAG_FROM_PET_STORAGE:int = 2;
       
      
      public function PetUtil()
      {
         super();
      }
      
      public static function getMinStatusPet(param1:uint) : PetDefinition
      {
         var _loc2_:PetDefinition = null;
         var _loc6_:PetDefinition = null;
         var _loc3_:Array = PetConfig.petDefinitionMap.getValues();
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = PetDefinition(_loc3_[_loc5_])).bunchId == param1)
            {
               if(_loc2_ == null)
               {
                  _loc2_ = _loc6_;
               }
               else if(_loc6_.resId < _loc2_.resId)
               {
                  _loc2_ = _loc6_;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function getMaxStatusPet(param1:uint) : PetDefinition
      {
         var _loc2_:PetDefinition = null;
         var _loc6_:PetDefinition = null;
         var _loc3_:Array = PetConfig.petDefinitionMap.getValues();
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = PetDefinition(_loc3_[_loc5_])).bunchId == param1)
            {
               if(_loc2_ == null)
               {
                  _loc2_ = _loc6_;
               }
               else if(_loc6_.resId > _loc2_.resId)
               {
                  _loc2_ = _loc6_;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function getMaxPetSkillList(param1:PetInfo) : Array
      {
         var _loc2_:PetDefinition = null;
         var _loc8_:Array = null;
         var _loc9_:PetDefinition = null;
         var _loc3_:Array = PetConfig.petDefinitionMap.getValues();
         var _loc4_:uint = _loc3_.length;
         var _loc5_:Array = [];
         var _loc6_:uint = param1.bunchId;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc4_)
         {
            if((_loc9_ = PetDefinition(_loc3_[_loc7_])).bunchId == _loc6_)
            {
               _loc5_.push(_loc9_.resId);
            }
            _loc7_++;
         }
         _loc5_.sort();
         if(_loc5_.length == 4)
         {
            if((_loc8_ = [_loc5_[0],_loc5_[1]])[0] == param1.resourceId || _loc8_[1] == param1.resourceId)
            {
               return _loc8_;
            }
            return null;
         }
         if(_loc5_.length <= 3 && _loc5_.length >= 1)
         {
            if((_loc8_ = [_loc5_[0]])[0] == param1.resourceId)
            {
               return _loc8_;
            }
            return null;
         }
         return null;
      }
      
      public static function exchangePetSkill(param1:int, param2:int, param3:Function) : void
      {
         var skillInfo:SkillInfo = null;
         var pet:PetDefinition = null;
         var petId:int = param1;
         var skillId:int = param2;
         var callBack:Function = param3;
         skillInfo = new SkillInfo(skillId);
         pet = PetConfig.getPetDefinition(petId);
         if(!isPetInBag(petId))
         {
            AlertManager.showAlert("精灵【" + pet.name + "】不在背包中！",function():void
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"));
            });
            return;
         }
         AlertManager.showSelectAlert("请选择要兑换【" + skillInfo.name + "】的精灵【" + pet.name + "】",function(param1:PetInfo):void
         {
            if(Boolean(param1) && param1.resourceId == petId)
            {
               if(isPetHaveSkill(petId,skillId))
               {
                  AlertManager.showAlert("这只精灵已拥有技能【" + skillInfo.name + "】");
                  return;
               }
               callBack(param1.catchTime);
            }
            else
            {
               AlertManager.showAlert("这只精灵不是【" + pet.name + "】");
            }
         });
      }
      
      public static function isPetInBag(param1:uint) : Boolean
      {
         var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].resourceId == param1)
            {
               _loc4_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function isPetHaveSkill(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:SkillInfo = new SkillInfo(param2);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].resourceId == param1 && (_loc3_[_loc4_].skillInfo.hasSkillInfo(_loc6_) || _loc3_[_loc4_].skillInfo.hasCandidateSkillInfo(_loc6_)))
            {
               _loc5_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public static function putinAndGetoutOfStorage(param1:PetInfo, param2:Function = null) : void
      {
         var bytes:LittleEndianByteArray = null;
         var petInfo:PetInfo = param1;
         var callback:Function = param2;
         bytes = new LittleEndianByteArray();
         bytes.writeUnsignedInt(petInfo.catchTime);
         bytes.writeByte(0);
         Connection.addCommandListener(CommandSet.PET_SET_STORAGE_STATUS_1020,function putinStorageSuccess(param1:MessageEvent):void
         {
            var e:MessageEvent = param1;
            Connection.removeCommandListener(CommandSet.PET_SET_STORAGE_STATUS_1020,putinStorageSuccess);
            bytes.position = 0;
            bytes.writeUnsignedInt(petInfo.catchTime);
            bytes.writeByte(1);
            Connection.addCommandListener(CommandSet.PET_SET_STORAGE_STATUS_1020,function takeOutOfStorageSuccess(param1:MessageEvent):void
            {
               Connection.removeCommandListener(CommandSet.PET_SET_STORAGE_STATUS_1020,takeOutOfStorageSuccess);
               if(callback != null)
               {
                  callback();
               }
            });
            Connection.send(CommandSet.PET_SET_STORAGE_STATUS_1020,bytes);
         });
         Connection.send(CommandSet.PET_SET_STORAGE_STATUS_1020,bytes);
      }
      
      public static function get maxBagPetStarLevel() : int
      {
         var _loc4_:PetInfo = null;
         var _loc1_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if((_loc4_ = _loc1_[_loc3_]).getPetDefinition().starLevel > _loc2_)
            {
               _loc2_ = int(_loc4_.getPetDefinition().starLevel);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function putPetTobag(param1:PetInfo) : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:PetInfo = null;
         var _loc2_:int = 0;
         for each(_loc3_ in PetInfoManager.getAllBagPetInfo())
         {
            if(CONTRACT_LIST.indexOf(_loc3_.bunchId) != -1 && CONTRACT_LIST.indexOf(param1.bunchId) != -1)
            {
               _loc2_ = 1;
               break;
            }
         }
         if(_loc2_ == 0)
         {
            for each(_loc4_ in PetInfoManager.getAllBagPetStorageInfo())
            {
               if(CONTRACT_LIST.indexOf(_loc4_.bunchId) != -1 && CONTRACT_LIST.indexOf(param1.bunchId) != -1)
               {
                  _loc2_ = 2;
                  break;
               }
            }
         }
         if(!PetInfoManager.isBagFull())
         {
            if(_loc2_ == 0)
            {
               putPetToBag(PUT_BAG_DEFAULT,param1);
            }
            else if(_loc2_ == 1)
            {
               contract(0,0,param1);
            }
            else
            {
               contract(1,1,param1);
            }
            return;
         }
         if(PetInfoManager.isBagFull() && !PetInfoManager.isBagStorageFull())
         {
            if(_loc2_ == 0)
            {
               putPetToBag(PUT_BAG_FROM_PET_STORAGE,param1);
            }
            else if(_loc2_ == 1)
            {
               contract(0,0,param1);
            }
            else
            {
               contract(1,1,param1);
            }
            return;
         }
         if(PetInfoManager.isBagFull() && PetInfoManager.isBagStorageFull())
         {
            if(_loc2_ == 0)
            {
               AlertManager.showAlert("背包满了！");
            }
            else if(_loc2_ == 1)
            {
               contract(0,0,param1);
            }
            else
            {
               contract(1,1,param1);
            }
            return;
         }
      }
      
      private static function putPetToBag(param1:int, param2:PetInfo) : void
      {
         switch(param1)
         {
            case PUT_BAG_DEFAULT:
               putPetBag(param2);
               break;
            case PUT_BAG_FROM_PET:
               putPetBag(param2);
               break;
            case PUT_BAG_FROM_PET_STORAGE:
               putPetBagStorage(param2);
         }
      }
      
      private static function putPetBag(param1:PetInfo) : void
      {
         var _loc2_:uint = 1;
         var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc3_.writeUnsignedInt(param1.catchTime);
         _loc3_.writeByte(_loc2_);
         Connection.send(CommandSet.PET_SET_STORAGE_STATUS_1020,_loc3_);
      }
      
      private static function putPetBagStorage(param1:PetInfo) : void
      {
         var _loc2_:uint = 1;
         var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc3_.writeUnsignedInt(param1.catchTime);
         _loc3_.writeByte(_loc2_);
         Connection.send(CommandSet.CLI_SET_MON_STATUS_VIP_1260,_loc3_);
      }
      
      private static function contract(param1:int, param2:int, param3:PetInfo) : void
      {
         var _loc4_:Object = new Object();
         if(param1 == 0)
         {
            _loc4_.okFun = putPetBag;
         }
         else
         {
            _loc4_.okFun = putPetBagStorage;
         }
         _loc4_.petId = param3.bunchId;
         _loc4_.petMonId = param3.resourceId;
         _loc4_.goType = param2;
         ModuleManager.toggleModule(URLUtil.getAppModule("PetContractPanel"),"正在打开...",_loc4_);
      }
      
      public static function FreePet(param1:PetInfo) : void
      {
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUnsignedInt(param1.catchTime);
         _loc2_.writeUnsignedInt(param1.resourceId);
         var _loc3_:uint = 1;
         _loc2_.writeByte(_loc3_);
         Connection.send(CommandSet.PET_SET_FREE_STATUS_1021,_loc2_);
      }
   }
}
