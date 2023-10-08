package com.taomee.seer2.app.activity.processor
{
   public class CallLeiyiCSE
   {
       
      
      protected var _eventId:uint;
      
      private var _processor:com.taomee.seer2.app.activity.processor.ActivityProcessor;
      
      public function CallLeiyiCSE(param1:uint, param2:com.taomee.seer2.app.activity.processor.ActivityProcessor)
      {
         super();
         this._processor = param2;
         this._eventId = param1;
         this.processEvent(this._eventId);
      }
      
      private function processEvent(param1:int) : void
      {
         if(this._processor.getMapHandler() == null || this._processor.getMapHandler().isAnimationPlaying == false)
         {
            param1 = param1;
            this.showDialog(param1);
         }
      }
      
      protected function showDialog(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}
