package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.AegisDestoryKingManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80475 extends MapProcessor
   {
       
      
      public function MapProcessor_80475(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         AegisDestoryKingManager.init();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
