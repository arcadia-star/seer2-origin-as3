package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.YiteFightInfo;
   
   public class YiteFightConfig
   {
      
      private static var _xmlClass:Class = YiteFightConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _infoVec:Vector.<YiteFightInfo>;
      
      {
         setup();
      }
      
      public function YiteFightConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:YiteFightInfo = null;
         var _loc3_:XML = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _xml = XML(new _xmlClass());
         _infoVec = Vector.<YiteFightInfo>([]);
         var _loc2_:XMLList = _xml.descendants("yite");
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = new YiteFightInfo();
            _loc4_ = uint(_loc3_.attribute("index"));
            _loc5_ = uint(_loc3_.attribute("checkTime"));
            _loc6_ = uint(_loc3_.attribute("resId"));
            _loc1_.index = _loc4_;
            _loc1_.checkTime = _loc5_;
            _loc1_.resId = _loc6_;
            _infoVec.push(_loc1_);
         }
      }
      
      public static function getInfoVec() : Vector.<YiteFightInfo>
      {
         if(_infoVec.length < 1)
         {
            return null;
         }
         return _infoVec;
      }
   }
}
