package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.yilingshouevolution.YiLingShouEvolutionManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80449 extends MapProcessor
   {
       
      
      public function MapProcessor_80449(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         YiLingShouEvolutionManager.setup(_map);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         YiLingShouEvolutionManager.dispose();
      }
   }
}
