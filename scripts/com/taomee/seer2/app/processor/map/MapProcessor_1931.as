package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcessor_1931 extends MapProcessor
   {
      
      private static const FLOWER_REWARD_3:String = "flowerReward3";
       
      
      private var _passCartoon:MovieClip;
      
      public function MapProcessor_1931(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         ActorManager.showRemoteActor = false;
         DisplayObjectUtil.removeFromParent(_map.content["akns"]);
         this.initPassCartoon();
         ActiveCountManager.requestActiveCount(202125,this.getFightNum);
      }
      
      private function getFightNum(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SpawnedPet = null;
         if(param1 == 202125 && param2 == 7)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("MaiBeastPanel"),"打开中...","1");
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               _loc4_ = new SpawnedPet(31,257,0);
               MobileManager.addMobile(_loc4_,MobileType.SPAWNED_PET);
               _loc3_++;
            }
         }
      }
      
      private function initPassCartoon() : void
      {
         this._passCartoon = _map.content["cartoons"] as MovieClip;
         this._passCartoon.addEventListener(Event.ENTER_FRAME,this.onPassEnterFrame);
      }
      
      private function onPassEnterFrame(param1:Event) : void
      {
         if(this._passCartoon.currentFrame == this._passCartoon.totalFrames)
         {
            this._passCartoon.removeEventListener(Event.ENTER_FRAME,this.onPassEnterFrame);
            DisplayObjectUtil.removeFromParent(_map.path["pathMask"]);
            _map.recalculatePathData();
         }
      }
      
      override public function dispose() : void
      {
         if(this._passCartoon.hasEventListener(Event.ENTER_FRAME))
         {
            this._passCartoon.removeEventListener(Event.ENTER_FRAME,this.onPassEnterFrame);
         }
         ActorManager.showRemoteActor = true;
         this._passCartoon = null;
         super.dispose();
      }
   }
}
