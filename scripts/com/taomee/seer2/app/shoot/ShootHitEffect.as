package com.taomee.seer2.app.shoot
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ShootHitEffect
   {
       
      
      private var _effectMc:MovieClip;
      
      private var _stateMc:MovieClip;
      
      private var _currentMc:MovieClip;
      
      private var _info:com.taomee.seer2.app.shoot.ShootInfo;
      
      private var _isDisposed:Boolean;
      
      private var _actor:Actor;
      
      private var _timer:Timer;
      
      public function ShootHitEffect(param1:MovieClip, param2:MovieClip, param3:com.taomee.seer2.app.shoot.ShootInfo)
      {
         super();
         this._effectMc = param1;
         this._stateMc = param2;
         this._info = param3;
         this._isDisposed = false;
         this.process();
      }
      
      private function process() : void
      {
         this._actor = ActorManager.getActorByPos(this._info.endPos.x,this._info.endPos.y);
         if(this._actor)
         {
            this._actor.addShootEffect(this);
            if(this._info.stateType == 1)
            {
               this._actor.isShowNormal = false;
            }
            this._currentMc = this._stateMc;
         }
         else
         {
            this._effectMc.x = this._info.endPos.x;
            this._effectMc.y = this._info.endPos.y;
            SceneManager.active.mapModel.front.addChild(this._effectMc);
            this._currentMc = this._effectMc;
         }
         this._currentMc.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(this._info.lastTime > 0)
         {
            this._timer = new Timer(this._info.lastTime);
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.start();
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this._currentMc.currentFrame == this._currentMc.totalFrames)
         {
            if(this._info.lastTime > 0)
            {
               this._currentMc.gotoAndPlay("normal");
            }
            else
            {
               this.dispose();
            }
         }
      }
      
      private function onTimer(param1:Event) : void
      {
         this.dispose();
      }
      
      public function hide() : void
      {
         this._currentMc.visible = false;
      }
      
      public function get info() : com.taomee.seer2.app.shoot.ShootInfo
      {
         return this._info;
      }
      
      public function get stateMc() : MovieClip
      {
         return this._stateMc;
      }
      
      public function dispose() : void
      {
         if(!this._isDisposed)
         {
            this._isDisposed = true;
            if(this._info.stateType == 1 && Boolean(this._actor))
            {
               this._actor.isShowNormal = true;
            }
            if(this._actor)
            {
               this._actor.removeShootEffect(this);
               this._actor = null;
            }
            if(this._currentMc)
            {
               DisplayObjectUtil.removeFromParent(this._currentMc);
               this._currentMc.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               this._currentMc = null;
            }
            if(this._timer)
            {
               this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
               this._timer = null;
            }
         }
      }
   }
}
