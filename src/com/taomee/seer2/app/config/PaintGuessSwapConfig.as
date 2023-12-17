package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PaintGuessSwapInfo;
   import com.taomee.seer2.app.config.info.PaintGuessSwapItemInfo;
   
   public class PaintGuessSwapConfig
   {
      
      private static var _xmlClass:Class = PaintGuessSwapConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _list:Vector.<PaintGuessSwapInfo>;
      
      {
         setup();
      }
      
      public function PaintGuessSwapConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:Vector.<PaintGuessSwapItemInfo> = null;
         var _loc6_:XML = null;
         var _loc7_:PaintGuessSwapInfo = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:PaintGuessSwapItemInfo = null;
         _list = Vector.<PaintGuessSwapInfo>([]);
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("reward");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = String(_loc2_.attribute("type"));
            _loc4_ = uint(_loc2_.attribute("sort"));
            _loc5_ = Vector.<PaintGuessSwapItemInfo>([]);
            for each(_loc6_ in _loc2_.descendants("item"))
            {
               _loc8_ = uint(_loc6_.attribute("id"));
               _loc9_ = String(_loc6_.attribute("tip"));
               _loc10_ = uint(_loc6_.attribute("isPet"));
               _loc11_ = String(_loc6_.attribute("condition"));
               _loc12_ = uint(_loc6_.attribute("swapId"));
               _loc13_ = uint(_loc6_.attribute("onlyFlag"));
               _loc14_ = new PaintGuessSwapItemInfo(_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_);
               _loc5_.push(_loc14_);
            }
            _loc7_ = new PaintGuessSwapInfo(_loc3_,_loc4_,_loc5_);
            _list.push(_loc7_);
         }
      }
      
      public static function getAll() : Vector.<PaintGuessSwapInfo>
      {
         _list.sort(sortVec);
         return _list;
      }
      
      private static function sortVec(param1:PaintGuessSwapInfo, param2:PaintGuessSwapInfo) : int
      {
         if(param1.sort > param2.sort)
         {
            return 1;
         }
         if(param1.sort < param2.sort)
         {
            return -1;
         }
         return 0;
      }
   }
}
