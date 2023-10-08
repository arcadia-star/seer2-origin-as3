package com.taomee.seer2.module.login.agent
{
   import com.taomee.seer2.module.login.data.CookieInfo;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   
   public class CookieAgent
   {
      
      public static const MAX_NUM:uint = 3;
      
      private static var _sharedObject:SharedObject;
      
      private static const LOGINACCOUT:String = "loginAccount";
      
      private static const USERACCOUT:String = "userAccount";
      
      private static var _cookieInfoList:Array;
      
      private static var _backFun:Function;
      
      private static var _loader:Loader;
      
      private static var _cookieInfoVec:Vector.<CookieInfo> = null;
       
      
      public function CookieAgent()
      {
         super();
      }
      
      public static function init(param1:String, param2:Function) : void
      {
         _cookieInfoList = [];
         _backFun = param2;
         _sharedObject = LoginModule.getLoginSharedObject();
         parseSO(_sharedObject);
         if(param1 == "")
         {
            updateCookieInfo();
            _sharedObject.data[USERACCOUT] = _cookieInfoList;
            shareObjectFlush();
            _backFun();
         }
         else
         {
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
            _loader.load(new URLRequest(param1 + "readSO.swf" + "?" + Math.random()));
         }
      }
      
      private static function onComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,onComplete);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
         var _loc3_:SharedObject = Object(_loader.content).getUserInfo();
         parseSO(_loc3_,true);
         updateCookieInfo();
         _sharedObject.data[USERACCOUT] = _cookieInfoList;
         shareObjectFlush();
         _backFun();
      }
      
      private static function onIoError(param1:IOErrorEvent) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,onComplete);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
         updateCookieInfo();
         _sharedObject.data[USERACCOUT] = _cookieInfoList;
         shareObjectFlush();
         _backFun();
      }
      
      private static function parseSO(param1:SharedObject, param2:Boolean = false) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:CookieInfo = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:CookieInfo = null;
         if(LOGINACCOUT in param1.data)
         {
            _loc3_ = param1.data[LOGINACCOUT];
            _loc4_ = _loc3_.accountArr;
            _loc5_ = _loc3_.passwordArr;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               (_loc7_ = new CookieInfo()).account = _loc4_[_loc6_];
               _loc7_.loginAccount = _loc4_[_loc6_];
               _loc7_.password = getEncryptPassword(_loc5_[_loc6_]);
               if(param2)
               {
                  _cookieInfoList.unshift(_loc7_);
               }
               else
               {
                  _cookieInfoList.push(_loc7_);
               }
               _loc6_++;
            }
            delete param1.data[LOGINACCOUT];
         }
         if(USERACCOUT in param1.data)
         {
            _loc8_ = param1.data[USERACCOUT] == null ? [] : param1.data[USERACCOUT];
            _loc9_ = 0;
            while(_loc9_ < _loc8_.length)
            {
               (_loc10_ = new CookieInfo()).loginAccount = _loc8_[_loc9_].loginAccount;
               _loc10_.account = _loc8_[_loc9_].account;
               if(_loc8_[_loc9_].uid == null || _loc8_[_loc9_].uid == 0)
               {
                  _loc10_.uid = int(_loc8_[_loc9_].account);
               }
               else
               {
                  _loc10_.uid = _loc8_[_loc9_].uid;
               }
               _loc10_.password = _loc8_[_loc9_].password;
               _loc10_.color = _loc8_[_loc9_].color;
               _loc10_.nick = _loc8_[_loc9_].nick;
               _loc10_.equipReferenceIdArr = _loc8_[_loc9_].equipReferenceIdArr == null ? [] : _loc8_[_loc9_].equipReferenceIdArr;
               if(param2)
               {
                  _cookieInfoList.unshift(_loc10_);
               }
               else
               {
                  _cookieInfoList.push(_loc10_);
               }
               _loc9_++;
            }
         }
      }
      
      private static function updateCookieInfo() : void
      {
         var _loc1_:Object = null;
         var _loc2_:CookieInfo = null;
         deleteRepeatAccount();
         for each(_loc1_ in _sharedObject.data)
         {
            if(_loc1_.hasOwnProperty("id"))
            {
               for each(_loc2_ in _cookieInfoList)
               {
                  if(_loc2_.uid == _loc1_.id)
                  {
                     _loc2_.color = _loc1_.color;
                     _loc2_.nick = _loc1_.nick;
                     _loc2_.equipReferenceIdArr = _loc1_.equipReferenceIdArr;
                  }
               }
               delete _sharedObject.data["user" + _loc1_.id];
            }
         }
      }
      
      private static function deleteRepeatAccount() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = int(_cookieInfoList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc3_ + 1;
            while(_loc4_ < _loc2_)
            {
               if(_cookieInfoList[_loc3_].uid == _cookieInfoList[_loc4_].uid)
               {
                  _loc4_ = ++_loc3_;
               }
               _loc4_++;
            }
            _loc1_.push(_cookieInfoList[_loc3_]);
            _loc3_++;
         }
         _cookieInfoList = _loc1_;
      }
      
      public static function save(param1:String, param2:int, param3:String) : void
      {
         var _loc5_:Object = null;
         var _loc6_:CookieInfo = null;
         var _loc4_:int;
         if((_loc4_ = findAccountIndex(param2)) != -1)
         {
            _loc5_ = _cookieInfoList[_loc4_];
            _cookieInfoList.splice(_loc4_,1);
            _loc5_.account = param1;
            _loc5_.loginAccount = param1;
            _loc5_.uid = param2;
            _loc5_.password = getEncryptPassword(param3);
            _cookieInfoList.push(_loc5_);
         }
         else
         {
            (_loc6_ = new CookieInfo()).account = param1;
            _loc6_.loginAccount = param1;
            _loc6_.uid = param2;
            _loc6_.password = getEncryptPassword(param3);
            _cookieInfoList.push(_loc6_);
            if(_cookieInfoList.length > MAX_NUM)
            {
               _cookieInfoList.shift();
            }
         }
         _sharedObject.data[USERACCOUT] = _cookieInfoList;
         shareObjectFlush();
      }
      
      private static function findAccountIndex(param1:uint) : int
      {
         var _loc2_:int = -1;
         var _loc3_:int = int(_cookieInfoList.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1 == _cookieInfoList[_loc4_].uid)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getCookieInfo(param1:String) : CookieInfo
      {
         var _loc2_:CookieInfo = null;
         for each(_loc2_ in _cookieInfoList)
         {
            if(_loc2_.account == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getCookieInfoVec() : Vector.<CookieInfo>
      {
         var _loc1_:CookieInfo = null;
         var _loc2_:CookieInfo = null;
         if(_cookieInfoVec != null)
         {
            return _cookieInfoVec;
         }
         _cookieInfoVec = new Vector.<CookieInfo>();
         for each(_loc1_ in _cookieInfoList)
         {
            _loc2_ = new CookieInfo();
            _loc2_.account = _loc1_.account;
            _loc2_.loginAccount = _loc1_.loginAccount;
            _loc2_.password = getDecryptPassword(_loc1_.password);
            _loc2_.uid = _loc1_.uid;
            _loc2_.nick = _loc1_.nick;
            _loc2_.color = _loc1_.color;
            _loc2_.equipReferenceIdArr = _loc1_.equipReferenceIdArr;
            _cookieInfoVec.unshift(_loc2_);
         }
         return _cookieInfoVec;
      }
      
      public static function get cookieLen() : int
      {
         return _cookieInfoList.length;
      }
      
      public static function dispose() : void
      {
         _sharedObject = null;
         _cookieInfoList = null;
         _cookieInfoVec = null;
      }
      
      private static function shareObjectFlush() : void
      {
         try
         {
            _sharedObject.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      private static function getEncryptPassword(param1:String) : String
      {
         var _loc2_:String = param1.slice(0,8);
         var _loc3_:String = param1.slice(8,16);
         var _loc4_:String = param1.slice(16,24);
         var _loc5_:String = param1.slice(24,32);
         return _loc3_ + _loc2_ + _loc5_ + _loc4_;
      }
      
      private static function getDecryptPassword(param1:String) : String
      {
         var _loc2_:String = param1.slice(0,8);
         var _loc3_:String = param1.slice(8,16);
         var _loc4_:String = param1.slice(16,24);
         var _loc5_:String = param1.slice(24,32);
         return _loc3_ + _loc2_ + _loc5_ + _loc4_;
      }
   }
}
