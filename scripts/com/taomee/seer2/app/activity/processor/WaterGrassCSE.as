package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class WaterGrassCSE
   {
       
      
      protected var _eventId:uint;
      
      private var _processor:com.taomee.seer2.app.activity.processor.ActivityProcessor;
      
      public function WaterGrassCSE(param1:uint, param2:com.taomee.seer2.app.activity.processor.ActivityProcessor)
      {
         super();
         this._processor = param2;
         this._eventId = param1;
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
         if(_loc2_.id == this._eventId && _loc2_.index == this._eventId)
         {
            this.processEvent();
         }
      }
      
      private function processEvent() : void
      {
         if(this._processor.getMapHandler() == null || this._processor.getMapHandler().isAnimationPlaying == false)
         {
            this.showDialog();
         }
      }
      
      protected function showDialog() : void
      {
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
   }
}
