package com.taomee.seer2.app.config
{
   import com.taomee.seer2.core.manager.TimeManager;
   import org.taomee.ds.HashMap;
   
   public class TimeLimitConfig
   {
      
      private static var _xmlClass:Class = TimeLimitConfig__xmlClass;
      
      private static var _configXML:XML;
      
      private static var _timeActivityMap:HashMap;
      
      {
         initialize();
      }
      
      public function TimeLimitConfig()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _timeActivityMap = new HashMap();
         setup();
      }
      
      private static function setup() : void
      {
         var _loc1_:XML = null;
         var _loc2_:TimeLimitInfo = null;
         var _loc3_:Vector.<TimeLimitDay> = null;
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         _configXML = XML(new _xmlClass());
         for each(_loc1_ in _configXML.children())
         {
            _loc2_ = new TimeLimitInfo();
            _loc3_ = new Vector.<TimeLimitDay>();
            _loc2_.ID = uint(_loc1_.@ID);
            _loc2_.NAME = _loc1_.@NAME;
            _loc2_.FromDate = _loc1_.@FromDate;
            _loc2_.ToDate = _loc1_.@ToDate;
            _loc2_.dayArr = _loc3_;
            for each(_loc4_ in _loc1_.children())
            {
               for each(_loc5_ in _loc4_.children())
               {
                  initone(_loc3_,_loc5_);
               }
            }
            _timeActivityMap.add(uint(_loc2_.ID),_loc2_);
         }
      }
      
      private static function initone(param1:Vector.<TimeLimitDay>, param2:XML) : void
      {
         var _loc3_:TimeLimitDay = new TimeLimitDay();
         _loc3_.WeekDay = uint(param2.@WeekDay);
         _loc3_.TimeStart = String(param2.@TimeStart);
         _loc3_.TimeEnd = String(param2.@TimeEnd);
         param1.push(_loc3_);
      }
      
      private static function getLimitTypeByID(param1:uint) : *
      {
         if(_timeActivityMap.containsKey(param1))
         {
            return _timeActivityMap.getValue(param1);
         }
         return null;
      }
      
      public static function getFromDate(param1:uint) : Date
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Date = null;
         var _loc2_:TimeLimitInfo = getLimitTypeByID(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.FromDate.split(" ");
            _loc4_ = String(_loc3_[0]);
            _loc5_ = String(_loc3_[1]);
            _loc6_ = _loc4_.split("-");
            _loc7_ = _loc5_.split(":");
            return new Date(uint(_loc6_[0]),uint(_loc6_[1]) - 1,uint(_loc6_[2]),uint(_loc7_[0]),uint(_loc7_[1]));
         }
         return null;
      }
      
      public static function getEndDate(param1:uint) : Date
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Date = null;
         var _loc2_:TimeLimitInfo = getLimitTypeByID(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.ToDate.split(" ");
            _loc4_ = String(_loc3_[0]);
            _loc5_ = String(_loc3_[1]);
            _loc6_ = _loc4_.split("-");
            _loc7_ = _loc5_.split(":");
            return new Date(uint(_loc6_[0]),uint(_loc6_[1]) - 1,uint(_loc6_[2]),uint(_loc7_[0]),uint(_loc7_[1]));
         }
         return null;
      }
      
      public static function InLimitTime(param1:uint) : Boolean
      {
         var _loc3_:Date = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Date = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:Date = null;
         var _loc2_:TimeLimitInfo = getLimitTypeByID(param1);
         if(_loc2_)
         {
            _loc3_ = new Date(TimeManager.getServerTime() * 1000);
            if(!_loc2_.FromDate)
            {
               return inLimitDay(_loc2_);
            }
            _loc5_ = String((_loc4_ = _loc2_.FromDate.split(" "))[0]);
            _loc6_ = String(_loc4_[1]);
            _loc7_ = _loc5_.split("-");
            _loc8_ = _loc6_.split(":");
            _loc9_ = new Date(uint(_loc7_[0]),uint(_loc7_[1]) - 1,uint(_loc7_[2]),uint(_loc8_[0]),uint(_loc8_[1]));
            _loc11_ = String((_loc10_ = _loc2_.ToDate.split(" "))[0]);
            _loc12_ = String(_loc10_[1]);
            _loc13_ = _loc11_.split("-");
            _loc14_ = _loc12_.split(":");
            _loc15_ = new Date(uint(_loc13_[0]),uint(_loc13_[1]) - 1,uint(_loc13_[2]),uint(_loc14_[0]),uint(_loc14_[1]));
            if(_loc9_.time <= _loc3_.time && _loc3_.time <= _loc15_.time)
            {
               if(_loc2_.dayArr.length > 0)
               {
                  return inLimitDay(_loc2_);
               }
               return true;
            }
         }
         return false;
      }
      
      public static function isStartFront(param1:uint) : Boolean
      {
         var _loc3_:Date = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Date = null;
         var _loc2_:TimeLimitInfo = getLimitTypeByID(param1);
         if(_loc2_)
         {
            _loc3_ = new Date(TimeManager.getServerTime() * 1000);
            _loc5_ = String((_loc4_ = _loc2_.FromDate.split(" "))[0]);
            _loc6_ = String(_loc4_[1]);
            _loc7_ = _loc5_.split("-");
            _loc8_ = _loc6_.split(":");
            _loc9_ = new Date(uint(_loc7_[0]),uint(_loc7_[1]) - 1,uint(_loc7_[2]),uint(_loc8_[0]),uint(_loc8_[1]));
            if(_loc3_.time < _loc9_.time)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function inLimitDay(param1:TimeLimitInfo) : Boolean
      {
         var _loc3_:Date = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Date = null;
         var _loc9_:Date = null;
         var _loc2_:TimeLimitDay = GetLimitDay(param1.dayArr);
         if(_loc2_)
         {
            _loc3_ = new Date(TimeManager.getServerTime() * 1000);
            _loc4_ = uint(_loc2_.TimeStart.split(" ")[0]);
            _loc5_ = uint(_loc2_.TimeStart.split(" ")[1]);
            _loc6_ = uint(_loc2_.TimeEnd.split(" ")[0]);
            _loc7_ = uint(_loc2_.TimeEnd.split(" ")[1]);
            _loc8_ = new Date(_loc3_.fullYear,_loc3_.month,_loc3_.date,_loc4_,_loc5_);
            _loc9_ = new Date(_loc3_.fullYear,_loc3_.month,_loc3_.date,_loc6_,_loc7_);
            if(_loc8_.time <= _loc3_.time && _loc3_.time <= _loc9_.time)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function GetLimitDay(param1:Vector.<TimeLimitDay>) : TimeLimitDay
      {
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc3_:uint = _loc2_.day;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].WeekDay == _loc3_)
            {
               return param1[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
   }
}
