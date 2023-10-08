package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.HeBenPetAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_88001 extends MapProcessor
   {
       
      
      public function MapProcessor_88001(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         HeBenPetAct.getInstance().setup();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         HeBenPetAct.getInstance().dispose();
      }
   }
}
