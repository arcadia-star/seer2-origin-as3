package com.taomee.seer2.app.actor.bubble
{
   public class BubblePool
   {
      
      private static var _vec:Vector.<com.taomee.seer2.app.actor.bubble.Bubble> = new Vector.<com.taomee.seer2.app.actor.bubble.Bubble>();
       
      
      public function BubblePool()
      {
         super();
      }
      
      public static function checkOut() : com.taomee.seer2.app.actor.bubble.Bubble
      {
         var _loc1_:com.taomee.seer2.app.actor.bubble.Bubble = null;
         if(_vec.length > 0)
         {
            _loc1_ = _vec.pop();
         }
         return new com.taomee.seer2.app.actor.bubble.Bubble();
      }
      
      public static function checkIn(param1:com.taomee.seer2.app.actor.bubble.Bubble) : void
      {
         param1.reset();
         _vec.push(param1);
      }
   }
}
