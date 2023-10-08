package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct.GetMoneyRideHorseAct;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_340 extends TitleMapProcessor
   {
       
      
      private var _getMoneyRideHorseAct:GetMoneyRideHorseAct;
      
      private var _bucket:MovieClip;
      
      public function MapProcessor_340(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initBucket();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_161);
         this._getMoneyRideHorseAct = new GetMoneyRideHorseAct(_map);
      }
      
      private function initNewAttack() : void
      {
      }
      
      private function initBucket() : void
      {
         this._bucket = _map.content["duck"];
         this._bucket.addEventListener(MouseEvent.CLICK,this.onBucketClick);
      }
      
      private function onBucketClick(param1:MouseEvent) : void
      {
         this._bucket.removeEventListener(MouseEvent.CLICK,this.onBucketClick);
         if(SwapManager.isSwapNumberMax(96))
         {
            SwapManager.entrySwap(96);
         }
      }
      
      override public function dispose() : void
      {
         this._bucket.removeEventListener(MouseEvent.CLICK,this.onBucketClick);
         this._bucket = null;
         if(this._getMoneyRideHorseAct)
         {
            this._getMoneyRideHorseAct.dispose();
            this._getMoneyRideHorseAct = null;
         }
         super.dispose();
      }
   }
}
