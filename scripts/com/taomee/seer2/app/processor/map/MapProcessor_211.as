package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_211 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_211(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_134);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
