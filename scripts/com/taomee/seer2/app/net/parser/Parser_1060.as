package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.inventory.ItemDescription;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.parser.baseData.ItemSwapInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import flash.utils.IDataInput;
   
   public class Parser_1060
   {
       
      
      public var addItemVec:Vector.<ItemSwapInfo>;
      
      public var removeItemVec:Vector.<ItemSwapInfo>;
      
      public var petId:uint;
      
      public var petResId:uint;
      
      public var activityCount:uint;
      
      public function Parser_1060(param1:IDataInput)
      {
         super();
         this.addItemVec = new Vector.<ItemSwapInfo>();
         this.removeItemVec = new Vector.<ItemSwapInfo>();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         this.activityCount = _loc2_;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.addItemVec.push(new ItemSwapInfo(param1));
            _loc3_++;
         }
         _loc2_ = uint(param1.readUnsignedInt());
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.removeItemVec.push(new ItemSwapInfo(param1));
            _loc3_++;
         }
         this.addPet(param1);
      }
      
      public function showResult(param1:Boolean = true, param2:Function = null, param3:Boolean = true) : void
      {
         this.addItem(param1,param2,param3);
         this.addPetToBag();
         this.removeItem();
      }
      
      public function addItem(param1:Boolean = true, param2:Function = null, param3:Boolean = true) : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc4_:uint = this.addItemVec.length;
         var _loc5_:Vector.<ItemDescription> = new Vector.<ItemDescription>();
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            if(this.addItemVec[_loc6_].id == 1)
            {
               ActorManager.actorInfo.coins += this.addItemVec[_loc6_].count;
               if(param1)
               {
                  _loc5_.push(new ItemDescription(this.addItemVec[_loc6_].id,this.addItemVec[_loc6_].count,this.addItemVec[_loc6_].expireTime));
               }
            }
            else if(19 != this.addItemVec[_loc6_].id)
            {
               _loc7_ = false;
               _loc8_ = 0;
               while(_loc8_ < _loc5_.length)
               {
                  if(_loc5_[_loc8_].referenceId == this.addItemVec[_loc6_].id)
                  {
                     _loc5_[_loc8_].quantity += this.addItemVec[_loc6_].count;
                     _loc7_ = true;
                     break;
                  }
                  _loc8_++;
               }
               if(!_loc7_)
               {
                  _loc5_.push(new ItemDescription(this.addItemVec[_loc6_].id,this.addItemVec[_loc6_].count,this.addItemVec[_loc6_].expireTime));
               }
            }
            _loc6_++;
         }
         ItemManager.addItemList(_loc5_);
         if(param3)
         {
            AlertManager.showItemListGaindeAlert(_loc5_,param2);
         }
      }
      
      public function removeItem() : void
      {
         var _loc1_:uint = this.removeItemVec.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.removeItemVec[_loc2_].id == 1)
            {
               ActorManager.actorInfo.coins -= this.removeItemVec[_loc2_].count;
            }
            else
            {
               ItemManager.reduceItemQuantity(this.removeItemVec[_loc2_].id,this.removeItemVec[_loc2_].count);
            }
            _loc2_++;
         }
      }
      
      private function addPet(param1:IDataInput) : void
      {
         this.petResId = param1.readUnsignedInt();
         this.petId = param1.readUnsignedInt();
      }
      
      public function addPetToBag() : void
      {
         if(this.petResId != 0)
         {
            if(PetInfoManager.isBagFull() == true)
            {
               AlertManager.showGetPetInStorageAlert(this.petResId,1);
            }
            else
            {
               PetInfoManager.requestAddToBagFromStorage(this.petId,this.petResId);
            }
         }
      }
   }
}
