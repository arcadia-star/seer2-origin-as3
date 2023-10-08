package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_480 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_480(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_149);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
