package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_141 extends TitleMapProcessor
   {
      
      private static const LIGHT_FLOWER_RIGHT_REWARD_1:String = "lightFlowerRight1";
       
      
      private var _lightFlowerRightRewardMC:MovieClip;
      
      private var _gameTrigger:MovieClip;
      
      public function MapProcessor_141(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initFlower();
         this.initGame();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_128);
      }
      
      private function initFlower() : void
      {
         this._lightFlowerRightRewardMC = _map.content["lightFlowerRight"] as MovieClip;
         this._lightFlowerRightRewardMC.addEventListener(LIGHT_FLOWER_RIGHT_REWARD_1,this.onFlowerReward);
      }
      
      private function onFlowerReward(param1:Event) : void
      {
         this._lightFlowerRightRewardMC.removeEventListener(LIGHT_FLOWER_RIGHT_REWARD_1,this.onFlowerReward);
         if(SwapManager.isSwapNumberMax(19))
         {
            SwapManager.entrySwap(19);
         }
      }
      
      private function initGame() : void
      {
         this._gameTrigger = _map.content["lutosFlower"] as MovieClip;
         this._gameTrigger.gotoAndStop(1);
         initInteractor(this._gameTrigger);
         TooltipManager.addGameTip(this._gameTrigger,"飞檐走壁");
         this._gameTrigger.addEventListener(MouseEvent.CLICK,this.onGameStart);
         this._gameTrigger.addEventListener(MouseEvent.ROLL_OVER,this.onTriggerOver);
         this._gameTrigger.addEventListener(MouseEvent.ROLL_OUT,this.onTriggerOut);
      }
      
      private function onGameStart(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_252);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开" + "小游戏" + "...",{"gameId":5});
      }
      
      private function onTriggerOver(param1:MouseEvent) : void
      {
         this._gameTrigger.gotoAndPlay(2);
      }
      
      private function onTriggerOut(param1:MouseEvent) : void
      {
         this._gameTrigger.gotoAndStop(1);
      }
      
      override public function dispose() : void
      {
         if(this._lightFlowerRightRewardMC)
         {
            this._lightFlowerRightRewardMC.removeEventListener(LIGHT_FLOWER_RIGHT_REWARD_1,this.onFlowerReward);
            this._lightFlowerRightRewardMC = null;
         }
         if(this._gameTrigger)
         {
            this._gameTrigger.removeEventListener(MouseEvent.CLICK,this.onGameStart);
            this._gameTrigger.removeEventListener(MouseEvent.ROLL_OVER,this.onTriggerOver);
            this._gameTrigger.removeEventListener(MouseEvent.ROLL_OUT,this.onTriggerOut);
            TooltipManager.remove(this._gameTrigger);
            this._gameTrigger = null;
         }
         super.dispose();
      }
   }
}
