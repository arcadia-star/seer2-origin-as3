package com.taomee.seer2.app.pet.data
{
   import com.taomee.seer2.app.actor.ActorManager;
   
   public class PetInfoHelper
   {
       
      
      public function PetInfoHelper()
      {
         super();
      }
      
      public static function getCoinsForCure(param1:PetInfo) : int
      {
         var _loc2_:int = 0;
         if(ActorManager.actorInfo.highestPetLevel <= 10)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = param1.maxHp - param1.hp;
         }
         if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         if(ActorManager.getActor().getInfo().vipInfo.isVip())
         {
            _loc2_ *= 0.5;
         }
         return _loc2_;
      }
   }
}
