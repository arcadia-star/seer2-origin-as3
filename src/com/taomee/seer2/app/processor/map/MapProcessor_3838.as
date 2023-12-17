package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.shihunbeast.ShiHunChapter3and4Manager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_3838 extends MapProcessor
   {
       
      
      public function MapProcessor_3838(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         ShiHunChapter3and4Manager.setMapModule(_map);
         ShiHunChapter3and4Manager.init();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ShiHunChapter3and4Manager.dispose();
      }
   }
}
