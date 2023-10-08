package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_490 extends TitleMapProcessor
   {
       
      
      private var _gear:MovieClip;
      
      private var _gearClick:MovieClip;
      
      public function MapProcessor_490(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initGear();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_148);
      }
      
      private function initGear() : void
      {
         this._gear = _map.content["flowers"];
         this._gear.gotoAndStop(1);
         this._gearClick = _map.content["flowerClick"];
         this._gearClick.buttonMode = true;
         DisplayObjectUtil.enableSprite(this._gearClick);
         this._gearClick.addEventListener(MouseEvent.CLICK,this.onGearClick);
      }
      
      private function onGearClick(param1:MouseEvent) : void
      {
         this._gear.play();
         if(SwapManager.isSwapNumberMax(98))
         {
            SwapManager.entrySwap(98);
         }
      }
      
      override public function dispose() : void
      {
         this._gearClick.removeEventListener(MouseEvent.CLICK,this.onGearClick);
         this._gear = null;
         this._gearClick = null;
         super.dispose();
      }
   }
}
