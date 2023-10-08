package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.app.activity.processor.waterRecapture.ChrismasSpecialWaterEvent;
   
   public class WaterRecapture extends ActivityProcessor
   {
      
      private static const CHRISMAS_EVENT_ID:uint = 12;
       
      
      private var _specialEvent:com.taomee.seer2.app.activity.processor.WaterGrassCSE;
      
      public function WaterRecapture(param1:ActivityDefinition)
      {
         _relatedMapIDArr = [170,171];
         super(param1);
      }
      
      override public function start() : void
      {
         this._specialEvent = new ChrismasSpecialWaterEvent(CHRISMAS_EVENT_ID,this);
         super.start();
      }
      
      override public function refresh() : void
      {
         super.refresh();
      }
      
      override public function dispose() : void
      {
         this._specialEvent.dispose();
         this._specialEvent = null;
         super.dispose();
      }
   }
}
