package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.PetPowerUpdate;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import org.taomee.bean.BaseBean;
   import org.taomee.manager.EventManager;
   
   public class SetPetStorageStatusListener extends BaseBean
   {
      
      private static const PUT_TO_BAG_FLAG_ARR:Array = [1,3];
       
      
      public function SetPetStorageStatusListener()
      {
         super();
      }
      
      override public function start() : void
      {
         Connection.addCommandListener(CommandSet.PET_SET_STORAGE_STATUS_1020,this.onData);
         Connection.addCommandListener(CommandSet.CLI_SET_MON_STATUS_VIP_1260,this.onData1);
         Connection.addCommandListener(CommandSet.CLI_EXCHANGE_MON_BETWEEN_BAG_AND_VIP_BAG_1261,this.onData2);
         finish();
      }
      
      private function onData(param1:MessageEvent) : void
      {
         var _loc7_:PetInfo = null;
         var _loc8_:int = 0;
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         var _loc5_:int = int(_loc2_.readUnsignedByte());
         var _loc6_:*;
         if((_loc6_ = PUT_TO_BAG_FLAG_ARR.indexOf(_loc5_) != -1) == true)
         {
            _loc8_ = int(_loc2_.readUnsignedInt());
            _loc7_ = new PetInfo();
            PetInfo.readPetInfo(_loc7_,_loc2_);
            if(_loc5_ == 3)
            {
               _loc7_.isInitialPet = true;
            }
            PetInfoManager.addPetInfo(_loc7_);
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PUT_TO_BAG,_loc7_);
            ServerMessager.addMessage(_loc7_.name + "已经放入精灵背包");
         }
         else if((_loc7_ = PetInfoManager.getPetInfoFromBag(_loc4_)) != null)
         {
            PetInfoManager.removePetInfoFromBagById(_loc4_);
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PUT_TO_STORAGE,_loc7_);
            if(_loc4_ != 271 && _loc5_ != 5)
            {
               ServerMessager.addMessage(_loc7_.name + "已经放入仓库");
            }
         }
         PetInfoManager.setFirst(_loc3_);
         EventManager.dispatchEvent(new Event(PetPowerUpdate.PET_RE_COUNT));
      }
      
      private function onData1(param1:MessageEvent) : void
      {
         var _loc5_:PetInfo = null;
         var _loc6_:int = 0;
         var _loc7_:PetInfo = null;
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:int;
         if((_loc4_ = int(_loc2_.readUnsignedByte())) == 0)
         {
            if((_loc5_ = PetInfoManager.getPetInfoFromBagStorage(_loc3_)) != null)
            {
               PetInfoManager.removePetInfoFromBagStorageById(_loc3_);
               PetInfoManager.dispatchEvent(PetInfoEvent.PET_PUT_TO_STORAGE,_loc5_);
               if(_loc3_ != 271 && _loc4_ != 5)
               {
                  ServerMessager.addMessage(_loc5_.name + "已经放入仓库");
               }
            }
         }
         else
         {
            _loc6_ = int(_loc2_.readUnsignedInt());
            _loc5_ = new PetInfo();
            PetInfo.readPetInfo(_loc5_,_loc2_);
            _loc5_.isInStorageBag = true;
            PetInfoManager.addPetInfo1(_loc5_);
            if(_loc7_ = PetInfoManager.getPetInfoFromMap(_loc5_.catchTime))
            {
               _loc7_.isInStorageBag = true;
            }
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PUT_TO_BAG_STORAGE,_loc5_);
            ServerMessager.addMessage(_loc5_.name + "已经放入精灵背包仓库");
         }
      }
      
      private function onData2(param1:MessageEvent) : void
      {
         var _loc5_:PetInfo = null;
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ == 0 && _loc4_ != 0)
         {
            if((_loc5_ = PetInfoManager.getPetInfoFromBag(_loc4_)) != null)
            {
               PetInfoManager.removePetInfoFromBagById(_loc4_);
               _loc5_.isInStorageBag = true;
               PetInfoManager.addPetInfo1(_loc5_);
               PetInfoManager.dispatchEvent(PetInfoEvent.PET_BAG_STORAGE_CHANGE,null);
               ServerMessager.addMessage(_loc5_.name + "已经放入精灵背包仓库");
            }
         }
         else if(_loc3_ != 0 && _loc4_ == 0)
         {
            if((_loc5_ = PetInfoManager.getPetInfoFromBagStorage(_loc3_)) != null)
            {
               PetInfoManager.removePetInfoFromBagStorageById(_loc3_);
               _loc5_.isInStorageBag = false;
               PetInfoManager.addPetInfo(_loc5_);
               PetInfoManager.dispatchEvent(PetInfoEvent.PET_BAG_STORAGE_CHANGE,null);
               ServerMessager.addMessage(_loc5_.name + "已经放入精灵背包");
            }
         }
         else if(_loc3_ != 0 && _loc4_ != 0)
         {
            if((_loc5_ = PetInfoManager.getPetInfoFromBagStorage(_loc3_)) != null)
            {
               PetInfoManager.removePetInfoFromBagStorageById(_loc3_);
               _loc5_.isInStorageBag = false;
               PetInfoManager.addPetInfo(_loc5_);
               if((_loc5_ = PetInfoManager.getPetInfoFromBag(_loc4_)) != null)
               {
                  _loc5_.isInStorageBag = true;
                  PetInfoManager.addPetInfo1(_loc5_);
                  PetInfoManager.dispatchEvent(PetInfoEvent.PET_BAG_STORAGE_CHANGE,null);
                  ServerMessager.addMessage("精灵交换成功哦!");
               }
            }
         }
         EventManager.dispatchEvent(new Event(PetPowerUpdate.PET_RE_COUNT));
      }
   }
}
