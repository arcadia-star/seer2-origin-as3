package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.TongHunChapter2Support;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_920 extends MapProcessor
   {
       
      
      public function MapProcessor_920(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         TongHunChapter2Support.getInstance().setup();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TongHunChapter2Support.getInstance().dispose();
      }
   }
}
