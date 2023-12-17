package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.ActivityManager;
   import com.taomee.seer2.app.activity.data.ActivityAnimationPlayer;
   import com.taomee.seer2.app.config.ActivityConfig;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class ActivityMapHandler
   {
      
      private static const MINUTES_PER_HOUR:uint = 60;
      
      private static const MILLISECONDS_PER_SECOND:uint = 1000;
       
      
      protected var _isTimeOut:Boolean;
      
      protected var _currentTimeVec:Vector.<uint>;
      
      protected var _activityProcessor:ActivityProcessor;
      
      private var _activityAnimation:ActivityAnimationPlayer;
      
      private var _activityAnimationPathVec:Vector.<String>;
      
      private var _activityId:uint;
      
      public var isAnimationPlaying:Boolean;
      
      public function ActivityMapHandler(param1:ActivityProcessor)
      {
         super();
         this._activityProcessor = param1;
         this._activityId = this._activityProcessor.getActivityID();
         this.initAnimationPathVec();
      }
      
      private function initAnimationPathVec() : void
      {
         this._activityAnimationPathVec = new Vector.<String>();
      }
      
      public function process() : void
      {
         if(this._isTimeOut == false && this._activityProcessor.activity.isTimeless() == false && this._activityProcessor.activity.isAvailableTime() == false)
         {
            this._isTimeOut = true;
            this.doLeavMap();
         }
         else if(this._isTimeOut == false)
         {
            this.getCurrentTimeVec();
         }
      }
      
      private function getCurrentTimeVec() : void
      {
         var _loc2_:Vector.<String> = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         this._currentTimeVec = new Vector.<uint>();
         var _loc1_:uint = uint(TimeManager.getServerTime());
         if(ActivityConfig.getActivityById(this._activityProcessor.getActivityID()) != null)
         {
            _loc2_ = ActivityConfig.getActivityById(this._activityProcessor.getActivityID()).getPhaseTimeVec(_loc1_);
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_].indexOf(":");
            _loc5_ = uint(_loc2_[_loc3_].substring(0,_loc4_)) * MINUTES_PER_HOUR + uint(_loc2_[_loc3_].substring(_loc4_ + 1));
            this._currentTimeVec.push(_loc5_);
            _loc3_++;
         }
      }
      
      protected function playActivityAnimation(param1:String = null) : void
      {
         this._activityAnimationPathVec.push(param1);
         if(this._activityAnimation != null)
         {
            return;
         }
         param1 = this._activityAnimationPathVec.shift();
         if(param1 == null)
         {
            return;
         }
         if(ActivityManager.isPlayActivityAnimation(this._activityId,param1) == false)
         {
            return;
         }
         this.isAnimationPlaying = true;
         NpcDialog.hide();
         SoundManager.enabled = false;
         this._activityAnimation = new ActivityAnimationPlayer(param1);
         ActivityManager.addActivityAnimationPlayNum(this._activityId,param1);
         this._activityAnimation.addEventListener(Event.CLOSE,this.onActivityAnimationClose);
         this._activityAnimation.x += 120;
         this._activityAnimation.y += 50;
         var _loc2_:MovieClip = UIManager.getMovieClip("UI_PlayScreen");
         _loc2_.x -= 120;
         _loc2_.y -= 50;
         this._activityAnimation.addChild(_loc2_);
         LayerManager.topLayer.addChild(this._activityAnimation);
         LayerManager.focusOnTopLayer();
      }
      
      protected function onActivityAnimationClose(param1:Event) : void
      {
         this._activityAnimation.removeEventListener(Event.CLOSE,this.onActivityAnimationClose);
         DisplayObjectUtil.removeFromParent(this._activityAnimation);
         this._activityAnimation.dispose();
         this._activityAnimation = null;
         LayerManager.resetOperation();
         SoundManager.enabled = true;
         this.isAnimationPlaying = false;
         if(Boolean(this._activityAnimationPathVec) && Boolean(this._activityAnimationPathVec.length))
         {
            this.playActivityAnimation();
         }
         else if(this._isTimeOut)
         {
            this.processActivityEnd();
         }
         else
         {
            NpcDialog.reShow();
         }
      }
      
      protected function processActivityEnd() : void
      {
      }
      
      protected function doLeavMap() : void
      {
         var _loc1_:String = this.getLeavAnimationPath();
         this.playActivityAnimation(_loc1_);
      }
      
      protected function getLeavAnimationPath() : String
      {
         throw new Error("Should be implemented in subclasses");
      }
      
      public function dispose() : void
      {
         this._activityProcessor = null;
      }
   }
}
