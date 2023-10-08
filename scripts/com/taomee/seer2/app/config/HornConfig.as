package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.announcement.horn.HornInfo;
   
   public class HornConfig
   {
      
      private static var _xmlClass:Class = HornConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _hornInfoVec:Vector.<HornInfo>;
      
      {
         setup();
      }
      
      public function HornConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:HornInfo = null;
         var _loc3_:XML = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         _xml = XML(new _xmlClass());
         _hornInfoVec = Vector.<HornInfo>([]);
         var _loc2_:XMLList = _xml.descendants("horns");
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = new HornInfo();
            _loc4_ = uint(_loc3_.attribute("Week"));
            _loc5_ = uint(_loc3_.attribute("Time"));
            _loc6_ = uint(_loc3_.attribute("Minute"));
            _loc7_ = String(_loc3_.attribute("MouseClickType"));
            _loc8_ = String(_loc3_.attribute("Transport"));
            _loc9_ = String(_loc3_.attribute("Content"));
            _loc1_.week = _loc4_;
            _loc1_.time = _loc5_;
            _loc1_.minute = _loc6_;
            _loc1_.mouseClickType = _loc7_;
            _loc1_.transport = _loc8_;
            _loc1_.content = _loc9_;
            _hornInfoVec.push(_loc1_);
         }
      }
      
      public static function getHornInfoVec() : Vector.<HornInfo>
      {
         if(_hornInfoVec.length < 1)
         {
            return null;
         }
         return _hornInfoVec;
      }
   }
}
