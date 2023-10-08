package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.gameRule.spt.SptFeiYaSiSupport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_710 extends MapProcessor
   {
       
      
      public function MapProcessor_710(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         SptFeiYaSiSupport.getInstance().init(_map);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_266);
      }
      
      override public function dispose() : void
      {
         SptFeiYaSiSupport.getInstance().dispose();
      }
   }
}
