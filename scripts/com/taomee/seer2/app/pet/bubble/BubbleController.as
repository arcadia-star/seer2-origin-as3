package com.taomee.seer2.app.pet.bubble
{
   import org.taomee.utils.Tick;
   
   public class BubbleController
   {
      
      private static var _instance:com.taomee.seer2.app.pet.bubble.BubbleController;
      
      private static const SHOW_BUBBLE_INTERVAL:int = 15000;
       
      
      private var _bubbleHostVec:Vector.<com.taomee.seer2.app.pet.bubble.IBubbleHost>;
      
      public function BubbleController()
      {
         super();
         this._bubbleHostVec = new Vector.<com.taomee.seer2.app.pet.bubble.IBubbleHost>();
         Tick.instance.addRender(this.onTimer,SHOW_BUBBLE_INTERVAL);
      }
      
      public static function getInstance() : com.taomee.seer2.app.pet.bubble.BubbleController
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.pet.bubble.BubbleController();
         }
         return _instance;
      }
      
      private function onTimer(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:com.taomee.seer2.app.pet.bubble.IBubbleHost = null;
         var _loc2_:int = int(this._bubbleHostVec.length);
         if(_loc2_ > 0)
         {
            _loc3_ = Math.random() * _loc2_;
            (_loc4_ = this._bubbleHostVec[_loc3_]).showBubble();
         }
      }
      
      public function addBubbleHost(param1:com.taomee.seer2.app.pet.bubble.IBubbleHost) : void
      {
         this._bubbleHostVec.push(param1);
      }
      
      public function removeBubbleHost(param1:com.taomee.seer2.app.pet.bubble.IBubbleHost) : void
      {
         var _loc2_:int = this._bubbleHostVec.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._bubbleHostVec.splice(_loc2_,1);
         }
      }
   }
}
