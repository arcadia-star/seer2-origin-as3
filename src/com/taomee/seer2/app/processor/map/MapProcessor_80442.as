package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.leitingevolution.LeiTingEvolutionManager;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80442 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_80442(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         LeiTingEvolutionManager.setup();
      }
      
      override public function dispose() : void
      {
         LeiTingEvolutionManager.dispose();
         super.dispose();
      }
   }
}
