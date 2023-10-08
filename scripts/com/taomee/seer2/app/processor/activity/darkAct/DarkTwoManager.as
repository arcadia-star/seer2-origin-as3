package com.taomee.seer2.app.processor.activity.darkAct
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.system.ApplicationDomain;
   
   public class DarkTwoManager
   {
      
      private static var _self:com.taomee.seer2.app.processor.activity.darkAct.DarkTwoManager;
       
      
      public var type:int;
      
      private var _obj:com.taomee.seer2.app.processor.activity.darkAct.DarkTwoLayer;
      
      private var _resLib:ApplicationDomain;
      
      public function DarkTwoManager()
      {
         super();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_411);
         this.type = -1;
         this.getURL();
      }
      
      public static function inistance() : com.taomee.seer2.app.processor.activity.darkAct.DarkTwoManager
      {
         if(null == _self)
         {
            _self = new com.taomee.seer2.app.processor.activity.darkAct.DarkTwoManager();
         }
         return _self;
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("darkAct/darkAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
            stateHandle();
            _obj.resLib = _resLib;
         });
      }
      
      public function addObj(param1:com.taomee.seer2.app.processor.activity.darkAct.DarkTwoLayer) : void
      {
         this._obj = param1;
         this._obj.resLib = this._resLib;
      }
      
      public function stateHandle() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.DARK_DEAH,this.onInitGetServer,false);
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.DARK_DEAH,this.onGetServer,false);
         }
         if(SceneManager.prevMapID == 80012 && SceneManager.active.type != SceneType.ARENA)
         {
            this.dispose();
         }
      }
      
      private function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
         _self = null;
         this.type = 0;
         this._obj = null;
         this._resLib = null;
      }
      
      private function onInitGetServer(param1:ServerBuffer) : void
      {
         this.onGetServer(param1);
         if(this.type == 0)
         {
            this._obj.curHandle.playSceneTalk("sceneTalk");
         }
      }
      
      private function onGetServer(param1:ServerBuffer) : void
      {
         var _loc2_:int = param1.readDataAtPostion(0);
         var _loc3_:int = param1.readDataAtPostion(9) - 1;
         var _loc4_:Number = param1.readDataAtPostionGetInt(10);
         var _loc5_:int = param1.readDataAtPostion(14);
         var _loc6_:Number = 180 - (TimeManager.getServerTime() - _loc4_);
         if(this.type == -1)
         {
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            this.type = _loc3_;
            this._obj.initSet([_loc3_,0,0]);
            this._obj.curHandle.initHandle();
         }
         else
         {
            if(_loc3_ == 3)
            {
               this.type = _loc3_;
               this._obj.type = _loc3_;
               ServerMessager.addMessage("已经通过本层关卡");
               this._obj.showNpc();
               return;
            }
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_loc3_ > this.type)
            {
               _loc5_ = 0;
               _loc4_ = 0;
               this.type = _loc3_;
               this._obj.initSet([_loc3_,_loc4_,_loc5_]);
               this._obj.curHandle.completeHandle();
            }
            else
            {
               this._obj.initSet([_loc3_,_loc4_,_loc5_]);
               if(Number(180 - (TimeManager.getServerTime() - _loc4_)) <= 0)
               {
                  this._obj.curHandle.failHandle();
                  this._obj.initSet([_loc3_,0,0]);
                  this._obj.showNpc();
               }
               else
               {
                  this._obj.curHandle.stateUpdate();
                  this._obj.hideNpc();
               }
            }
         }
      }
   }
}
