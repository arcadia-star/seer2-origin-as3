package org.taomee.utils
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class InvalidateDispatcher
   {
      
      private static var _mc:Shape = new Shape();
       
      
      private var _list:Array;
      
      private var _ed:IEventDispatcher;
      
      public function InvalidateDispatcher(param1:IEventDispatcher)
      {
         _list = [];
         super();
         _ed = param1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Event = null;
         _mc.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
         if(_ed)
         {
            for each(_loc2_ in _list)
            {
               _ed.dispatchEvent(_loc2_);
            }
         }
         _list.length = 0;
      }
      
      public function addEvent(param1:Event) : void
      {
         _list.push(param1);
         _mc.addEventListener(Event.ENTER_FRAME,onEnterFrame);
      }
      
      public function destroy() : void
      {
         _mc.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
         _ed = null;
         _list = null;
      }
   }
}
