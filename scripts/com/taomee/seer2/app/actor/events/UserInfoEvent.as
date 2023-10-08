package com.taomee.seer2.app.actor.events
{
   import flash.events.Event;
   
   public class UserInfoEvent extends Event
   {
      
      public static const FOLLOWING_PET_UPDATE:String = "followingPetUpdate";
      
      public static const EQUIP_UPDATE:String = "equipUpdate";
      
      public static const TRAINER_SCORE_UPDATE:String = "trainerScoreUpdate";
      
      public static const HIGHESTPETLEVEL_UPDATE:String = "highestPetLevelUpdate";
      
      public static const RIDING_PET_UPDATE:String = "RIDING_PET_UPDATE";
      
      public static const UPDATE_MONEY:String = "UPDATE_MONEY";
      
      public static const UPDATE_COIN:String = "updateCoin";
       
      
      public function UserInfoEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
