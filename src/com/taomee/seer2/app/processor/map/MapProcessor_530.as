package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.gameRule.spt.SptMoGuSupport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_530 extends MapProcessor
   {
       
      
      public function MapProcessor_530(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         SptMoGuSupport.getInstance().init(_map);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_151);
      }
      
      override public function dispose() : void
      {
         SptMoGuSupport.getInstance().dispose();
      }
   }
}
