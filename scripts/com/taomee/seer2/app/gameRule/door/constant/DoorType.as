package com.taomee.seer2.app.gameRule.door.constant
{
   public class DoorType
   {
      
      public static const Door_NORMAL:uint = 0;
      
      public static const Door_50V50:uint = 1;
      
      public static const PVP_Door_NORMAL:uint = 2;
      
      public static const PVP_Door_50V50:uint = 3;
      
      private static const TIPS:Array = [["试炼之门 普通模式","试炼之门 50V50模式","试炼之战 普通模式","试炼之战 50V50模式"],["勇士之门 普通模式","勇士之门 50V50模式","勇士之战 普通模式","勇士之战 50V50模式"],["竞技之门 普通模式","竞技之门 50V50模式","竞技之战 普通模式","竞技之战 50V50模式"],["英雄之门 普通模式","英雄之门 50V50模式","英雄之战 普通模式","英雄之战 50V50模式"],["双子之门 普通模式","双子之门 50V50模式","双子之战 普通模式","双子之战 50V50模式"],["万王之战 普通模式","万王之战 50V50模式","万王之战 普通模式","万王之战 50V50模式"],["孤独之门 普通模式","孤独之门 50V50模式","孤独之战 普通模式","孤独之战 50V50模式"],["**之门 普通模式","**之门 50V50模式","**之战 普通模式","**之战 50V50模式"]];
       
      
      public function DoorType()
      {
         super();
      }
      
      public static function getDoorTip(param1:uint, param2:uint) : String
      {
         return TIPS[param2 - 1][param1];
      }
   }
}
