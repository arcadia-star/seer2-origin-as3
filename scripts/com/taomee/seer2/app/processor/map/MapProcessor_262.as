package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.rarePet.RarePetManager;
   import com.taomee.seer2.app.rarePet.config.RarePetConfig;
   import com.taomee.seer2.app.rarePet.event.RarePetEvent;
   import com.taomee.seer2.app.rarePet.info.RarePetInfo;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class MapProcessor_262 extends TitleMapProcessor
   {
       
      
      private const RAREPET_ID:int = 75;
      
      private var _info:RarePetInfo;
      
      private var _rarePetMC:MovieClip;
      
      private var _timer:Timer;
      
      private var _isShow:Boolean;
      
      private var stoneGame:MovieClip;
      
      private var _m5MC:MovieClip;
      
      public function MapProcessor_262(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initRarePet();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_171);
      }
      
      private function initRarePet() : void
      {
         var _loc1_:uint = 0;
         this._rarePetMC = _map.content["handWave"];
         this.stoneGame = _map.content["stoneGame"];
         this.stoneGame.buttonMode = true;
         this.hideRarePet();
         this._info = RarePetConfig.getRarePetInfo(this.RAREPET_ID);
         RarePetManager.addEventListener(RarePetEvent.START_TIME_UP,this.onRarePetShow);
         if(RarePetManager.isInTimeRange(this._info) != 0)
         {
            _loc1_ = TimeManager.getServerTime() - RarePetManager.getCookTime(this.RAREPET_ID);
            if(_loc1_ >= this._info.intervalTime * 60)
            {
               this.showRarePet();
            }
            else
            {
               this.addTimer((this._info.intervalTime * 60 - _loc1_) * 1000);
            }
         }
         this.stoneGame.addEventListener(MouseEvent.CLICK,this.toClickStone);
      }
      
      private function onM5(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("M5TwoSelectPetPanel"));
      }
      
      protected function toClickStone(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("AidehuaExercisePanel"));
      }
      
      private function addTimer(param1:uint) : void
      {
         this._timer = new Timer(param1);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.start();
      }
      
      private function removeTimer() : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer = null;
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         this.removeTimer();
         if(RarePetManager.isInTimeRange(this._info) != 0)
         {
            this.showRarePet();
         }
      }
      
      private function onRarePetShow(param1:RarePetEvent) : void
      {
         if(param1.rarePetId == this.RAREPET_ID)
         {
            this.showRarePet();
         }
      }
      
      private function showRarePet() : void
      {
         if(this._isShow == false)
         {
            this._isShow = true;
            this._rarePetMC.gotoAndStop(1);
            this._rarePetMC.buttonMode = true;
            this._rarePetMC.visible = true;
            this._rarePetMC.addEventListener(MouseEvent.CLICK,this.onRarePetClick);
         }
      }
      
      private function hideRarePet() : void
      {
         this._isShow = false;
         this._rarePetMC.visible = false;
         this._rarePetMC.removeEventListener(MouseEvent.CLICK,this.onRarePetClick);
      }
      
      private function onRarePetClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._rarePetMC.currentFrame < 3)
         {
            this._rarePetMC.gotoAndStop(this._rarePetMC.currentFrame + 1);
         }
         else if(this._rarePetMC.currentFrame == 4 || this._rarePetMC.currentFrame == 5)
         {
            NpcDialog.show(11,"多罗",[[2,"这种罕见的小精灵速度极快，除非在它攻击之前用头部射击击中它……不然我们就成焦炭了！！"]],["用头部射击抵挡","走为上策"],[function():void
            {
               shootSeer();
            }]);
         }
         else if(this._rarePetMC.currentFrame == 6)
         {
            RarePetManager.startFight(this.RAREPET_ID);
            RarePetManager.addCookTime(this.RAREPET_ID,TimeManager.getServerTime());
            this.hideRarePet();
         }
      }
      
      private function shootSeer() : void
      {
         this._rarePetMC.gotoAndStop(5);
         this._rarePetMC.addEventListener("end",this.buildEnd);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootEnd);
      }
      
      private function buildEnd(param1:Event) : void
      {
         this._rarePetMC.gotoAndStop(4);
         this._rarePetMC.removeEventListener("end",this.buildEnd);
         var _loc2_:Actor = ActorManager.getActor();
         var _loc3_:Point = new Point(646,230);
         ShootController.execute(3,_loc2_.id,_loc2_,_loc2_.pos,_loc3_);
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var info:ShootInfo;
         var evt:ShootEvent = param1;
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         info = evt.info;
         if(this._rarePetMC.hitTestPoint(info.endPos.x,info.endPos.y))
         {
            this._rarePetMC.gotoAndStop(6);
         }
         else
         {
            NpcDialog.show(10,"巴蒂",[[4,"我发现了！它每次攻击前都会聚集环境中的火焰，争取这段时间准备头部射击！"]],["继续挑战","走为上策"],[function():void
            {
               shootSeer();
            }]);
         }
      }
      
      override public function dispose() : void
      {
         RarePetManager.removeEventListener(RarePetEvent.START_TIME_UP,this.onRarePetShow);
         this.removeTimer();
         this.hideRarePet();
         this._rarePetMC.removeEventListener("end",this.buildEnd);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         super.dispose();
      }
   }
}
