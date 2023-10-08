package com.taomee.seer2.app.actor.constant
{
   public class EquipSlot
   {
      
      public static const TOTAL_SLOT_NUM:int = 11;
      
      public static const HEAD:uint = 1;
      
      public static const HAND_RIGHT:uint = 2;
      
      public static const BODY:uint = 4;
      
      public static const BELT:uint = 5;
      
      public static const FOOT_RIGHT:uint = 6;
      
      public static const WING:uint = 7;
      
      public static const EYE:uint = 8;
      
      public static const FOOT_LEFT:uint = 9;
      
      public static const HAND_LEFT:uint = 10;
      
      public static const DOGZ_RIGHT:uint = 3;
      
      public static const DOGZ_LEFT:uint = 11;
       
      
      public function EquipSlot()
      {
         super();
      }
      
      public static function isAccessory(param1:uint) : Boolean
      {
         return param1 == EquipSlot.HAND_LEFT && param1 == EquipSlot.FOOT_LEFT;
      }
   }
}
