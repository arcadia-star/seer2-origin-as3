package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PaintGuessGroupInfo;
   import com.taomee.seer2.app.config.info.PaintGuessInfo;
   import com.taomee.seer2.app.config.info.PaintGuessItemInfo;
   
   public class PaintGuessConfig
   {
      
      private static var _xmlClass:Class = PaintGuessConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _list:Vector.<PaintGuessInfo>;
      
      {
         setup();
      }
      
      public function PaintGuessConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:Vector.<PaintGuessGroupInfo> = null;
         var _loc6_:PaintGuessGroupInfo = null;
         var _loc7_:XML = null;
         var _loc8_:PaintGuessInfo = null;
         var _loc9_:Vector.<PaintGuessItemInfo> = null;
         var _loc10_:XML = null;
         var _loc11_:uint = 0;
         var _loc12_:Array = null;
         var _loc13_:String = null;
         var _loc14_:uint = 0;
         var _loc15_:PaintGuessItemInfo = null;
         _list = Vector.<PaintGuessInfo>([]);
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("paint");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = String(_loc2_.attribute("type"));
            _loc4_ = uint(_loc2_.attribute("sort"));
            _loc5_ = Vector.<PaintGuessGroupInfo>([]);
            for each(_loc7_ in _loc2_.descendants("group"))
            {
               _loc9_ = Vector.<PaintGuessItemInfo>([]);
               for each(_loc10_ in _loc7_.descendants("item"))
               {
                  _loc11_ = uint(_loc10_.attribute("id"));
                  _loc12_ = String(_loc10_.attribute("optionList")).split("|");
                  _loc13_ = String(_loc10_.attribute("yesOption"));
                  _loc14_ = uint(_loc10_.attribute("isOpen"));
                  _loc15_ = new PaintGuessItemInfo(_loc11_,_loc12_,_loc13_,_loc14_);
                  _loc9_.push(_loc15_);
               }
               _loc6_ = new PaintGuessGroupInfo(_loc9_);
               _loc5_.push(_loc6_);
            }
            _loc8_ = new PaintGuessInfo(_loc3_,_loc4_,_loc5_);
            _list.push(_loc8_);
         }
      }
      
      public static function getAll() : Vector.<PaintGuessInfo>
      {
         _list.sort(sortVec);
         return _list;
      }
      
      private static function sortVec(param1:PaintGuessInfo, param2:PaintGuessInfo) : int
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
