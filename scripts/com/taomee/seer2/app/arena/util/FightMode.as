package com.taomee.seer2.app.arena.util
{
   public class FightMode
   {
      
      public static const SINGLE_PVE:int = 1;
      
      public static const FIGHT_TRAINING_PET:int = 2;
      
      public static const FIGHT_BOSS:int = 3;
      
      public static const FIGHT_DOOR_NORMAL:int = 4;
      
      public static const FIGHT_DOOR_50V50:int = 5;
      
      public static const FIGHT_INDREAM:int = 6;
      
      public static const FIGHT_ACTIIVITY:int = 7;
      
      public static const FIGHT_TRAIN_INIT_MON:int = 8;
      
      public static const FIGHT_MAKE_TROUBLE:int = 9;
      
      public static const FIGHT_NPC:int = 10;
      
      public static const FIGHT_CHOOK_FIGHT:int = 11;
      
      public static const FIGHT_ACTIVITY_BOSS_USE_ONE_MON:int = 12;
      
      public static const FIGHT_NPC_MAX:int = 13;
      
      public static const FIGHT_ACT_VS_WuSha:int = 22;
      
      public static const FIGHT_PVP:int = 100;
      
      public static const FIGHT_RING:int = 101;
      
      public static const FIGHT_PVP_DOOR_NORMAL:int = 102;
      
      public static const FIGHT_PVP_DOOR_50V50:int = 103;
      
      public static const FIGHT_PVP_ACTIVIITY:int = 104;
      
      public static const FIGHT_PVP_INVITE_1V1:int = 105;
      
      public static const FIGHT_PVP_INVITE_NVN:int = 106;
      
      public static const FIGHT_PVP_INVITE_2V2:int = 107;
      
      public static const FIGHT_PVP_WOHOO:int = 109;
       
      
      public function FightMode()
      {
         super();
      }
      
      public static function isPVPMode(param1:uint) : Boolean
      {
         if(param1 >= FIGHT_PVP)
         {
            return true;
         }
         return false;
      }
   }
}
