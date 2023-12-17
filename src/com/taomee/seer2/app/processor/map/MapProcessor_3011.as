package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_3011 extends HuanBeastChapter1Map
   {
       
      
      public function MapProcessor_3011(param1:MapModel)
      {
         step = 2;
         monsterId = 35;
         super(param1);
         _map.content["shootArea"].visible = false;
         _map.content["shootArea"].gotoAndStop(1);
      }
   }
}
