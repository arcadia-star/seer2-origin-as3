package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct.GetMoneyRideHorseAct;
   import com.taomee.seer2.app.processor.activity.miKaAct.MiKaFindProcessHandle;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcessor_550 extends MapProcessor
   {
      
      private static const FRUITS_REWARD550_0:String = "bingReward550_0";
       
      
      private var _bing1:MovieClip;
      
      private var _getMoneyRideHorseAct:GetMoneyRideHorseAct;
      
      private var _mikaFindHandle:MiKaFindProcessHandle;
      
      public function MapProcessor_550(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initBingSwap();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_176);
         this._getMoneyRideHorseAct = new GetMoneyRideHorseAct(_map);
         this._mikaFindHandle = new MiKaFindProcessHandle(_map);
      }
      
      private function initBingSwap() : void
      {
         this._bing1 = _map.content["bing"];
         this._bing1.addEventListener(FRUITS_REWARD550_0,this.onSwap1);
      }
      
      private function onSwap1(param1:Event) : void
      {
         this._bing1.removeEventListener(FRUITS_REWARD550_0,this.onSwap1);
         if(SwapManager.isSwapNumberMax(216))
         {
            SwapManager.entrySwap(216);
         }
      }
      
      override public function dispose() : void
      {
         if(this._bing1)
         {
            this._bing1.removeEventListener(FRUITS_REWARD550_0,this.onSwap1);
            this._bing1 = null;
         }
         if(this._getMoneyRideHorseAct)
         {
            this._getMoneyRideHorseAct.dispose();
            this._getMoneyRideHorseAct = null;
         }
         if(this._mikaFindHandle)
         {
            this._mikaFindHandle.dispose();
            this._mikaFindHandle = null;
         }
      }
   }
}
