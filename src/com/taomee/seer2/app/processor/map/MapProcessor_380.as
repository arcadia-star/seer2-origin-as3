package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_380 extends TitleMapProcessor
   {
       
      
      private var _bucket:MovieClip;
      
      public function MapProcessor_380(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initBucket();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_159);
      }
      
      private function initBucket() : void
      {
         this._bucket = _map.content["treasureCase"];
         this._bucket.addEventListener(MouseEvent.CLICK,this.onBucketClick);
      }
      
      private function onBucketClick(param1:MouseEvent) : void
      {
         this._bucket.removeEventListener(MouseEvent.CLICK,this.onBucketClick);
         if(SwapManager.isSwapNumberMax(97))
         {
            SwapManager.entrySwap(97);
         }
      }
      
      override public function dispose() : void
      {
         this._bucket.removeEventListener(MouseEvent.CLICK,this.onBucketClick);
         this._bucket = null;
         super.dispose();
      }
   }
}
