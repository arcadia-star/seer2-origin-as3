package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_390 extends TitleMapProcessor
   {
       
      
      private var _wcFacia:MovieClip;
      
      private var _cabinLight:MovieClip;
      
      public function MapProcessor_390(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initWCFacia();
         this.initCabinLight();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_154);
      }
      
      private function initWCFacia() : void
      {
         this._wcFacia = _map.content["wcFacia"];
         this._wcFacia.addEventListener(MouseEvent.CLICK,this.onWCFaciaClick);
      }
      
      private function onWCFaciaClick(param1:MouseEvent) : void
      {
         this._wcFacia.removeEventListener(MouseEvent.CLICK,this.onWCFaciaClick);
         if(SwapManager.isSwapNumberMax(88))
         {
            SwapManager.entrySwap(88);
         }
      }
      
      private function initCabinLight() : void
      {
         this._cabinLight = _map.content["cabinLight"];
         this._cabinLight.addEventListener(MouseEvent.CLICK,this.onCabinLightClick);
      }
      
      private function onCabinLightClick(param1:MouseEvent) : void
      {
         this._cabinLight.removeEventListener(MouseEvent.CLICK,this.onCabinLightClick);
         if(SwapManager.isSwapNumberMax(89))
         {
            SwapManager.entrySwap(89);
         }
      }
      
      override public function dispose() : void
      {
         this._wcFacia.removeEventListener(MouseEvent.CLICK,this.onWCFaciaClick);
         this._wcFacia = null;
         this._cabinLight.removeEventListener(MouseEvent.CLICK,this.onCabinLightClick);
         this._cabinLight = null;
         super.dispose();
      }
   }
}
