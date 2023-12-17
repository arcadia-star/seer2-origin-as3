package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class MapProcessor_2021 extends MapProcessor
   {
       
      
      public function MapProcessor_2021(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ActorManager.showRemoteActor = true;
      }
      
      override public function init() : void
      {
         ActorManager.showRemoteActor = false;
         ActiveCountManager.requestActiveCount(202125,this.getFightNum);
      }
      
      private function getFightNum(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SpawnedPet = null;
         if(param1 == 202125 && param2 == 2)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("MaiBeastPanel"),"打开中...","1");
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               _loc4_ = new SpawnedPet(28,252,0);
               MobileManager.addMobile(_loc4_,MobileType.SPAWNED_PET);
               _loc3_++;
            }
         }
      }
   }
}
