package com.taomee.seer2.app.team
{
   public class TeamTitle
   {
      
      public static const CAPTAIN:int = 1;
      
      public static const MEMBER:int = 2;
      
      public static const SUBCAPTAIN:int = 3;
       
      
      public function TeamTitle()
      {
         super();
      }
      
      public static function getTitle(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case CAPTAIN:
               _loc2_ = "队长";
               break;
            case MEMBER:
               _loc2_ = "队员";
               break;
            case SUBCAPTAIN:
               _loc2_ = "副队长";
               break;
            default:
               _loc2_ = "暂无头衔";
         }
         return _loc2_;
      }
   }
}
