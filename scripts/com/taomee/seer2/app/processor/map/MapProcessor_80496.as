package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80496 extends MapProcessor
   {
       
      
      public function MapProcessor_80496(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(_map.content["btn"])
         {
            SimpleButton(_map.content["btn"]).addEventListener(MouseEvent.CLICK,this.onOpen);
         }
      }
      
      private function onOpen(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("DespairTowerThirdSeasonPanel");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(Boolean(_map.content["btn"]) && SimpleButton(_map.content["btn"]).hasEventListener(MouseEvent.CLICK))
         {
            SimpleButton(_map.content["btn"]).removeEventListener(MouseEvent.CLICK,this.onOpen);
         }
      }
   }
}
