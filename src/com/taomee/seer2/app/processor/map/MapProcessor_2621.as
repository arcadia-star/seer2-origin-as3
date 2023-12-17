package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_2621 extends HuanBeastChapter1Map
   {
       
      
      public function MapProcessor_2621(param1:MapModel)
      {
         step = 3;
         monsterId = 75;
         super(param1);
         _map.content["handWave"].visible = false;
         _map.content["handWave"].gotoAndStop(1);
         _map.content["stoneGame"].visible = false;
         _map.content["stoneGame"].gotoAndStop(1);
      }
   }
}
