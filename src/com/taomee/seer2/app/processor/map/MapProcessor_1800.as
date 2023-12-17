package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcessor_1800 extends TitleMapProcessor
   {
      
      private static const FUNNY_REWARD_A:String = "funnyRewardA";
       
      
      private var _funnyMC:MovieClip;
      
      public function MapProcessor_1800(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initFunnyCrab();
      }
      
      private function initFunnyCrab() : void
      {
         this._funnyMC = _map.content["funnyCartoon"] as MovieClip;
         this._funnyMC.addEventListener(FUNNY_REWARD_A,this.onFunnyReward);
      }
      
      private function onFunnyReward(param1:Event) : void
      {
         this._funnyMC.removeEventListener(FUNNY_REWARD_A,this.onFunnyReward);
         if(SwapManager.isSwapNumberMax(6))
         {
            SwapManager.entrySwap(6);
         }
      }
      
      override public function dispose() : void
      {
         if(this._funnyMC.hasEventListener(FUNNY_REWARD_A))
         {
            this._funnyMC.removeEventListener(FUNNY_REWARD_A,this.onFunnyReward);
         }
         this._funnyMC = null;
         super.dispose();
      }
   }
}
