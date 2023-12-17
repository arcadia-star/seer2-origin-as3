package com.taomee.seer2.app.activity.processor.cutePetTour
{
   import com.taomee.seer2.app.activity.ActivityManager;
   import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.activity.processor.CutePetTour;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CutePetTourMapHandler extends ActivityMapHandler
   {
       
      
      private var _fireBalloonMC:MovieClip;
      
      private var _currentPhaseIndex:uint;
      
      private var _isPhaseStarting:Boolean;
      
      public function CutePetTourMapHandler(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override public function process() : void
      {
         var _loc2_:Date = null;
         var _loc1_:uint = (_activityProcessor as CutePetTour).getCurrentPhaseIndex();
         if(Boolean(_loc1_) && SceneManager.active.mapID == _activityProcessor.getRelateMapIDArr()[0])
         {
            if(this._currentPhaseIndex != _loc1_)
            {
               this._currentPhaseIndex = _loc1_;
               _loc2_ = new Date(TimeManager.getServerTime() * 1000);
               this._isPhaseStarting = _loc2_.hours * 60 + _loc2_.minutes == (_activityProcessor as CutePetTour).getCurrentTimeVec()[2 * (this._currentPhaseIndex - 1)];
               this.createChildren();
            }
         }
         else if(Boolean(this._fireBalloonMC) && _isTimeOut == false)
         {
            _isTimeOut = true;
            this.doLeavMap();
         }
      }
      
      private function createChildren() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("3/fireBalloon"),LoadType.SWF,this.onFireBalloonLoaded);
      }
      
      private function onFireBalloonLoaded(param1:ContentInfo) : void
      {
         this._fireBalloonMC = param1.content as MovieClip;
         if(Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel))
         {
            SceneManager.active.mapModel.front.addChild(this._fireBalloonMC);
         }
         this._fireBalloonMC.buttonMode = true;
         this._fireBalloonMC.addEventListener(MouseEvent.CLICK,this.onFireBalloonClick);
         this._fireBalloonMC.addEventListener(Event.ENTER_FRAME,this.onFireBalloonEnterFrame);
         (this._fireBalloonMC["bubbling"] as MovieClip).visible = false;
         if(this._isPhaseStarting)
         {
            this._fireBalloonMC.gotoAndPlay(1);
         }
         else
         {
            this._fireBalloonMC.gotoAndPlay("fixOnMap");
         }
      }
      
      private function onFireBalloonClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(11,"多罗",[[1,"约瑟传说2周年咯，M5也来为周年庆道祝福！"]],["和M5一较高下","我也是来道贺的"],[function():void
         {
            ModuleManager.showModule(URLUtil.getAppModule("CutePetTourSelectFighterPanel"),"正在打开精灵选择面板...");
         },null]);
      }
      
      private function onFireBalloonEnterFrame(param1:Event) : void
      {
         if(this._fireBalloonMC.currentFrameLabel == "fixOnMapEnd")
         {
            this.setBubblingStatus();
            this._fireBalloonMC.gotoAndPlay("fixOnMap");
         }
         else if(this._fireBalloonMC.currentFrame == this._fireBalloonMC.totalFrames)
         {
            this.removeFireBalloon();
            ActivityManager.removeActivityProcessor(_activityProcessor.getActivityID());
         }
      }
      
      private function setBubblingStatus() : void
      {
         (this._fireBalloonMC["bubbling"] as MovieClip).visible = this.isShowBubbling();
         (this._fireBalloonMC["bubbling"] as MovieClip).gotoAndStop(this.getBubblingFrame());
      }
      
      private function isShowBubbling() : Boolean
      {
         return Math.random() * 100 < 30;
      }
      
      private function getBubblingFrame() : uint
      {
         return Math.floor(Math.random() * 6) + 1;
      }
      
      override protected function doLeavMap() : void
      {
         (this._fireBalloonMC["bubbling"] as MovieClip).visible = false;
         this._fireBalloonMC.gotoAndStop(this._fireBalloonMC.totalFrames);
      }
      
      private function removeFireBalloon() : void
      {
         if(this._fireBalloonMC)
         {
            this._fireBalloonMC.removeEventListener(Event.ENTER_FRAME,this.onFireBalloonEnterFrame);
            this._fireBalloonMC = null;
         }
      }
      
      override public function dispose() : void
      {
         QueueLoader.cancel(URLUtil.getActivityAnimation("3/fireBalloon"),this.onFireBalloonLoaded);
         this.removeFireBalloon();
         super.dispose();
      }
   }
}
