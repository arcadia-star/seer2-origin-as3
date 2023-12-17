package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.FightPrating;
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.PrizeGiving;
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.WalkRedCarpet;
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.WalkRedCarpetAgain;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_980 extends TitleMapProcessor
   {
      
      public static const DATE:Date = new Date(2013,5,15,14);
      
      public static const SECONDS_HALF_HOUR:Number = 60 * 60;
      
      public static const MILI_SECONDS:Number = 1000;
      
      public static const MIKA_FIGHT_INDEX:int = 147;
      
      public static const FIGHTED:int = 15;
       
      
      private var _littleCar:MovieClip;
      
      private var _bigCar:MovieClip;
      
      private var _pet:MovieClip;
      
      private var _tai:MovieClip;
      
      private var _tan:MovieClip;
      
      private var _walkHrader:WalkRedCarpet;
      
      private var _fightHrader:FightPrating;
      
      private var _prizeHrader:PrizeGiving;
      
      private var _walkAgianHrader:WalkRedCarpetAgain;
      
      private var _isFighted:int = 0;
      
      public function MapProcessor_980(param1:MapModel)
      {
         super(param1);
      }
      
      public static function isAppearTime() : Boolean
      {
         var _loc1_:Number = Number(TimeManager.getServerTime());
         var _loc2_:Number = DATE.getTime() / MILI_SECONDS;
         var _loc3_:Number = _loc2_ + SECONDS_HALF_HOUR;
         if(_loc1_ >= _loc2_ && _loc1_ < _loc3_)
         {
            return true;
         }
         return false;
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_81);
         this.checkFightHandler();
         GrabXiaoYueSeAct.getInstance().setup(this._map);
      }
      
      private function checkFightHandler() : void
      {
         var _loc1_:int = int(FightManager.currentFightRecord.initData.positionIndex);
         if(_loc1_ == MIKA_FIGHT_INDEX)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.TORCH_RELAY5,FIGHTED,1);
            }
         }
      }
      
      private function OnLittleCarHandler(param1:MouseEvent) : void
      {
         AlertManager.showAlert("当前活动已结束！");
      }
      
      private function OnBigCarHandler(param1:MouseEvent) : void
      {
         AlertManager.showAlert("当前活动已结束！");
      }
      
      private function OnPetHandler(param1:MouseEvent) : void
      {
         this.initFight();
      }
      
      private function OnPrizeGivingHandler(param1:MouseEvent) : void
      {
         this._prizeHrader = new PrizeGiving();
      }
      
      private function OnWalkHandler(param1:MouseEvent) : void
      {
         this._walkAgianHrader = new WalkRedCarpetAgain();
      }
      
      private function initFight() : void
      {
         this._fightHrader = new FightPrating();
      }
      
      private function initwalk() : void
      {
         this._walkHrader = new WalkRedCarpet();
      }
      
      override public function dispose() : void
      {
         if(this._walkHrader)
         {
            this._walkHrader.dispose();
         }
         if(!this._fightHrader)
         {
         }
         if(this._walkAgianHrader)
         {
            this._walkAgianHrader.dispose();
         }
         if(this._bigCar)
         {
            this._bigCar.removeEventListener(MouseEvent.CLICK,this.OnBigCarHandler);
            this._bigCar = null;
         }
         if(this._pet)
         {
            this._pet.removeEventListener(MouseEvent.CLICK,this.OnPetHandler);
            this._pet = null;
         }
         GrabXiaoYueSeAct.getInstance().dispose();
         super.dispose();
      }
   }
}
