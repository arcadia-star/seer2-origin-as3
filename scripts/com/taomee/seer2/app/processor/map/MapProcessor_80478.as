package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.MiuSiWakeupFirstManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80478 extends MapProcessor
   {
       
      
      public function MapProcessor_80478(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         MiuSiWakeupFirstManager.getInstance().setup();
         super.init();
      }
      
      override public function dispose() : void
      {
         MiuSiWakeupFirstManager.getInstance().dispose();
         super.dispose();
      }
   }
}
