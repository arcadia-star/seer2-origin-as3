package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.GuangMingHuangDiAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80508 extends MapProcessor
   {
       
      
      public function MapProcessor_80508(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         GuangMingHuangDiAct.getInstance().setUp();
      }
      
      override public function dispose() : void
      {
         GuangMingHuangDiAct.getInstance().dispose();
         super.dispose();
      }
   }
}
