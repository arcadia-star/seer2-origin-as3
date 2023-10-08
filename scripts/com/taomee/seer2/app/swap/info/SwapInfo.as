package com.taomee.seer2.app.swap.info
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.constant.ItemCategory;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import flash.utils.IDataInput;
   
   public class SwapInfo
   {
       
      
      private var _petID:uint;
      
      public var swapCoins:uint;
      
      public var itemID:uint;
      
      public var itemCount:uint;
      
      public var addSwapIdList:Vector.<uint>;
      
      public var addSwapIdCountList:Vector.<uint>;
      
      public var deleteSwapIdList:Vector.<uint>;
      
      public var deleteSwapCountList:Vector.<uint>;
      
      public function SwapInfo(param1:IDataInput, param2:Boolean = true)
      {
         super();
         if(param1 != null)
         {
            this.deleteItem(param1);
            this.addItem(param1,param2);
            this.addPet(param1);
            this.honor(param1,param2);
         }
      }
      
      private function deleteItem(param1:IDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this.deleteSwapIdList = Vector.<uint>([]);
         this.deleteSwapCountList = Vector.<uint>([]);
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(param1.readUnsignedShort());
            _loc6_ = uint(param1.readUnsignedInt());
            this.deleteSwapIdList.push(_loc4_);
            this.deleteSwapCountList.push(_loc5_);
            if(_loc4_ == 1)
            {
               ActorManager.actorInfo.coins -= _loc5_;
            }
            else
            {
               ItemManager.reduceItemQuantity(_loc4_,_loc5_);
            }
            _loc3_++;
         }
      }
      
      private function addItem(param1:IDataInput, param2:Boolean) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = uint(param1.readUnsignedInt());
         this.swapCoins = 0;
         this.addSwapIdList = Vector.<uint>([]);
         this.addSwapIdCountList = Vector.<uint>([]);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = uint(param1.readUnsignedInt());
            _loc6_ = uint(param1.readUnsignedShort());
            _loc7_ = uint(param1.readUnsignedInt());
            this.addSwapIdList.push(_loc5_);
            this.addSwapIdCountList.push(_loc6_);
            this.itemID = _loc5_;
            this.itemCount = _loc6_;
            if(ItemConfig.getItemDefinition(_loc5_) != null)
            {
               if(_loc5_ == 1)
               {
                  ActorManager.actorInfo.coins += _loc6_;
                  this.swapCoins = _loc6_;
                  if(param2)
                  {
                     AlertManager.showCoinsGainedAlert(_loc6_);
                  }
               }
               else if(!ItemConfig.getItemDefinition(_loc5_).isHide)
               {
                  ItemManager.addItem(_loc5_,_loc6_,_loc7_);
                  if(_loc5_ > 603000 && _loc5_ <= 610000 || _loc5_ >= 400266 && _loc5_ <= 400268)
                  {
                     if(param2)
                     {
                        ServerMessager.addMessage("恭喜你获得了" + _loc6_ + "个[" + ItemConfig.getItemName(_loc5_) + "]");
                     }
                  }
                  else if(param2 && this.itemID != 36 && _loc5_ != 37)
                  {
                     if(ItemConfig.getItemCategory(_loc5_) == ItemCategory.MEDAL)
                     {
                        AlertManager.showMedalGainedAlert(this.itemID);
                        if(ItemConfig.getMedalDefinition(this.itemID).title != "")
                        {
                           ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getMedalDefinition(this.itemID).title + "称号]");
                        }
                     }
                     else if(ItemConfig.getItemCategory(_loc5_) == ItemCategory.PET_SPIRT_TRAIN)
                     {
                        AlertManager.showGetPetSpiritAlert(_loc5_,_loc6_);
                     }
                     else
                     {
                        AlertManager.showItemGainedAlert(_loc5_,_loc6_);
                     }
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function addPet(param1:IDataInput) : void
      {
         var _loc2_:uint = uint(param1.readUnsignedInt());
         this._petID = param1.readUnsignedInt();
         if(_loc2_ != 0)
         {
            if(PetInfoManager.isBagFull() == true)
            {
               AlertManager.showGetPetInStorageAlert(_loc2_,1);
            }
            else
            {
               AlertManager.showGetPetInBagAlert(_loc2_,1);
            }
         }
      }
      
      public function getPetId() : uint
      {
         return this._petID;
      }
      
      private function honor(param1:IDataInput, param2:Boolean) : void
      {
         var _loc6_:PetInfo = null;
         var _loc3_:uint = uint(param1.readUnsignedInt());
         var _loc4_:uint = uint(param1.readUnsignedInt());
         var _loc5_:uint = uint(param1.readUnsignedInt());
         if(_loc3_ != 0 && _loc4_ != 0)
         {
            _loc6_ = PetInfoManager.getPetInfoFromAllBag(_loc4_);
            if(_loc3_ > 700000 && _loc3_ <= 700999)
            {
               _loc6_.decorationId = _loc3_;
            }
            else if(_loc3_ >= 900001)
            {
               if(_loc6_)
               {
                  _loc6_.petRideChipId = _loc3_;
                  _loc6_.chipPutOnTime = _loc5_;
               }
            }
            else
            {
               _loc6_.emblemId = _loc3_;
            }
            if(param2)
            {
               if(_loc3_ <= 999999)
               {
                  AlertManager.showHonorAlert(_loc3_,1);
               }
            }
         }
      }
   }
}
