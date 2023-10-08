package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import org.taomee.ds.HashMap;
   
   public class MapProcessor_180 extends TitleMapProcessor
   {
      
      private static const SHOOT_FLAG:Array = [{
         "id":3,
         "label":"fire"
      },{
         "id":2,
         "label":"water"
      },{
         "id":1,
         "label":"glass"
      }];
       
      
      private var _funnyMC:MovieClip;
      
      private var _shootArea:MovieClip;
      
      private var _shootRewardMap:HashMap;
      
      public function MapProcessor_180(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initFunnyCrab();
         this.initShootReward();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_138);
      }
      
      private function initFunnyCrab() : void
      {
         this._funnyMC = _map.content["funnyCartoon"];
         this._funnyMC.addEventListener(Event.ENTER_FRAME,this.onFunnyReward);
      }
      
      private function onFunnyReward(param1:Event) : void
      {
         if(this._funnyMC.currentFrame == this._funnyMC.totalFrames)
         {
            this._funnyMC.removeEventListener(Event.ENTER_FRAME,this.onFunnyReward);
            if(SwapManager.isSwapNumberMax(5))
            {
               SwapManager.entrySwap(5);
            }
         }
      }
      
      private function initShootReward() : void
      {
         this._shootRewardMap = new HashMap();
         this._shootRewardMap.add(1,140);
         this._shootRewardMap.add(2,141);
         this._shootRewardMap.add(3,139);
         this._shootArea = this._funnyMC["shootArea"];
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShoot);
      }
      
      private function onShoot(param1:ShootEvent) : void
      {
         var _loc2_:String = null;
         if(param1.info.userID == ActorManager.actorInfo.id && this._funnyMC.currentFrame <= 4 && this._shootArea.hitTestPoint(param1.info.endPos.x,param1.info.endPos.y))
         {
            _loc2_ = this.getShootFlag(param1.info.id);
            if(_loc2_)
            {
               this._funnyMC.gotoAndStop(_loc2_);
               if(SwapManager.isSwapNumberMax(this._shootRewardMap.getValue(param1.info.id)))
               {
                  SwapManager.entrySwap(this._shootRewardMap.getValue(param1.info.id));
               }
            }
         }
      }
      
      protected function getShootFlag(param1:uint) : String
      {
         var _loc2_:Object = null;
         for each(_loc2_ in SHOOT_FLAG)
         {
            if(param1 == _loc2_.id)
            {
               return _loc2_.label;
            }
         }
         return null;
      }
      
      private function clearShootReward() : void
      {
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShoot);
         this._shootArea = null;
      }
      
      override public function dispose() : void
      {
         this.clearShootReward();
         if(this._funnyMC.hasEventListener(Event.ENTER_FRAME))
         {
            this._funnyMC.removeEventListener(Event.ENTER_FRAME,this.onFunnyReward);
         }
         this._funnyMC = null;
         super.dispose();
      }
   }
}
