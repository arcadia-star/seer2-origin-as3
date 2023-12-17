package com.taomee.seer2.app.inventory.events
{
   import flash.events.Event;
   
   public class ItemEvent extends Event
   {
      
      public static const SERVER_ITEM_GIVEN:String = "serverItemGiven";
      
      public static const REQUEST_ITEM_SUCCESS:String = "requestItemSuccess";
      
      public static const REQUEST_SPECIAL_ITEM_SUCCESS:String = "requestSpecialItemSuccess";
      
      public static const REQUEST_EQUIP_SUCCESS:String = "requestEquipSuccess";
      
      public static const BATCH_USE:String = "batch_use";
      
      public static const REQUEST_ADD_ITEM_SUCCESS:String = "requestAddItemSuccess";
      
      public static const REQUEST_ADD_ITEM_FAIL:String = "requestAddItemFail";
      
      public static const COOKING_COMPLETE:String = "cookingComplete";
      
      public static const MINE_SUCCESS:String = "mineSuccess";
      
      public static const ITEM_SELLOUT:String = "itemSellout";
       
      
      public var content:*;
      
      public function ItemEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.content = param2;
      }
   }
}
