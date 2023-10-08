package com.taomee.seer2.core.manager
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.IDataInput;
   import flash.utils.getDefinitionByName;
   import org.taomee.utils.Tick;
   
   public class TimeManager
   {
      
      public static const TIME_UPDATE:String = "timeUpdate";
      
      private static var _loginTime:uint;
      
      private static var _serverTime:uint;
      
      private static var _availableTime:uint;
      
      private static var _doubleExpTime:uint;
      
      private static var _maxAvailableTime:uint;
      
      private static var _isAllowOpenBatteryPanel:Boolean = true;
      
      private static var _precisionServerTime:uint;
      
      private static var _onlineTime:uint;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function TimeManager()
      {
         super();
      }
      
      public static function setupLogin(param1:IDataInput) : void
      {
         _loginTime = param1.readUnsignedInt();
         _serverTime = _loginTime;
         _precisionServerTime = _loginTime;
         updatePrecision();
         _onlineTime = 0;
         setupOnlineTime();
      }
      
      public static function setupTime(param1:IDataInput) : void
      {
         _maxAvailableTime = param1.readUnsignedInt();
         _availableTime = param1.readUnsignedInt();
         _doubleExpTime = param1.readUnsignedInt();
      }
      
      public static function getAvailableTime() : uint
      {
         var _loc1_:uint = uint(_serverTime - _loginTime);
         if(_loc1_ >= _availableTime)
         {
            return 0;
         }
         return _availableTime - _loc1_;
      }
      
      public static function getHasBeenUsedTime() : uint
      {
         return _serverTime - _loginTime;
      }
      
      public static function getAvailableDoubleExpTime() : uint
      {
         var _loc1_:uint = uint(_serverTime - _loginTime);
         if(_loc1_ >= _doubleExpTime)
         {
            return 0;
         }
         return _doubleExpTime - _loc1_;
      }
      
      public static function get doulbeExpTime() : uint
      {
         return _doubleExpTime;
      }
      
      public static function set doulbeExpTime(param1:uint) : void
      {
         _doubleExpTime = param1;
      }
      
      public static function getServerTime() : uint
      {
         return _serverTime;
      }
      
      public static function get availableTime() : uint
      {
         return _availableTime;
      }
      
      public static function set availableTime(param1:uint) : void
      {
         _availableTime = param1;
      }
      
      public static function get loginTime() : uint
      {
         return _loginTime;
      }
      
      public static function set loginTime(param1:uint) : void
      {
         _loginTime = param1;
      }
      
      public static function updateServerTime(param1:uint) : void
      {
         _serverTime = param1;
         _precisionServerTime = param1;
         dispatchEvent(TIME_UPDATE);
      }
      
      public static function getPrecisionServerTime() : uint
      {
         return _precisionServerTime;
      }
      
      public static function getMaxAvailableTime() : uint
      {
         return _maxAvailableTime;
      }
      
      public static function getOnlineTime() : uint
      {
         return _onlineTime;
      }
      
      public static function get isLoginAfterTimeComplete() : Boolean
      {
         if(_availableTime <= 0)
         {
            return true;
         }
         return false;
      }
      
      public static function set isAllowOpenBatteryPanel(param1:Boolean) : void
      {
         _isAllowOpenBatteryPanel = param1;
      }
      
      public static function get isAllowOpenBatteryPanel() : Boolean
      {
         return _isAllowOpenBatteryPanel;
      }
      
      private static function updatePrecision() : void
      {
         Tick.instance.addRender(function(param1:uint):void
         {
            ++_precisionServerTime;
            ++_onlineTime;
         },1000);
      }
      
      private static function setupOnlineTime() : void
      {
         var dayLimitManager:* = getDefinitionByName("com.taomee.seer2.app.manager.DayLimitManager");
         dayLimitManager.getDoCount(898,function(param1:uint):void
         {
            _onlineTime = getHasBeenUsedTime() + param1;
         });
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:String) : void
      {
         if(_dispatcher.hasEventListener(param1))
         {
            _dispatcher.dispatchEvent(new Event(param1));
         }
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function isHolidayEndPrev() : Boolean
      {
         var _loc1_:Date = new Date(getServerTime() * 1000);
         var _loc2_:Date = new Date(2016,1,12);
         return _loc1_.getTime() < _loc2_.getTime() ? true : false;
      }
   }
}
