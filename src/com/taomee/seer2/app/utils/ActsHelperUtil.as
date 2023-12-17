package com.taomee.seer2.app.utils
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.team.TeamManager;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.FileReference;
   
   public class ActsHelperUtil
   {
       
      
      public function ActsHelperUtil()
      {
         super();
      }
      
      public static function goHandle(param1:*, param2:Object = null) : void
      {
         if(param1 is int)
         {
            if(param1 == 0)
            {
               return;
            }
            if(int(param1) >= 80001)
            {
               SceneManager.changeScene(SceneType.COPY,int(param1));
            }
            else if(int(param1) == 50000)
            {
               SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
            }
            else if(int(param1) == 60000)
            {
               SceneManager.changeScene(SceneType.TEAM,TeamManager.teamId);
            }
            else if(int(param1) == 70000)
            {
               SceneManager.changeScene(SceneType.PLANT,ActorManager.actorInfo.id);
            }
            else
            {
               SceneManager.changeScene(SceneType.LOBBY,int(param1));
            }
         }
         else
         {
            ModuleManager.showModule(URLUtil.getAppModule(param1),"正在打开面板...",param2);
         }
      }
      
      public static function bubbleSort(param1:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc2_:Array = param1.slice();
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = false;
            _loc5_ = int(_loc2_.length - 1);
            while(_loc5_ > _loc4_)
            {
               if(_loc2_[_loc5_] < _loc2_[_loc5_ - 1])
               {
                  _loc6_ = Number(_loc2_[_loc5_]);
                  _loc2_[_loc5_] = _loc2_[_loc5_ - 1];
                  _loc2_[_loc5_ - 1] = _loc6_;
                  _loc3_ = true;
               }
               _loc5_--;
            }
            if(!_loc3_)
            {
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function firstPlayFullScreen(param1:int, param2:String, param3:Boolean = true, param4:int = 1, param5:Function = null, param6:Function = null) : void
      {
         var type:int = param1;
         var resName:String = param2;
         var hasSkip:Boolean = param3;
         var pos:int = param4;
         var beforeFun:Function = param5;
         var afterFun:Function = param6;
         ServerBufferManager.getServerBuffer(type,function(param1:ServerBuffer):void
         {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(pos));
            if(!_loc2_)
            {
               ServerBufferManager.updateServerBuffer(type,pos,1);
               if(beforeFun != null)
               {
                  beforeFun();
                  MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(resName),afterFun,true,hasSkip,2,true);
               }
               else
               {
                  MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(resName),afterFun,true,hasSkip,2,true);
               }
            }
         });
      }
      
      public static function buyHandle(param1:uint, param2:MovieClip, param3:Boolean = false, param4:Boolean = false, param5:Function = null) : void
      {
         var miId:uint = param1;
         var mainUI:MovieClip = param2;
         var isCanBatch:Boolean = param3;
         var isNumLimit:Boolean = param4;
         var callBack:Function = param5;
         mainUI.mouseEnabled = mainUI.mouseChildren = false;
         ModuleManager.addEventListener("BuyPropPanel",ModuleEvent.DISPOSE,function onBuyPanelHide(param1:ModuleEvent):void
         {
            ModuleManager.removeEventListener("BuyPropPanel",ModuleEvent.DISPOSE,onBuyPanelHide);
            mainUI.mouseEnabled = mainUI.mouseChildren = true;
            if(callBack != null)
            {
               callBack();
            }
         });
         ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"),"正在打开米币小面板...",{
            "itemId":miId,
            "canBatch":isCanBatch,
            "islimitNum":isNumLimit,
            "buyType":"mi",
            "itemType":"hideShop"
         });
      }
      
      public static function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
      
      public static function getRandom(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = param1 + int(Math.random() * (param2 - param1) + 0.5);
         if(_loc3_ > param2)
         {
            _loc3_ = param2;
         }
         return _loc3_;
      }
      
      public static function getBit(param1:uint, param2:uint) : uint
      {
         var _loc3_:int = 32;
         var _loc4_:uint = 1;
         var _loc5_:int = 0;
         if(param2 == 0)
         {
            return param1 & _loc4_;
         }
         param1 >>= param2;
         return param1 & _loc4_;
      }
      
      public static function addDesktopUrl(param1:String, param2:String, param3:Function = null, param4:Function = null, param5:String = "http://img1.v.tmcdn.net/img/h000/h66/img20140418102521c26260.png") : void
      {
         var _loc6_:FileReference = null;
         var _loc7_:* = null;
         try
         {
            _loc6_ = new FileReference();
            _loc7_ = (_loc7_ = (_loc7_ = (_loc7_ = (_loc7_ = "[InternetShortcut]" + "\n") + ("URL=" + param2 + "\n")) + ("Modified=70BF4B88E372CC0124" + "\n")) + ("IconFile=" + param5 + "\n")) + ("IconIndex=1" + "\n");
            if(param3 != null)
            {
               _loc6_.addEventListener(Event.COMPLETE,param3);
            }
            if(param4 != null)
            {
               _loc6_.addEventListener(IOErrorEvent.IO_ERROR,param4);
            }
            _loc6_.save(_loc7_,param1 + ".url");
         }
         catch(e:Error)
         {
         }
      }
   }
}
