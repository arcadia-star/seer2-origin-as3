package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_3013 extends YiBeastChapter2MapProcessor
   {
       
      
      public function MapProcessor_3013(param1:MapModel)
      {
         super(param1);
         if(_map.content["shootArea"])
         {
            _map.content["shootArea"].visible = false;
         }
      }
   }
}
