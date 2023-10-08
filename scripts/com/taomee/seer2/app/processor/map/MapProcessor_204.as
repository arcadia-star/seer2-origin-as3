package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct.GetMoneyRideHorseAct;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcessor_204 extends TitleMapProcessor
   {
      
      private static const FUNNYSTAR_REWARD_4:String = "funnyStarReward4";
       
      
      private var _blowBubble:MovieClip;
      
      private var _getMoneyRideHorseAct:GetMoneyRideHorseAct;
      
      public function MapProcessor_204(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initFunnyCrab();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_146);
         this._getMoneyRideHorseAct = new GetMoneyRideHorseAct(_map);
      }
      
      private function initFunnyCrab() : void
      {
         this._blowBubble = _map.content["blowBubble"] as MovieClip;
         this._blowBubble.addEventListener(FUNNYSTAR_REWARD_4,this.onFunnyStarReward);
      }
      
      private function onFunnyStarReward(param1:Event) : void
      {
         this._blowBubble.removeEventListener(FUNNYSTAR_REWARD_4,this.onFunnyStarReward);
         if(SwapManager.isSwapNumberMax(10))
         {
            SwapManager.entrySwap(10);
         }
      }
      
      override public function dispose() : void
      {
         if(this._blowBubble.hasEventListener(FUNNYSTAR_REWARD_4))
         {
            this._blowBubble.removeEventListener(FUNNYSTAR_REWARD_4,this.onFunnyStarReward);
         }
         this._blowBubble = null;
         if(this._getMoneyRideHorseAct)
         {
            this._getMoneyRideHorseAct.dispose();
            this._getMoneyRideHorseAct = null;
         }
         super.dispose();
      }
   }
}
