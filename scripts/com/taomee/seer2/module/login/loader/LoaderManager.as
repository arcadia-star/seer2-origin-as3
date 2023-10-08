package com.taomee.seer2.module.login.loader
{
   import com.taomee.seer2.module.login.data.HashMap;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   
   public class LoaderManager
   {
      
      private static const LOAD_MAX:int = 2;
      
      private static var _waitList:Vector.<com.taomee.seer2.module.login.loader.LoginLoaderInfo> = new Vector.<com.taomee.seer2.module.login.loader.LoginLoaderInfo>();
      
      private static var _loadingMap:HashMap = new HashMap();
      
      private static var _loadCount:int = 0;
       
      
      public function LoaderManager()
      {
         super();
      }
      
      public static function Load(param1:String, param2:Function, param3:Function = null, param4:Function = null, param5:Function = null) : void
      {
         var _loc6_:com.taomee.seer2.module.login.loader.LoginLoaderInfo;
         (_loc6_ = new com.taomee.seer2.module.login.loader.LoginLoaderInfo()).url = param1;
         _loc6_.onComplete = param2;
         _loc6_.onError = param4;
         _loc6_.onOpen = param5;
         _loc6_.onProgress = param3;
         _waitList.push(_loc6_);
         nextLoad();
      }
      
      private static function nextLoad() : void
      {
         var _loc1_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc2_:LoadingInfo = null;
         if(_loadCount >= LOAD_MAX)
         {
            return;
         }
         if(_waitList.length > 0)
         {
            _loc1_ = _waitList.shift();
            if(_loadingMap.containKey(_loc1_.url))
            {
               _loc2_ = _loadingMap.getValue(_loc1_.url);
               _loc2_.infoVec.push(_loc1_);
            }
            else
            {
               startLoad(_loc1_);
            }
            nextLoad();
         }
      }
      
      private static function startLoad(param1:com.taomee.seer2.module.login.loader.LoginLoaderInfo) : void
      {
         ++_loadCount;
         var _loc2_:LoaderImpl = LoaderPool.checkOut();
         var _loc3_:LoadingInfo = new LoadingInfo();
         _loc3_.infoVec.push(param1);
         _loc3_.loader = _loc2_;
         _loadingMap.add(param1.url,_loc3_);
         _loc2_.addEventListener(Event.OPEN,onOpen);
         _loc2_.addEventListener(ProgressEvent.PROGRESS,onProgress);
         _loc2_.addEventListener(Event.COMPLETE,onComplete);
         _loc2_.addEventListener(ErrorEvent.ERROR,onError);
         _loc2_.load(param1.url);
      }
      
      private static function onOpen(param1:Event) : void
      {
         var _loc4_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc5_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc2_:LoaderImpl = param1.currentTarget as LoaderImpl;
         var _loc3_:LoadingInfo = _loadingMap.getValue(_loc2_.url);
         for each(_loc4_ in _loc3_.infoVec)
         {
            if(_loc4_.onOpen != null)
            {
               _loc4_.onOpen();
            }
         }
         for each(_loc5_ in _waitList)
         {
            if(_loc5_.url == _loc2_.url)
            {
               _waitList.splice(_waitList.indexOf(_loc5_),1);
               _loc3_.infoVec.push(_loc5_);
               if(_loc5_.onOpen != null)
               {
                  _loc5_.onOpen();
               }
            }
         }
      }
      
      private static function onProgress(param1:ProgressEvent) : void
      {
         var _loc4_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc2_:LoaderImpl = param1.currentTarget as LoaderImpl;
         var _loc3_:LoadingInfo = _loadingMap.getValue(_loc2_.url);
         for each(_loc4_ in _loc3_.infoVec)
         {
            if(_loc4_.onProgress != null)
            {
               _loc4_.onProgress(param1);
            }
         }
      }
      
      private static function onComplete(param1:Event) : void
      {
         var _loc4_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc2_:LoaderImpl = param1.currentTarget as LoaderImpl;
         var _loc3_:LoadingInfo = _loadingMap.getValue(_loc2_.url);
         _loadingMap.remove(_loc2_.url);
         for each(_loc4_ in _loc3_.infoVec)
         {
            _loc4_.onComplete(_loc2_.url,_loc2_.domain,_loc2_.content);
         }
         LoaderPool.checkIn(_loc2_);
         --_loadCount;
         nextLoad();
      }
      
      private static function onError(param1:ErrorEvent) : void
      {
         var _loc4_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc2_:LoaderImpl = param1.currentTarget as LoaderImpl;
         var _loc3_:LoadingInfo = _loadingMap.getValue(_loc2_.url);
         _loadingMap.remove(_loc2_.url);
         for each(_loc4_ in _loc3_.infoVec)
         {
            if(_loc4_.onError != null)
            {
               _loc4_.onError();
            }
         }
         LoaderPool.checkIn(_loc2_);
         --_loadCount;
         nextLoad();
      }
      
      public static function cancel(param1:String, param2:Function) : void
      {
         var _loc4_:com.taomee.seer2.module.login.loader.LoginLoaderInfo = null;
         var _loc5_:LoadingInfo = null;
         var _loc3_:int = 0;
         while(_loc3_ < _waitList.length)
         {
            if((_loc4_ = _waitList[_loc3_]).url == param1 && _loc4_.onComplete == param2)
            {
               _waitList.splice(_loc3_,1);
            }
            _loc3_++;
         }
         if(_loadingMap.containKey(param1))
         {
            _loc5_ = _loadingMap.getValue(param1);
            _loadingMap.remove(param1);
            _loc5_.loader.close();
            LoaderPool.checkIn(_loc5_.loader);
            --_loadCount;
            nextLoad();
         }
      }
   }
}
