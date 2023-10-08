package com.taomee.seer2.app.inventory.item
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.item.EmblemItemDefinition;
   import com.taomee.seer2.core.inventory.StackableItem;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class EmblemItem extends StackableItem
   {
       
      
      private var _definition:EmblemItemDefinition;
      
      public function EmblemItem(param1:int, param2:int, param3:uint, param4:uint = 0)
      {
         super();
         this.referenceId = param1;
         this.quantity = param2;
         this.expiryTime = param3;
         this.getTime = param4;
         this._definition = ItemConfig.getEmblemDefinition(param1);
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
      }
      
      override public function get iconUrl() : String
      {
         return URLUtil.getEmblemIcon(this.referenceId);
      }
   }
}
