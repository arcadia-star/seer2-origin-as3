package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.LeiyiChargingAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_860 extends MapProcessor
   {
       
      
      public function MapProcessor_860(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         LeiyiChargingAct.getInstance().setup();
      }
      
      override public function dispose() : void
      {
         LeiyiChargingAct.getInstance().dispose();
         super.dispose();
      }
   }
}
