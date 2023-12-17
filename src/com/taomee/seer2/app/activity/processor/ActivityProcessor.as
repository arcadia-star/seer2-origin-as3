package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.ActivityManager;
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.ActivityConfig;
   import com.taomee.seer2.app.scene.preProcessor.HomePreProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.system.ApplicationDomain;
   
   public class ActivityProcessor
   {
       
      
      protected var _mapHandler:ActivityMapHandler;
      
      protected var _relatedMapIDArr:Array;
      
      protected var _activity:ActivityDefinition;
      
      public function ActivityProcessor(param1:ActivityDefinition)
      {
         super();
         this._activity = param1;
         this.init();
      }
      
      public function start() : void
      {
         if(SceneManager.active != null && Boolean(SceneManager.active.mapModel))
         {
            this.onMapComplete(null);
         }
      }
      
      public function refresh() : void
      {
         if(this._mapHandler)
         {
            this._mapHandler.process();
         }
      }
      
      protected function init() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_START,this.onMapStart);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
      }
      
      protected function onMapStart(param1:SceneEvent) : void
      {
         if(this._mapHandler != null)
         {
            this._mapHandler.dispose();
            this._mapHandler = null;
         }
      }
      
      protected function onMapComplete(param1:SceneEvent) : void
      {
         if(this._activity.isTimeless() == false && this._activity.isAvailableTime() == false && SceneManager.active && SceneManager.active.type != SceneType.ARENA && SceneManager.prevSceneType != SceneType.ARENA)
         {
            ActivityManager.removeActivityProcessor(this._activity.id);
            return;
         }
         if(this._relatedMapIDArr == null)
         {
            return;
         }
         var _loc2_:Array = this._relatedMapIDArr.slice();
         var _loc3_:Boolean = false;
         var _loc4_:int = int(_loc2_.length - 1);
         while(_loc4_ >= 0)
         {
            if(_loc2_[_loc4_] == HomePreProcessor.NORMAL_RES_ID)
            {
               _loc2_.splice(_loc4_,1);
               _loc3_ = true;
               break;
            }
            _loc4_--;
         }
         if(_loc3_)
         {
            if(SceneManager.active.mapID == ActorManager.actorInfo.id)
            {
               this.processMap();
            }
         }
         else if(_loc2_.indexOf(SceneManager.active.mapID) != -1)
         {
            this.processMap();
         }
      }
      
      protected function processMap() : void
      {
         this._mapHandler = this.createMapHandler();
         if(this._mapHandler)
         {
            this._mapHandler.process();
         }
      }
      
      private function createMapHandler() : ActivityMapHandler
      {
         var _loc1_:String = "com.taomee.seer2.app.activity.processor." + this.lowerFirstChar(ActivityConfig.getActivityProcessorName(this._activity.id));
         var _loc2_:Class = ApplicationDomain.currentDomain.getDefinition(_loc1_ + "." + "ActivityMapHandler_" + SceneManager.active.mapID) as Class;
         if(_loc2_ == null)
         {
            return null;
         }
         return new _loc2_(this);
      }
      
      private function lowerFirstChar(param1:String) : String
      {
         var _loc2_:String = param1.charAt(0);
         _loc2_ = _loc2_.toLowerCase();
         return _loc2_ + param1.substring(1);
      }
      
      public function get activity() : ActivityDefinition
      {
         return this._activity;
      }
      
      public function getActivityID() : uint
      {
         return this._activity.id;
      }
      
      public function getRelateMapIDArr() : Array
      {
         return this._relatedMapIDArr;
      }
      
      public function getMapHandler() : ActivityMapHandler
      {
         return this._mapHandler;
      }
      
      public function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,this.onMapStart);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         if(this._mapHandler)
         {
            this._mapHandler.dispose();
         }
         this._mapHandler = null;
         this._relatedMapIDArr = null;
      }
   }
}
