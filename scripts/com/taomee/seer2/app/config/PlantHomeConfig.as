package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PlantHomeInfo;
   
   public class PlantHomeConfig
   {
      
      private static var _xmlClass:Class = PlantHomeConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _infoVec:Vector.<PlantHomeInfo>;
      
      {
         setup();
      }
      
      public function PlantHomeConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:PlantHomeInfo = null;
         var _loc3_:XML = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _xml = XML(new _xmlClass());
         _infoVec = Vector.<PlantHomeInfo>([]);
         var _loc2_:XMLList = _xml.descendants("item");
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = new PlantHomeInfo();
            _loc4_ = uint(_loc3_.attribute("level"));
            _loc5_ = String(_loc3_.attribute("idList"));
            _loc6_ = String(_loc3_.attribute("countList"));
            _loc7_ = String(_loc3_.attribute("nextLevelSpecialList"));
            _loc1_.level = _loc4_;
            _loc1_.idList = _loc5_.split("|");
            _loc1_.countList = _loc6_.split("|");
            _loc1_.nextLevelSpecialList = _loc7_.split("|");
            _infoVec.push(_loc1_);
         }
      }
      
      public static function getinfoVec() : Vector.<PlantHomeInfo>
      {
         if(_infoVec.length < 1)
         {
            return null;
         }
         return _infoVec;
      }
      
      public static function getLevelInfo(param1:uint) : PlantHomeInfo
      {
         var _loc2_:PlantHomeInfo = null;
         for each(_loc2_ in _infoVec)
         {
            if(_loc2_.level == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
