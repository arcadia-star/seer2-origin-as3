package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.SimpleButton;
   
   public class MapProcessor_810 extends TitleMapProcessor
   {
       
      
      private var plant:SimpleButton;
      
      private var aaricLeft:SimpleButton;
      
      private var aaricRight:SimpleButton;
      
      public function MapProcessor_810(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.plant = _map.content["plant"];
         this.aaricLeft = _map.content["aaricLeft"];
         this.aaricRight = _map.content["aaricRight"];
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_206);
      }
      
      override public function dispose() : void
      {
         this.plant = null;
         this.aaricLeft = null;
         this.aaricRight = null;
         super.dispose();
      }
   }
}
