package com.taomee.seer2.app.processor.activity.decoration
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   import flash.geom.Point;
   
   public class DecorationManager
   {
      
      public static const constellactionList:Vector.<String> = Vector.<String>(["水瓶座","双鱼座","白羊座","金牛座","双子座","巨蟹座","狮子座","室女座","天秤座","天蝎座","射手座","摩羯座"]);
       
      
      public function DecorationManager()
      {
         super();
      }
      
      public static function getConstellation(param1:String, param2:String) : uint
      {
         var _loc3_:int = 0;
         switch(uint(param1))
         {
            case 1:
               _loc3_ = uint(param2) >= 20 ? 0 : 11;
               break;
            case 2:
               _loc3_ = uint(param2) >= 19 ? 1 : 0;
               break;
            case 3:
               _loc3_ = uint(param2) >= 21 ? 2 : 1;
               break;
            case 4:
               _loc3_ = uint(param2) >= 20 ? 3 : 2;
               break;
            case 5:
               _loc3_ = uint(param2) >= 21 ? 4 : 3;
               break;
            case 6:
               _loc3_ = uint(param2) >= 22 ? 5 : 4;
               break;
            case 7:
               _loc3_ = uint(param2) >= 23 ? 6 : 5;
               break;
            case 8:
               _loc3_ = uint(param2) >= 23 ? 7 : 6;
               break;
            case 9:
               _loc3_ = uint(param2) >= 23 ? 8 : 7;
               break;
            case 10:
               _loc3_ = uint(param2) >= 24 ? 9 : 8;
               break;
            case 11:
               _loc3_ = uint(param2) >= 23 ? 10 : 9;
               break;
            case 12:
               _loc3_ = uint(param2) >= 22 ? 11 : 10;
         }
         return _loc3_;
      }
      
      public static function getCurDecIndex(param1:String, param2:String) : uint
      {
         var _loc3_:int = 0;
         switch(uint(param1))
         {
            case 1:
               _loc3_ = uint(param2) > 31 ? 0 : 11;
               break;
            case 2:
               _loc3_ = uint(param2) >= 19 ? 1 : 0;
               break;
            case 3:
               _loc3_ = uint(param2) >= 21 ? 2 : 1;
               break;
            case 4:
               _loc3_ = uint(param2) >= 20 ? 3 : 2;
               break;
            case 5:
               _loc3_ = uint(param2) >= 21 ? 4 : 3;
               break;
            case 6:
               _loc3_ = uint(param2) >= 22 ? 5 : 4;
               break;
            case 7:
               _loc3_ = uint(param2) >= 23 ? 6 : 5;
               break;
            case 8:
               _loc3_ = uint(param2) >= 23 ? 7 : 6;
               break;
            case 9:
               _loc3_ = uint(param2) >= 23 ? 8 : 7;
               break;
            case 10:
               _loc3_ = uint(param2) >= 24 ? 9 : 8;
               break;
            case 11:
               _loc3_ = uint(param2) >= 30 ? 10 : 9;
               break;
            case 12:
               _loc3_ = uint(param2) >= 28 ? 11 : 10;
         }
         return _loc3_;
      }
      
      public static function getCurrEnd() : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:uint = _loc1_.month + 1;
         switch(_loc2_)
         {
            case 1:
               _loc4_ = 20;
               _loc3_ = 18;
               break;
            case 2:
               _loc4_ = 19;
               _loc3_ = 20;
               break;
            case 3:
               _loc4_ = 21;
               _loc3_ = 19;
               break;
            case 4:
               _loc4_ = 20;
               _loc3_ = 20;
               break;
            case 5:
               _loc4_ = 21;
               _loc3_ = 21;
               break;
            case 6:
               _loc4_ = 22;
               _loc3_ = 22;
               break;
            case 7:
               _loc4_ = 23;
               _loc3_ = 22;
               break;
            case 8:
               _loc4_ = 23;
               _loc3_ = 22;
               break;
            case 9:
               _loc4_ = 23;
               _loc3_ = 23;
               break;
            case 10:
               _loc4_ = 24;
               _loc3_ = 22;
               break;
            case 11:
               _loc4_ = 23;
               _loc3_ = 21;
               break;
            case 12:
               _loc4_ = 22;
               _loc3_ = 19;
         }
         Array;
         return new _loc4_[_loc3_]();
      }
      
      public static function getStr(param1:UserInfo) : String
      {
         var _loc2_:uint = param1.birthdayInfo.month;
         var _loc3_:uint = param1.birthdayInfo.day;
         return constellactionList[getConstellation(String(_loc2_),String(_loc3_))];
      }
      
      public static function getCurrDecoration() : String
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         return constellactionList[getConstellation(String(_loc1_.month + 1),String(_loc1_.date))];
      }
      
      public static function isThisDecoration() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:uint = getConstellation(String(_loc1_.month + 1),String(_loc1_.date));
         var _loc3_:BirthdayInfo = ActorManager.actorInfo.birthdayInfo;
         var _loc4_:uint = getCurDecIndex(String(_loc3_.month),String(_loc3_.day));
         if(_loc2_ == _loc4_)
         {
            return true;
         }
         return false;
      }
      
      public static function isNewThisDecoration() : Point
      {
         var _loc1_:Point = new Point();
         _loc1_.x = -1;
         _loc1_.y = -1;
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc3_:uint = _loc2_.month + 1;
         var _loc4_:BirthdayInfo;
         var _loc5_:uint = (_loc4_ = ActorManager.actorInfo.birthdayInfo).month;
         _loc1_.y = _loc5_;
         if(_loc3_ == _loc5_)
         {
            _loc1_.x = 1;
         }
         return _loc1_;
      }
   }
}
