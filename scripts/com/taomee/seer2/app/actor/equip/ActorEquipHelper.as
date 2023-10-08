package com.taomee.seer2.app.actor.equip
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.constant.EquipSlot;
   import com.taomee.seer2.app.actor.util.ActorEquipAssembler;
   import com.taomee.seer2.app.config.PetRideShopConfig;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.core.animation.IAnimation;
   
   public class ActorEquipHelper
   {
       
      
      private var _actor:Actor;
      
      private var _equipPlayer:com.taomee.seer2.app.actor.equip.MultipleEquipPlayer;
      
      private var _equipItemVec:Vector.<EquipItem>;
      
      public function ActorEquipHelper(param1:Actor)
      {
         super();
         this._actor = param1;
         this._equipPlayer = new com.taomee.seer2.app.actor.equip.MultipleEquipPlayer(this._actor);
         this._equipItemVec = new Vector.<EquipItem>();
      }
      
      public function getAnimation() : IAnimation
      {
         return this._equipPlayer;
      }
      
      public function initEquip() : void
      {
         var _loc2_:EquipItem = null;
         var _loc3_:PetInfo = null;
         var _loc4_:int = 0;
         var _loc1_:Vector.<EquipItem> = this._actor.getInfo().equipVec.concat();
         for each(_loc2_ in _loc1_)
         {
            this.addEquip(_loc2_.referenceId);
         }
         _loc3_ = this._actor.getInfo().ridingPetInfo;
         if(_loc3_)
         {
            if(_loc3_.resourceId != 0)
            {
               _loc4_ = PetRideShopConfig.getEquipIdByPetId(_loc3_.resourceId);
               if(PetRideShopConfig.getEquipIdByPetId(_loc4_))
               {
                  this.addEquip(_loc4_);
               }
            }
            else if(_loc3_.petRideChipId != 0)
            {
               this.addEquip(PetRideShopConfig.getEquipIdByChipBackId(_loc3_.petRideChipId));
            }
         }
         this.checkAddDogz();
      }
      
      public function addEquip(param1:int) : void
      {
         var _loc2_:EquipItem = null;
         if(this.hasEquip(param1) == false && param1 != 0)
         {
            _loc2_ = new EquipItem(param1);
            this.addEquipToPlayer(_loc2_);
            this.addEquipToItemVec(_loc2_);
         }
      }
      
      private function checkAddDogz() : void
      {
         this.updateDogzState(false,this._actor.curtDogzId);
      }
      
      public function hasEquip(param1:int) : Boolean
      {
         return this.findEquipByReferenceId(param1) != null;
      }
      
      public function removeEquip(param1:int) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:EquipItem = this.findEquipByReferenceId(param1);
         if(_loc2_ != null)
         {
            _loc3_ = ActorEquipAssembler.getSlotDefaultEquipReferenceId(this._actor.getInfo().color,_loc2_.slotIndex);
            this.removeEquipFromPlayer(_loc2_);
            this.spliceEquipFromEquipVec(_loc2_);
         }
      }
      
      public function updateEquipVec(param1:Vector.<EquipItem>) : void
      {
         var _loc4_:EquipItem = null;
         var _loc5_:EquipItem = null;
         var _loc2_:Vector.<EquipItem> = this.getDifferenceVec(this._equipItemVec,param1);
         var _loc3_:Vector.<EquipItem> = this.getDifferenceVec(param1,this._equipItemVec);
         for each(_loc4_ in _loc2_)
         {
            this.removeEquip(_loc4_.referenceId);
            if(_loc4_.slotIndex == EquipSlot.DOGZ_RIGHT)
            {
               this.updateDogzState(true,_loc4_.referenceId);
            }
         }
         for each(_loc5_ in _loc3_)
         {
            this.addEquip(_loc5_.referenceId);
            if(_loc5_.slotIndex == EquipSlot.DOGZ_RIGHT)
            {
               this.updateDogzState(true,_loc5_.referenceId);
            }
         }
      }
      
      public function showHandAndFoot() : void
      {
         this._equipPlayer.showHandAndFootEquipPlayer();
      }
      
      public function hidHandAndFoot() : void
      {
         this._equipPlayer.hideHandAndFootEquipPlayer();
      }
      
      private function updateDogzState(param1:Boolean = false, param2:uint = 0) : void
      {
         if(this._actor.isDogz == true)
         {
            this._actor.addDogz(param1,param2);
         }
         else
         {
            this._actor.removeDogz(param1,param2);
         }
      }
      
      private function getDifferenceVec(param1:Vector.<EquipItem>, param2:Vector.<EquipItem>) : Vector.<EquipItem>
      {
         var _loc4_:EquipItem = null;
         var _loc3_:Vector.<EquipItem> = new Vector.<EquipItem>();
         for each(_loc4_ in param1)
         {
            if(this.isEquipExistInEquipVec(_loc4_,param2) == false)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function isEquipExistInEquipVec(param1:EquipItem, param2:Vector.<EquipItem>) : Boolean
      {
         var _loc3_:EquipItem = null;
         for each(_loc3_ in param2)
         {
            if(param1.referenceId == _loc3_.referenceId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function addEquipToPlayer(param1:EquipItem) : void
      {
         var _loc2_:EquipItem = null;
         this._equipPlayer.addEquip(param1);
         if(param1.hasAccessory == true)
         {
            _loc2_ = param1.getAccessory();
            this._equipPlayer.addEquip(_loc2_);
         }
         if(param1.slotIndex == EquipSlot.DOGZ_RIGHT)
         {
            this._actor.isDogz = true;
            this._actor.curtDogzId = param1.referenceId;
         }
      }
      
      private function addEquipToItemVec(param1:EquipItem) : void
      {
         var _loc2_:int = int(this._equipItemVec.length - 1);
         while(_loc2_ >= 0)
         {
            if(this._equipItemVec[_loc2_].slotIndex == param1.slotIndex)
            {
               if(param1.slotIndex == 9)
               {
                  if(param1.suitId != 0)
                  {
                     this._equipItemVec.splice(_loc2_,1);
                  }
               }
               else
               {
                  this._equipItemVec.splice(_loc2_,1);
               }
               break;
            }
            _loc2_--;
         }
         if(param1.slotIndex == 9)
         {
            if(param1.suitId != 0)
            {
               this._equipItemVec.push(param1);
            }
         }
         else
         {
            this._equipItemVec.push(param1);
         }
      }
      
      private function findEquipByReferenceId(param1:uint) : EquipItem
      {
         var _loc2_:EquipItem = null;
         for each(_loc2_ in this._equipItemVec)
         {
            if(_loc2_.referenceId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function removeEquipFromPlayer(param1:EquipItem) : void
      {
         var _loc2_:EquipItem = null;
         this._equipPlayer.removeEquip(param1);
         if(param1.hasAccessory == true)
         {
            _loc2_ = param1.getAccessory();
            this._equipPlayer.removeEquip(_loc2_);
         }
         if(param1.slotIndex == EquipSlot.DOGZ_RIGHT)
         {
            this._actor.isDogz = false;
            this._actor.curtDogzId = 0;
         }
      }
      
      private function spliceEquipFromEquipVec(param1:EquipItem) : void
      {
         var _loc2_:int = int(this._equipItemVec.length);
         var _loc3_:int = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            if(this._equipItemVec[_loc3_] == param1)
            {
               this._equipItemVec.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
   }
}
