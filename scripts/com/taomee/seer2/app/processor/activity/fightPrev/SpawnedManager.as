package com.taomee.seer2.app.processor.activity.fightPrev
{
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   
   public class SpawnedManager
   {
       
      
      public function SpawnedManager()
      {
         super();
      }
      
      public static function addSpawned(param1:Array) : void
      {
         var _loc2_:SpawnedPet = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = new SpawnedPet(_loc3_[0],_loc3_[1],_loc3_[2]);
            MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
            _loc4_++;
         }
      }
   }
}
