package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_3012 extends HuanBeastChapter2Map
   {
       
      
      public function MapProcessor_3012(param1:MapModel)
      {
         super(param1);
         _map.content["shootArea"].visible = false;
         _map.content["shootArea"].gotoAndStop(1);
      }
   }
}
