package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dreamlandchest.DreamlandChestManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_191 extends MapProcessor
   {
       
      
      public function MapProcessor_191(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_139);
         DreamlandChestManager.init(_map);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
