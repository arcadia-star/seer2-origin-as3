package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.TongHunChapter2Support;
   import com.taomee.seer2.app.gameRule.spt.SptKadoshSupport;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_910 extends MapProcessor_920
   {
       
      
      public function MapProcessor_910(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         SptKadoshSupport.getInstance().init(_map);
         TongHunChapter2Support.getInstance().setup();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TongHunChapter2Support.getInstance().dispose();
      }
   }
}
