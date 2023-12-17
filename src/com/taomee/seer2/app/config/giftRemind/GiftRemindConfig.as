package com.taomee.seer2.app.config.giftRemind
{
   import org.taomee.ds.HashMap;
   
   public class GiftRemindConfig
   {
      
      private static var _xmlClass:Class = GiftRemindConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _giftMap:HashMap;
      
      {
         setup();
      }
      
      public function GiftRemindConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         _giftMap = new HashMap();
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("vip");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = int(_loc2_.attribute("type"));
            if(_loc3_ == 2)
            {
               parserGift(_loc2_);
            }
         }
      }
      
      private static function parserGift(param1:XML) : void
      {
         var _loc2_:int = int(param1.attribute("level"));
         var _loc3_:VipGiftInfo = new VipGiftInfo();
         _loc3_.monthIndex = int(param1.attribute("monthIndex"));
         _loc3_.weekIndex = int(param1.attribute("weekIndex"));
         _loc3_.monthCheck = int(param1.attribute("checkMonth"));
         _loc3_.weekCheck = int(param1.attribute("checkWeek"));
         _giftMap.add(_loc2_,_loc3_);
      }
      
      public static function getGiftInfo(param1:int) : VipGiftInfo
      {
         return _giftMap.getValue(param1);
      }
   }
}
