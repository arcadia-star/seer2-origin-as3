package com.taomee.seer2.app.inventory.item
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.item.PetItemDefinition;
   import com.taomee.seer2.core.inventory.StackableItem;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class PetItem extends StackableItem
   {
       
      
      private var _definition:PetItemDefinition;
      
      private var _experience:int;
      
      private var _experiencePercent:Number;
      
      private var _hp:int;
      
      private var _hpPercent:Number;
      
      public var minLevel:int;
      
      public var maxLevel:int;
      
      public var bonus:Number;
      
      public var type:int;
      
      public var swapId:int;
      
      public function PetItem(param1:int, param2:int, param3:uint, param4:uint = 0)
      {
         super();
         this.referenceId = param1;
         this.quantity = param2;
         this.expiryTime = param3;
         this.getTime = param4;
         if(param1 == 206603)
         {
         }
         this._definition = ItemConfig.getPetDefinition(param1);
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.name = this._definition.name;
         this.quantityLimit = this._definition.quantityLimit;
         this.category = this._definition.category;
         this.currencyType = this._definition.currencyType;
         this.price = this._definition.price;
         this.tradability = this._definition.tradability;
         this.vipTradability = this._definition.vipTradability;
         this.isVipOnly = this._definition.isVipOnly;
         this.tip = this._definition.tip;
         this.bonus = this._definition.bonus;
         this.minLevel = this._definition.minLevel;
         this.maxLevel = this._definition.maxLevel;
         this.initExperience();
         this.initHp();
         this.type = this._definition.type;
         this.swapId = this._definition.swapId;
         this._definition = null;
      }
      
      private function initExperience() : void
      {
         this._experience = 0;
         this._experiencePercent = 0;
         var _loc1_:int = this._definition.experience;
         if(0 < _loc1_ && _loc1_ < 100)
         {
            this._experiencePercent = _loc1_;
         }
         else if(_loc1_ >= 100)
         {
            this._experience = _loc1_;
         }
      }
      
      private function initHp() : void
      {
         this._hp = 0;
         this._hpPercent = 0;
         var _loc1_:int = this._definition.hp;
         if(0 < _loc1_ && _loc1_ < 100)
         {
            this._hpPercent = _loc1_;
         }
         else if(this.experience > 100)
         {
            this._hp = _loc1_;
         }
      }
      
      override public function get iconUrl() : String
      {
         return URLUtil.getPetRelateIcon(this.referenceId);
      }
      
      public function get experience() : int
      {
         return this._experience;
      }
      
      public function get expericePercent() : Number
      {
         return this._experiencePercent;
      }
      
      public function get hp() : int
      {
         return this._hp;
      }
      
      public function get hpPercent() : Number
      {
         return this._hpPercent;
      }
   }
}
