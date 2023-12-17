package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import org.taomee.utils.DisplayUtil;
   
   public class Interactive_10221 extends BaseAniamationInteractive
   {
       
      
      private var _starMC:MovieClip;
      
      private var _liftSun:MovieClip;
      
      private var _rightSun:MovieClip;
      
      private var _liftWall:MovieClip;
      
      private var _rightWall:MovieClip;
      
      private var _ground:MovieClip;
      
      private var _car:MovieClip;
      
      private var _door:MovieClip;
      
      private var _timer:Timer;
      
      private var _currSun:int;
      
      private var _currIndex:int;
      
      private var _currKey:String;
      
      private var _noNum:int;
      
      public function Interactive_10221()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         this._starMC = _animation["starMC"];
         this._liftSun = _animation["liftSun"];
         this._rightSun = _animation["rightSun"];
         this._liftWall = _animation["liftWall"];
         this._rightWall = _animation["rightWall"];
         this._ground = _animation["ground"];
         this._car = _animation["car"];
         this._door = _animation["door"];
         this._noNum = 0;
         this._currSun = 1;
         this._currIndex = 1;
         this._currKey = "left";
         this._timer = new Timer(1000,30);
         this._starMC.addEventListener(Event.ENTER_FRAME,this.onStar);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
      }
      
      private function onStar(param1:Event) : void
      {
         if(this._starMC.currentFrame == this._starMC.totalFrames)
         {
            this.removeStar();
            this.star();
         }
      }
      
      private function star() : void
      {
         LayerManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._timer.start();
         this.playMC();
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.LEFT)
         {
            if(this._currKey == "left")
            {
               return;
            }
            this._currKey = "left";
            this._car.x = 369;
            this._currIndex = 1;
         }
         if(param1.keyCode == Keyboard.RIGHT)
         {
            if(this._currKey == "right")
            {
               return;
            }
            this._currKey = "right";
            this._car.x = 509;
            this._currIndex = 2;
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         if(this._timer.currentCount != 0 && this._timer.currentCount % 3 == 0)
         {
            _loc2_ = int(Math.random() * 100);
            if(_loc2_ >= 50)
            {
               this._liftSun.addEventListener(Event.ENTER_FRAME,this.onSun);
               this._liftSun.gotoAndPlay(2);
               this._currSun = 1;
            }
            else
            {
               this._rightSun.addEventListener(Event.ENTER_FRAME,this.onSun);
               this._rightSun.gotoAndPlay(2);
               this._currSun = 2;
            }
         }
         if(this._timer.currentCount == 27)
         {
            this._door.gotoAndPlay(2);
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this._timer.stop();
         this.win();
      }
      
      private function win() : void
      {
         dispatchEvent(new Event(AnimationEvent.STONE));
         this.dispose();
      }
      
      private function onSun(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame >= 35 && _loc2_.currentFrame <= 45)
         {
            if(this._currIndex == this._currSun)
            {
               _loc2_.removeEventListener(Event.ENTER_FRAME,this.onSun);
               _loc2_.gotoAndStop(1);
               this._car.gotoAndPlay(13);
               ++this._noNum;
            }
            if(this._noNum >= 1)
            {
               this._timer.stop();
               this._car.gotoAndPlay(24);
               this._car.addEventListener(Event.ENTER_FRAME,this.onNoComplete);
            }
         }
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.onSun);
            _loc2_.gotoAndStop(1);
         }
      }
      
      private function onNoComplete(param1:Event) : void
      {
         if(this._car.currentFrame == this._car.totalFrames)
         {
            this._car.stop();
            this._timer.stop();
            this._car.removeEventListener(Event.ENTER_FRAME,this.onNoComplete);
            this.noComplete();
         }
      }
      
      private function noComplete() : void
      {
         this.dispose();
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function playMC() : void
      {
         this._liftWall.gotoAndPlay(2);
         this._rightWall.gotoAndPlay(2);
         this._ground.gotoAndPlay(2);
         this._car.gotoAndPlay(2);
      }
      
      private function stopMC() : void
      {
         this._liftSun.gotoAndStop(1);
         this._rightSun.gotoAndStop(1);
         this._liftWall.gotoAndStop(1);
         this._rightWall.gotoAndStop(1);
         this._ground.gotoAndStop(1);
         this._car.gotoAndStop(1);
      }
      
      private function clearEvent() : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         LayerManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._liftSun.removeEventListener(Event.ENTER_FRAME,this.onSun);
         this._rightSun.removeEventListener(Event.ENTER_FRAME,this.onSun);
         this._car.removeEventListener(Event.ENTER_FRAME,this.onNoComplete);
      }
      
      private function clearMC() : void
      {
         this._car.x = 269;
         this._starMC = null;
         this._liftSun = null;
         this._rightSun = null;
         this._liftWall = null;
         this._rightWall = null;
         this._ground = null;
         this._car = null;
         this._door = null;
         this._noNum = 0;
         this._currIndex = 1;
         this._currSun = 1;
         this._currKey = "left";
         this._timer = null;
      }
      
      private function removeStar() : void
      {
         if(this._starMC)
         {
            this._starMC.removeEventListener(Event.ENTER_FRAME,this.onStar);
            DisplayUtil.removeForParent(this._starMC);
            this._starMC = null;
         }
      }
      
      override public function dispose() : void
      {
         this.stopMC();
         this.clearEvent();
         this.clearMC();
         super.dispose();
      }
   }
}
