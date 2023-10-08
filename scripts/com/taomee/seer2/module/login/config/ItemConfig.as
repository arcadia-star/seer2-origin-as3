package com.taomee.seer2.module.login.config
{
   import com.taomee.seer2.module.login.config.definition.EquipDefinition;
   import flash.utils.Dictionary;
   
   public class ItemConfig
   {
      
      private static var _xmlClass:Class = ItemConfig__xmlClass;
      
      private static var _itemXML:XML;
      
      private static var _itemMap:Dictionary;
      
      {
         setup();
      }
      
      public function ItemConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:XMLList = null;
         var _loc5_:XML = null;
         var _loc6_:EquipDefinition = null;
         _itemMap = new Dictionary();
         _itemXML = XML(new _xmlClass());
         var _loc1_:XMLList = _itemXML.descendants("Cat");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = int(_loc2_.attribute("ID"));
            if(_loc3_ == 1)
            {
               _loc4_ = _loc2_.descendants("Item");
               for each(_loc5_ in _loc4_)
               {
                  (_loc6_ = new EquipDefinition()).id = int(_loc5_.attribute("ID"));
                  _loc6_.name = _loc5_.attribute("Name");
                  _loc6_.slotIndex = int(_loc5_.attribute("SlotIndex"));
                  _loc6_.suitId = int(_loc5_.attribute("SuitID"));
                  _loc6_.isVipOnly = int(_loc5_.attribute("VipOnly")) == 1;
                  _loc6_.tip = _loc5_.descendants("Tip");
                  _itemMap[_loc6_.id] = _loc6_;
               }
            }
         }
      }
      
      public static function getEquipDefinition(param1:int) : EquipDefinition
      {
         if(param1 in _itemMap)
         {
            return _itemMap[param1];
         }
         return null;
      }
      
      public static function dispose() : void
      {
         _itemXML = null;
         _itemMap = null;
      }
   }
}
