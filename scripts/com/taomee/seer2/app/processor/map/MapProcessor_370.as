package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.gameRule.spt.SptShaZhiHeSupport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_370 extends MapProcessor
   {
       
      
      public function MapProcessor_370(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         SptShaZhiHeSupport.getInstance().init(_map);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_158);
      }
      
      override public function dispose() : void
      {
         SptShaZhiHeSupport.getInstance().dispose();
      }
   }
}
