package org.taomee.utils
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class Tick
   {
      
      private static var _o:Shape = new Shape();
      
      public static var timeScaleAll:Number = 1;
      
      private static var _instance:org.taomee.utils.Tick;
       
      
      private var _running:Boolean;
      
      private var _renderoutLength:int;
      
      private var _nextTime:Number;
      
      private var _timeoutMap:Dictionary;
      
      private var _renderoutMap:Dictionary;
      
      private var _valueTime:uint;
      
      private var _renderMap:Dictionary;
      
      private var _timeoutLength:int;
      
      private var _renderLength:int;
      
      public var timeScale:Number = 1;
      
      private var _prevTime:Number;
      
      public function Tick()
      {
         _renderMap = new Dictionary();
         _timeoutMap = new Dictionary();
         _renderoutMap = new Dictionary();
         super();
      }
      
      public static function get instance() : org.taomee.utils.Tick
      {
         if(_instance == null)
         {
            _instance = new org.taomee.utils.Tick();
            _instance.start();
         }
         return _instance;
      }
      
      public function removeRender(param1:Function) : void
      {
         if(param1 in _renderMap)
         {
            delete _renderMap[param1];
            --_renderLength;
         }
      }
      
      public function stop() : void
      {
         _o.removeEventListener(Event.ENTER_FRAME,onEnter);
      }
      
      public function removeTimeout(param1:Function) : void
      {
         if(param1 in _timeoutMap)
         {
            delete _timeoutMap[param1];
            --_timeoutLength;
         }
      }
      
      public function hasRenderAndOut(param1:Function) : Boolean
      {
         return param1 in _renderoutMap;
      }
      
      public function addTimeout(param1:uint, param2:Function) : void
      {
         if(param2 in _timeoutMap == false)
         {
            _timeoutMap[param2] = new TimeoutInfo(param1);
            ++_timeoutLength;
         }
      }
      
      public function removeRenderAndOut(param1:Function) : void
      {
         if(param1 in _renderoutMap)
         {
            delete _renderoutMap[param1];
            --_renderoutLength;
         }
      }
      
      public function hasTimeout(param1:Function) : Boolean
      {
         return param1 in _timeoutMap;
      }
      
      private function onRender() : void
      {
         var _loc1_:TimeoutInfo = null;
         var _loc2_:* = undefined;
         if(_renderLength > 0)
         {
            for(_loc2_ in _renderMap)
            {
               _loc1_ = _renderMap[_loc2_];
               if(_loc1_.delay > 0)
               {
                  if(_loc1_.count >= _loc1_.delay)
                  {
                     _loc2_(_loc1_.count);
                     _loc1_.count = 0;
                  }
               }
               else
               {
                  _loc2_(_valueTime);
               }
               _loc1_.count += _valueTime;
            }
         }
      }
      
      public function addRender(param1:Function, param2:int = 0) : void
      {
         if(param1 in _renderMap == false)
         {
            _renderMap[param1] = new TimeoutInfo(param2);
            ++_renderLength;
         }
      }
      
      public function dispose() : void
      {
         stop();
         _renderMap = null;
         _timeoutMap = null;
         _renderoutMap = null;
      }
      
      public function start() : void
      {
         _o.addEventListener(Event.ENTER_FRAME,onEnter);
      }
      
      private function onTimeout() : void
      {
         var _loc1_:TimeoutInfo = null;
         var _loc2_:* = undefined;
         if(_timeoutLength > 0)
         {
            for(_loc2_ in _timeoutMap)
            {
               _loc1_ = _timeoutMap[_loc2_];
               if(_loc1_.count >= _loc1_.delay)
               {
                  delete _timeoutMap[_loc2_];
                  --_timeoutLength;
                  _loc2_();
               }
               else
               {
                  _loc1_.count += _valueTime;
               }
            }
         }
      }
      
      private function onRenderAndOut() : void
      {
         var _loc1_:TimeoutInfo = null;
         var _loc2_:* = undefined;
         if(_renderoutLength > 0)
         {
            for(_loc2_ in _renderoutMap)
            {
               _loc1_ = _renderoutMap[_loc2_];
               if(_loc1_.count >= _loc1_.delay)
               {
                  delete _renderoutMap[_loc2_];
                  --_renderoutLength;
                  _loc2_(true);
               }
               else
               {
                  _loc2_(false);
                  _loc1_.count += _valueTime;
               }
            }
         }
      }
      
      public function addRenderAndOut(param1:uint, param2:Function) : void
      {
         if(param2 in _renderoutMap == false)
         {
            _renderoutMap[param2] = new TimeoutInfo(param1);
            ++_renderoutLength;
         }
      }
      
      public function hasRender(param1:Function) : Boolean
      {
         return param1 in _renderMap;
      }
      
      private function onEnter(param1:Event) : void
      {
         _nextTime = new Date().getTime();
         if(_prevTime > 0)
         {
            _valueTime = (_nextTime - _prevTime) * timeScale * timeScaleAll;
            onRender();
            onTimeout();
            onRenderAndOut();
         }
         _prevTime = _nextTime;
      }
   }
}

class TimeoutInfo
{
    
   
   public var delay:uint;
   
   public var count:uint;
   
   public function TimeoutInfo(param1:uint)
   {
      super();
      this.delay = param1;
   }
}
