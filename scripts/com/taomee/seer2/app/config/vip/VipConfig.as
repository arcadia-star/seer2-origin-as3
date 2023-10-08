package com.taomee.seer2.app.config.vip
{
   public class VipConfig
   {
      
      private static var _xmlClass:Class = VipConfig__xmlClass;
      
      private static var _data:Vector.<com.taomee.seer2.app.config.vip.UnitInfo>;
      
      {
         setup();
      }
      
      public function VipConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:com.taomee.seer2.app.config.vip.UnitInfo = null;
         var _loc4_:XML = null;
         _data = new Vector.<com.taomee.seer2.app.config.vip.UnitInfo>();
         var _loc1_:XML = XML(new _xmlClass());
         var _loc3_:XMLList = _loc1_.descendants("item");
         for each(_loc4_ in _loc3_)
         {
            _loc2_ = new com.taomee.seer2.app.config.vip.UnitInfo();
            _loc2_.sort = int(_loc4_.@Sort);
            _loc2_.resId = int(_loc4_.@ResId);
            _loc2_.clickType = String(_loc4_.@ClickType);
            _loc2_.effect = String(_loc4_.@Effect);
            if(String(_loc4_.@Tip) != "")
            {
               _loc2_.tip = String(_loc4_.@Tip);
            }
            _data.push(_loc2_);
         }
      }
      
      public static function get data() : Vector.<com.taomee.seer2.app.config.vip.UnitInfo>
      {
         return _data;
      }
      
      public static function getDataBySort(param1:int) : Vector.<com.taomee.seer2.app.config.vip.UnitInfo>
      {
         var _loc3_:com.taomee.seer2.app.config.vip.UnitInfo = null;
         var _loc2_:Vector.<com.taomee.seer2.app.config.vip.UnitInfo> = new Vector.<com.taomee.seer2.app.config.vip.UnitInfo>();
         for each(_loc3_ in _data)
         {
            if(_loc3_.sort == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}
