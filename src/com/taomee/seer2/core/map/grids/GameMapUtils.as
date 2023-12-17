package com.taomee.seer2.core.map.grids
{
   import flash.geom.Point;
   
   public class GameMapUtils
   {
       
      
      public function GameMapUtils()
      {
         super();
      }
      
      public static function getArrByStr(param1:String, param2:int, param3:int) : Array
      {
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc4_:Array = new Array();
         var _loc5_:Array = param1.split(",");
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(_loc7_ < param3)
         {
            _loc8_ = new Array();
            _loc9_ = 0;
            while(_loc9_ < param2)
            {
               _loc8_.push(_loc5_[_loc6_]);
               _loc6_++;
               _loc9_++;
            }
            _loc4_.push(_loc8_);
            _loc7_++;
         }
         return _loc4_;
      }
      
      public static function getCellPoint(param1:int, param2:int, param3:int, param4:int) : Point
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc7_ = int(param3 / param1) * param1 + param1 / 2;
         _loc8_ = int(param4 / param2) * param2 + param2 / 2;
         _loc9_ = (param3 - _loc7_) * param2 / 2;
         _loc10_ = (param4 - _loc8_) * param1 / 2;
         if(Math.abs(_loc9_) + Math.abs(_loc10_) <= param1 * param2 / 4)
         {
            _loc5_ = int(param3 / param1);
            _loc6_ = int(param4 / param2) * 2;
         }
         else
         {
            _loc5_ = int(param3 / param1) + 1;
            param4 -= param2 / 2;
            _loc6_ = int(param4 / param2) * 2 + 1;
         }
         return new Point(_loc5_ - (_loc6_ & 1),_loc6_);
      }
      
      public static function getDirectPoint(param1:Point, param2:int) : Point
      {
         var _loc3_:Point = new Point();
         if(param1.y & 1)
         {
            _loc3_.x = Math.floor(param1.x - param1.y / 2 + 1 + (param2 - 1) / 2);
         }
         else
         {
            _loc3_.x = param1.x - param1.y / 2 + Math.ceil((param2 - 1) / 2);
         }
         _loc3_.y = Math.floor(param1.y / 2 + param1.x + (param1.y & 1));
         return _loc3_;
      }
      
      public static function getDirectPointByPixel(param1:int, param2:int, param3:int, param4:int, param5:int) : Point
      {
         return getDirectPoint(getCellPoint(param1,param2,param3,param4),param5);
      }
      
      public static function getPixelPoint(param1:int, param2:int, param3:int, param4:int) : Point
      {
         var _loc5_:int;
         var _loc6_:int = (_loc5_ = param3 * param1 + param1 / 2) + (param4 & 1) * param1 / 2;
         var _loc7_:int = (param4 + 1) * param2 / 2;
         return new Point(_loc6_,_loc7_);
      }
      
      public static function getStrByArr(param1:Array, param2:int = 0) : String
      {
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc3_:* = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = 0;
            while(_loc5_ < param1[0].length)
            {
               _loc6_ = int(param1[_loc4_][_loc5_]);
               switch(_loc6_)
               {
                  case HetapFishGameConstant.MAPEDITOR_CELL_TYPE_ROAD:
                     _loc7_ = "0";
                     break;
                  case HetapFishGameConstant.MAPEDITOR_CELL_TYPE_HINDER:
                     _loc7_ = "1";
                     break;
                  case HetapFishGameConstant.MAPEDITOR_CELL_TYPE_SPACE:
                     if(param2 == HetapFishGameConstant.TYPE_SAVE_MAP_ROAD)
                     {
                        _loc7_ = "0";
                     }
                     else if(param2 == HetapFishGameConstant.TYPE_SAVE_MAP_HINDER)
                     {
                        _loc7_ = "1";
                     }
                     break;
                  default:
                     throw new Error("地图信息数组中有未知因素！");
               }
               if(_loc3_.length > 0)
               {
                  _loc3_ += ",";
               }
               _loc3_ += _loc7_;
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function getDArrayByArr(param1:Array, param2:int, param3:int, param4:HashMap) : Array
      {
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc5_:Array = new Array();
         var _loc6_:Point = getDirectPoint(new Point(param3,0),param2);
         var _loc7_:Point = getDirectPoint(new Point(param3,param2),param2);
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.y + 1)
         {
            _loc10_ = new Array();
            _loc11_ = 0;
            while(_loc11_ < _loc6_.x + 1)
            {
               _loc10_[_loc11_] = new Object();
               _loc10_[_loc11_].value = 0;
               _loc11_++;
            }
            _loc5_.push(_loc10_);
            _loc8_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < param2)
         {
            _loc12_ = 0;
            while(_loc12_ < param3)
            {
               _loc13_ = getDirectPoint(new Point(_loc12_,_loc9_),param2);
               _loc5_[_loc13_.y][_loc13_.x].value = param1[_loc9_][_loc12_];
               _loc5_[_loc13_.y][_loc13_.x].px = _loc12_;
               _loc5_[_loc13_.y][_loc13_.x].py = _loc9_;
               _loc14_ = new Point(_loc12_,_loc9_);
               param4.put(_loc13_.y + "-" + _loc13_.x,_loc5_[_loc13_.y][_loc13_.x]);
               _loc12_++;
            }
            _loc9_++;
         }
         return _loc5_;
      }
      
      public static function getMaxDirectPoint(param1:int, param2:int) : Point
      {
         var _loc3_:Point = getDirectPoint(new Point(param2,0),param1);
         var _loc4_:Point = getDirectPoint(new Point(param2,param1),param1);
         return new Point(_loc3_.x,_loc4_.y);
      }
   }
}
