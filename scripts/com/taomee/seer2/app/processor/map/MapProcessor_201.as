package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcessor_201 extends TitleMapProcessor
   {
       
      
      private var _teleport2:Teleport;
      
      private var _funnyMC:MovieClip;
      
      public function MapProcessor_201(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initTeleport();
         this.initFunnyCrab();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_143);
      }
      
      private function initTeleport() : void
      {
         this._teleport2 = AnimateElementManager.getElement(2) as Teleport;
         this._teleport2.visible = false;
      }
      
      private function showTeleport(param1:Teleport) : void
      {
         param1.visible = true;
      }
      
      private function initFunnyCrab() : void
      {
         this._funnyMC = _map.content["funnyCartoon"] as MovieClip;
         this._funnyMC.gotoAndStop(1);
         this._funnyMC.addEventListener(Event.ENTER_FRAME,this.onCrabEnterFrame);
      }
      
      private function onCrabEnterFrame(param1:Event) : void
      {
         if(this._funnyMC.currentFrame == 2)
         {
            this._funnyMC.stop();
            this._funnyMC.removeEventListener(Event.ENTER_FRAME,this.onCrabEnterFrame);
            this.showTeleport(this._teleport2);
         }
      }
      
      override public function dispose() : void
      {
         if(this._funnyMC.hasEventListener(Event.ENTER_FRAME))
         {
            this._funnyMC.removeEventListener(Event.ENTER_FRAME,this.onCrabEnterFrame);
         }
         this._teleport2 = null;
         this._funnyMC = null;
         super.dispose();
      }
   }
}
