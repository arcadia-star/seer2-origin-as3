package com.taomee.seer2.app.actor.group
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import flash.net.SharedObject;
   
   public class UserGroupCookie
   {
      
      private static const COOKIE_NAME:String = "userGroup";
       
      
      public function UserGroupCookie()
      {
         super();
      }
      
      public static function write() : void
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(COOKIE_NAME);
         var _loc2_:Vector.<UserInfo> = UserGroupManager.getGroupAllUser(UserGroupType.BUDDY);
         var _loc3_:Vector.<UserInfo> = UserGroupManager.getGroupAllUser(UserGroupType.BLACK);
         writeUserInfoVec(_loc2_,_loc1_,UserGroupType.BUDDY);
         writeUserInfoVec(_loc3_,_loc1_,UserGroupType.BLACK);
      }
      
      public static function read() : Object
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(COOKIE_NAME);
         var _loc2_:Vector.<UserInfo> = getUserInfoVec(_loc1_,UserGroupType.BUDDY);
         var _loc3_:Vector.<UserInfo> = getUserInfoVec(_loc1_,UserGroupType.BLACK);
         return {
            "buddy":_loc2_,
            "black":_loc3_
         };
      }
      
      public static function addIntervieweeCount(param1:uint) : void
      {
         var _loc4_:Object = null;
         var _loc2_:SharedObject = SharedObjectManager.getUserSharedObject(COOKIE_NAME);
         var _loc3_:Vector.<Object> = _loc2_.data[UserGroupType.BUDDY] as Vector.<Object>;
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.userId == param1)
            {
               ++_loc4_.interviewCount;
               SharedObjectManager.flush(_loc2_);
               break;
            }
         }
      }
      
      public static function getIntervieweeVec() : Vector.<Object>
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(COOKIE_NAME);
         var _loc2_:Vector.<Object> = _loc1_.data[UserGroupType.BUDDY] as Vector.<Object>;
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<Object>();
         }
         else
         {
            _loc2_.sort(sortByInterviewCount);
         }
         return _loc2_;
      }
      
      private static function writeUserInfoVec(param1:Vector.<UserInfo>, param2:SharedObject, param3:String) : void
      {
         var _loc7_:UserInfo = null;
         var _loc8_:Object = null;
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         var _loc5_:int = int(param1.length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1[_loc6_];
            _loc8_ = convertUserInfoToObject(_loc7_,param2);
            _loc4_.push(_loc8_);
            _loc6_++;
         }
         param2.data[param3] = _loc4_;
         SharedObjectManager.flush(param2);
      }
      
      private static function getUserInfoVec(param1:SharedObject, param2:String) : Vector.<UserInfo>
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:UserInfo = null;
         var _loc3_:Vector.<UserInfo> = new Vector.<UserInfo>();
         var _loc4_:Vector.<Object>;
         if((_loc4_ = param1.data[param2] as Vector.<Object>) != null)
         {
            _loc5_ = int(_loc4_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_];
               _loc8_ = convertObjectToUserInfo(_loc7_);
               _loc3_.push(_loc8_);
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      private static function sortByInterviewCount(param1:Object, param2:Object) : int
      {
         if(param1.interviewCount < param2.interviewCount)
         {
            return -1;
         }
         if(param1.interviewCount > param2.interviewCount)
         {
            return 1;
         }
         return 0;
      }
      
      private static function getInterviewCountById(param1:uint, param2:SharedObject) : int
      {
         var _loc5_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<Object> = param2.data[UserGroupType.BUDDY] as Vector.<Object>;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.userId == param1)
            {
               _loc3_ = int(_loc5_.interviewCount);
               break;
            }
         }
         return _loc3_;
      }
      
      private static function convertUserInfoToObject(param1:UserInfo, param2:SharedObject) : Object
      {
         var _loc3_:Object = new Object();
         _loc3_.userId = param1.id;
         _loc3_.nick = param1.nick;
         _loc3_.interviewCount = getInterviewCountById(param1.id,param2);
         _loc3_.vipFlag = param1.vipInfo.vipFlag;
         return _loc3_;
      }
      
      private static function convertObjectToUserInfo(param1:Object) : UserInfo
      {
         var _loc2_:UserInfo = new UserInfo();
         _loc2_.id = param1.userId;
         _loc2_.nick = param1.nick;
         _loc2_.vipInfo.vipFlag = param1.vipFlag;
         return _loc2_;
      }
   }
}
