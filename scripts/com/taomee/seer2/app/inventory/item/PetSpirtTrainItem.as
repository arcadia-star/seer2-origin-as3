package com.taomee.seer2.app.inventory.item
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.item.PetSpirtTrainItemDefinition;
   import com.taomee.seer2.app.config.pet.PetDefinition;
   import com.taomee.seer2.core.inventory.StackableItem;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class PetSpirtTrainItem extends StackableItem
   {
       
      
      private var _definition:PetSpirtTrainItemDefinition;
      
      private var _description:String;
      
      private var _bunchId:int;
      
      private var _petList:Vector.<PetDefinition>;
      
      private var _breedTime:int;
      
      private var _isBleeding:Boolean;
      
      public function PetSpirtTrainItem(param1:int, param2:int, param3:uint, param4:uint = 0)
      {
         super();
         this.referenceId = param1;
         this.quantity = param2;
         this.expiryTime = param3;
         this.getTime = param4;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._definition = ItemConfig.getPetSpirtTrainDefinition(referenceId);
         this.name = this._definition.name;
         this.tip = this._definition.tip;
         this.quantityLimit = this._definition.quantityLimit;
         this._description = this._definition.tip;
         this._breedTime = this._definition.breedTime;
         this._bunchId = PetConfig.getPetDefinition(this._definition.breedMonID).bunchId;
         this._petList = PetConfig.getPetListByBunchId(this._bunchId);
      }
      
      override public function get iconUrl() : String
      {
         return URLUtil.getPetSpirtTrainIcon(this.referenceId);
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function getType() : int
      {
         return this._definition.type;
      }
      
      public function get definition() : PetSpirtTrainItemDefinition
      {
         return this._definition;
      }
      
      public function getBreedTime() : int
      {
         return this._definition.breedTime;
      }
      
      public function getBreedMonID() : int
      {
         return this._definition.breedMonID;
      }
      
      public function getBunchId() : int
      {
         return this._bunchId;
      }
      
      public function get petList() : Vector.<PetDefinition>
      {
         return this._petList;
      }
      
      public function set isBleeding(param1:Boolean) : void
      {
         this._isBleeding = param1;
      }
      
      public function get isBleeding() : Boolean
      {
         return this._isBleeding;
      }
   }
}
