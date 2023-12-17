package com.taomee.seer2.app.processor.quest.handler.main.quest11.interactive
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class BadPeople
   {
       
      
      private var _bloodBar:BloodBar;
      
      private var _timer:Timer;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _type:int;
      
      private var _displayMC:MovieClip;
      
      private var _escapeMC:MovieClip;
      
      private var _greenBloodBar:BloodBar;
      
      private var _resLib:ResourceLibrary;
      
      public function BadPeople(param1:MovieClip, param2:BloodBar, param3:int, param4:int, param5:int, param6:BloodBar, param7:ResourceLibrary)
      {
         super();
         this._type = param5;
         this._x = param3;
         this._y = param4;
         this._bloodBar = param2;
         this._displayMC = param1;
         this._greenBloodBar = param6;
         this._resLib = param7;
         this._bloodBar.x = -128;
         this._bloodBar.y = -135;
         this._displayMC.addChild(this._bloodBar);
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.start();
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootOver);
         this._bloodBar.addEventListener(BloodBar.BLOOD_OVER,this.onBloodOver);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:Actor = ActorManager.getActor();
         if(this.isAvalible())
         {
            _loc3_ = new Point(_loc2_.pos.x,_loc2_.pos.y - 35);
            _loc4_ = new Point(this._displayMC.x + 221,this._displayMC.y + 313);
            ShootController.execute(0,_loc2_.id,_loc2_,_loc3_,_loc4_);
         }
      }
      
      private function isAvalible() : Boolean
      {
         var _loc1_:Point = ActorManager.getActor().pos;
         var _loc2_:int = _loc1_.x - this._x;
         var _loc3_:int = _loc1_.y - this._y;
         if(Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_) < 200)
         {
            return true;
         }
         return false;
      }
      
      private function onShootOver(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         if(this._displayMC.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            if(_loc2_.id == 1)
            {
               if(this._type == 2)
               {
                  this._bloodBar.updataBlood(10);
               }
            }
            else if(_loc2_.id == 2)
            {
               if(this._type == 1)
               {
                  this._bloodBar.updataBlood(10);
               }
               if(this._type == 2)
               {
                  this._bloodBar.updataBlood(2);
               }
            }
            else if(_loc2_.id == 3)
            {
               if(this._type == 1)
               {
                  this._bloodBar.updataBlood(2);
               }
            }
         }
         var _loc3_:Actor = ActorManager.getActor();
         if(_loc3_.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            this._greenBloodBar.updataBlood(2);
         }
      }
      
      private function onBloodOver(param1:Event) : void
      {
         var evt:Event = param1;
         this._escapeMC = this._resLib.getMovieClip("escape_" + this._type);
         this._escapeMC.x = this._displayMC.x;
         this._escapeMC.y = this._displayMC.y - 86;
         this._displayMC.parent.addChild(this._escapeMC);
         DisplayObjectUtil.removeFromParent(this._displayMC);
         MovieClipUtil.playMc(this._escapeMC,1,this._escapeMC.totalFrames,function():void
         {
            _escapeMC.stop();
            DisplayObjectUtil.removeFromParent(_escapeMC);
         });
      }
      
      public function dispose() : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootOver);
         DisplayObjectUtil.removeFromParent(this._escapeMC);
         DisplayObjectUtil.removeFromParent(this._displayMC);
         this._resLib = null;
      }
      
      public function get bloodBar() : BloodBar
      {
         return this._bloodBar;
      }
   }
}
