package com.taomee.seer2.module.login.agent
{
   import com.taomee.seer2.module.login.data.HashMap;
   import com.taomee.seer2.module.login.loader.LoaderManager;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.VersionManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.Timer;
   
   public class LoaderAgent
   {
      
      private static var _eventDispatcher:EventDispatcher;
      
      private static const RES:String = "res/login/";
      
      private static var _urlVec:Vector.<String> = Vector.<String>(["firstPage","backGround","moreUserLogin","mainPage","serverPage1","createRole"]);
      
      private static var _count:int;
      
      private static var _tatolCnt:int;
      
      private static var _domainMap:HashMap;
      
      private static var _cancelVec:Vector.<String>;
      
      public static var rootUrl:String;
      
      private static var _timer:Timer = new Timer(1000);
       
      
      public function LoaderAgent()
      {
         super();
      }
      
      public static function setup(param1:String) : void
      {
         LoaderAgent.rootUrl = param1;
         _eventDispatcher = new EventDispatcher();
         _count = 0;
         randomFirst();
         _tatolCnt = _urlVec.length;
         _domainMap = new HashMap();
         _cancelVec = new Vector.<String>();
         startLoad();
      }
      
      private static function randomFirst() : void
      {
         var _loc1_:Number = Math.random() * 100;
         if(_loc1_ < 50)
         {
            _urlVec[4] = "serverPage";
         }
      }
      
      public static function get currServerPage() : String
      {
         return _urlVec[4];
      }
      
      private static function startLoad() : void
      {
         var _loc2_:String = null;
         var _loc1_:int = _cancelVec.indexOf(_urlVec[_count]);
         if(_loc1_ != -1)
         {
            ++_count;
            if(_count < _tatolCnt)
            {
               startLoad();
            }
         }
         else
         {
            if(_urlVec[_count] == "firstPage")
            {
               _urlVec[_count] = getCurPageStr();
            }
            _loc2_ = LoaderAgent.rootUrl + VersionManager.getURL(RES + _urlVec[_count] + ".swf");
            LoaderManager.Load(_loc2_,load,null,onLoadError);
            if(_count == 0)
            {
               _timer.addEventListener(TimerEvent.TIMER,onTimer);
               _timer.start();
               LoginStatistics.newSendNovice("基本数据","-1","首页素材加载","开始加载");
            }
         }
      }
      
      private static function getCurPageStr() : String
      {
         return "firstPage";
      }
      
      private static function onTimer(param1:TimerEvent) : void
      {
         if(_timer.currentCount >= 10)
         {
            LoginStatistics.newSendNovice("基本数据","-1","首页素材加载","加载时长在10s及以上");
         }
         else
         {
            LoginStatistics.newSendNovice("基本数据","-1","首页素材加载","加载时长在[" + (_timer.currentCount - 1) + "," + _timer.currentCount + ")s");
         }
      }
      
      private static function load(param1:String, param2:ApplicationDomain, param3:DisplayObject) : void
      {
         if(_count == 0)
         {
            LoginStatistics.newSendNovice("基本数据","-1","首页素材加载","加载成功");
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener(TimerEvent.TIMER,onTimer);
            }
         }
         if(param3 is MovieClip)
         {
            (param3 as MovieClip).gotoAndStop(1);
         }
         if(_domainMap == null || _count >= _urlVec.length)
         {
            return;
         }
         _domainMap.add(_urlVec[_count],{
            "domain":param2,
            "content":param3
         });
         _eventDispatcher.dispatchEvent(new Event(_urlVec[_count]));
         ++_count;
         if(_count < _tatolCnt)
         {
            startLoad();
         }
      }
      
      private static function onLoadError() : void
      {
         if(_count == 0)
         {
            LoginStatistics.newSendNovice("基本数据","-1","首页素材加载","加载失败");
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener(TimerEvent.TIMER,onTimer);
            }
         }
         ++_count;
         if(_count < _tatolCnt)
         {
            startLoad();
         }
      }
      
      public static function cancel(param1:String) : void
      {
         _cancelVec.push(param1);
      }
      
      public static function dispose() : void
      {
         _eventDispatcher = null;
         _domainMap = null;
         _urlVec = null;
         _timer = null;
      }
      
      public static function addUrlVec() : void
      {
         _urlVec.push("intro");
         _tatolCnt = _urlVec.length;
         startLoad();
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _eventDispatcher.addEventListener(param1,param2);
      }
      
      public static function removeEventListner(param1:String, param2:Function) : void
      {
         _eventDispatcher.removeEventListener(param1,param2);
      }
      
      public static function getDomain(param1:String) : ApplicationDomain
      {
         if(_domainMap.containKey(param1))
         {
            return _domainMap.getValue(param1).domain;
         }
         return null;
      }
      
      public static function getContent(param1:String) : DisplayObject
      {
         if(_domainMap.containKey(param1))
         {
            return _domainMap.getValue(param1).content;
         }
         return null;
      }
      
      public static function loadDomain(param1:String) : void
      {
         if(_domainMap.containKey(param1))
         {
            _eventDispatcher.dispatchEvent(new Event(param1));
         }
      }
   }
}
