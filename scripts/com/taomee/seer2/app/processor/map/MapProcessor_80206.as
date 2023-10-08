package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80206 extends MapProcessor
   {
       
      
      private const PET_ID:uint = 170;
      
      private const FIGHT_ID:uint = 995;
      
      public function MapProcessor_80206(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.createPet();
      }
      
      private function createPet() : void
      {
         var _loc2_:SpawnedPet = null;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new SpawnedPet(this.PET_ID,this.FIGHT_ID,0);
            MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
            _loc1_++;
         }
      }
   }
}
