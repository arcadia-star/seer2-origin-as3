package org.taomee.utils
{
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.utils.Timer;
   
   public class SOFlushPool
   {
      
      private static const TIME:int = 100;
       
      
      private var _poolList:Array;
      
      private var _time:Timer;
      
      public function SOFlushPool()
      {
         super();
         _poolList = new Array();
         _time = new Timer(TIME,0);
         _time.addEventListener(TimerEvent.TIMER,onTime);
      }
      
      private function onTime(param1:TimerEvent) : void
      {
         var e:TimerEvent = param1;
         var shareObject:SharedObject = _poolList.shift();
         if(shareObject != null)
         {
            try
            {
               shareObject.flush();
            }
            catch(e:Error)
            {
               trace("SOFlushPool.flush",e.toString());
            }
         }
         else
         {
            _time.stop();
         }
      }
      
      public function addFlush(param1:SharedObject) : void
      {
         if(!isInPool(param1))
         {
            _poolList.push(param1);
            if(!_time.running)
            {
               _time.reset();
               _time.start();
            }
         }
      }
      
      private function isInPool(param1:SharedObject) : Boolean
      {
         return _poolList.indexOf(param1) != -1;
      }
   }
}
