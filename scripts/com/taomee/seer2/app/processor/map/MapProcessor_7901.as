package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class MapProcessor_7901 extends QinBeastChapter1Map
   {
       
      
      public function MapProcessor_7901(param1:MapModel)
      {
         super(param1);
         DisplayObjectUtil.removeFromParent(_map.content["fishingPP"]);
      }
   }
}
