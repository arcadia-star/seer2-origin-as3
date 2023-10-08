package com.taomee.seer2.core.scene
{
   public class SceneType
   {
      
      public static const NULL:int = 0;
      
      public static const LOBBY:int = 1;
      
      public static const ARENA:int = 2;
      
      public static const HOME:int = 3;
      
      public static const TEAM:int = 4;
      
      public static const NOVICE:int = 5;
      
      public static const GUDIE_ARENA:int = 6;
      
      public static const GUDIE_ARENA2:int = 10;
      
      public static const GUDIE_ARENA3:int = 11;
      
      public static const GUDIE_ARENA4:int = 12;
      
      public static const GUDIE_ARENA5:int = 13;
      
      public static const GUIDE_NEW_ARENA1:int = 14;
      
      public static const GUIDE_NEW_ARENA2:int = 15;
      
      public static const GUIDE_NEW_ARENA3:int = 16;
      
      public static const BIG_LOBBY:int = 7;
      
      public static const PLANT:int = 8;
      
      public static const COPY:int = 9;
       
      
      public function SceneType()
      {
         super();
      }
      
      public static function getFromServerType(param1:int) : int
      {
         var _loc2_:int = NULL;
         switch(param1)
         {
            case 0:
               _loc2_ = LOBBY;
               break;
            case 1:
               _loc2_ = HOME;
               break;
            case 2:
               _loc2_ = TEAM;
               break;
            case 3:
               _loc2_ = PLANT;
               break;
            case 4:
               _loc2_ = COPY;
         }
         return _loc2_;
      }
      
      public static function getServerType(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case LOBBY:
               _loc2_ = 0;
               break;
            case HOME:
               _loc2_ = 1;
               break;
            case TEAM:
               _loc2_ = 2;
               break;
            case PLANT:
               _loc2_ = 3;
               break;
            case COPY:
               _loc2_ = 4;
         }
         return _loc2_;
      }
      
      public static function getTypeName(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case LOBBY:
               _loc2_ = "普通";
               break;
            case HOME:
               _loc2_ = "家园";
               break;
            case TEAM:
               _loc2_ = "组队";
               break;
            case PLANT:
               _loc2_ = "种植园";
               break;
            case COPY:
               _loc2_ = "副本地图";
               break;
            case ARENA:
               _loc2_ = "对战地图";
               break;
            case NOVICE:
               _loc2_ = "新手任务";
               break;
            case BIG_LOBBY:
               _loc2_ = "大地图";
               break;
            case GUDIE_ARENA:
               _loc2_ = "新手教学对战";
               break;
            case GUDIE_ARENA2:
               _loc2_ = "新手教学对战2";
               break;
            case GUDIE_ARENA3:
               _loc2_ = "新手教学对战3";
               break;
            case GUDIE_ARENA4:
               _loc2_ = "新手教学对战4";
               break;
            case GUDIE_ARENA5:
               _loc2_ = "新手教学对战5";
         }
         return _loc2_;
      }
      
      public static function hasPath(param1:int) : Boolean
      {
         return !(param1 == ARENA || param1 == GUDIE_ARENA || param1 == GUDIE_ARENA2 || param1 == GUDIE_ARENA3 || param1 == GUDIE_ARENA4 || param1 == GUDIE_ARENA5 || param1 == GUIDE_NEW_ARENA1 || param1 == GUIDE_NEW_ARENA2 || param1 == GUIDE_NEW_ARENA3);
      }
      
      public static function getTypeFromMapID(param1:uint) : int
      {
         if(param1 > 0 && param1 < 10)
         {
            return NOVICE;
         }
         if(param1 >= 10 && param1 < 10000)
         {
            return LOBBY;
         }
         if(param1 >= 50000 && param1 < 60000)
         {
            return HOME;
         }
         if(param1 >= 60000 && param1 < 70000)
         {
            return TEAM;
         }
         if(param1 >= 70000 && param1 < 80000)
         {
            return PLANT;
         }
         if(param1 >= 100000)
         {
            return ARENA;
         }
         return NULL;
      }
   }
}
