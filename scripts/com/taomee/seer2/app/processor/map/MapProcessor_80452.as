package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.hotheartyanleishaevolutionLei.HotHeartYanLeiShaEvolutionLeiManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80452 extends MapProcessor
   {
       
      
      public function MapProcessor_80452(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         HotHeartYanLeiShaEvolutionLeiManager.setup(1);
      }
      
      override public function dispose() : void
      {
         HotHeartYanLeiShaEvolutionLeiManager.dispose();
         super.dispose();
      }
   }
}
