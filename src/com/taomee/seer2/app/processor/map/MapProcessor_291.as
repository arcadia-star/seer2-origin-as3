package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_291 extends TitleMapProcessor
   {
       
      
      private const DIAMONDREWARD291_1:String = "diamondReward291_1";
      
      private const DIAMONDREWARD291_3:String = "diamondReward291_3";
      
      private const DIAMONDREWARD291_4:String = "diamondReward291_4";
      
      private var diamond1MC:MovieClip;
      
      private var diamond3MC:MovieClip;
      
      private var diamond4MC:MovieClip;
      
      private var _gameBtn:SimpleButton;
      
      public function MapProcessor_291(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initFire();
         this.initGame();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_172);
      }
      
      private function initGame() : void
      {
         this._gameBtn = _map.content["gameBtn"] as SimpleButton;
         TooltipManager.addGameTip(this._gameBtn,"乔尼祖玛");
         this._gameBtn.addEventListener(MouseEvent.CLICK,this.onGameClick);
      }
      
      private function onGameClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_262);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开" + "小游戏" + "...",{"gameId":11});
      }
      
      private function initFire() : void
      {
         this.diamond1MC = _map.content["moveStone1"] as MovieClip;
         this.diamond3MC = _map.content["diamond1"] as MovieClip;
         this.diamond4MC = _map.content["diamond3"] as MovieClip;
         this.diamond1MC.addEventListener(this.DIAMONDREWARD291_1,this.onDiamondReward1);
         this.diamond3MC.addEventListener(this.DIAMONDREWARD291_3,this.onDiamondReward3);
         this.diamond4MC.addEventListener(this.DIAMONDREWARD291_4,this.onDiamondReward4);
      }
      
      private function onDiamondReward1(param1:Event) : void
      {
         this.diamond1MC.removeEventListener(this.DIAMONDREWARD291_1,this.onDiamondReward1);
         if(SwapManager.isSwapNumberMax(34))
         {
            SwapManager.entrySwap(34);
         }
      }
      
      private function onDiamondReward3(param1:Event) : void
      {
         this.diamond3MC.removeEventListener(this.DIAMONDREWARD291_3,this.onDiamondReward3);
         if(SwapManager.isSwapNumberMax(36))
         {
            SwapManager.entrySwap(36);
         }
      }
      
      private function onDiamondReward4(param1:Event) : void
      {
         this.diamond4MC.removeEventListener(this.DIAMONDREWARD291_4,this.onDiamondReward4);
         if(SwapManager.isSwapNumberMax(37))
         {
            SwapManager.entrySwap(37);
         }
      }
      
      override public function dispose() : void
      {
         if(this.diamond1MC)
         {
            this.diamond1MC.removeEventListener(this.DIAMONDREWARD291_1,this.onDiamondReward1);
            this.diamond1MC = null;
         }
         if(this.diamond3MC)
         {
            this.diamond3MC.removeEventListener(this.DIAMONDREWARD291_3,this.onDiamondReward3);
            this.diamond3MC = null;
         }
         if(this.diamond4MC)
         {
            this.diamond4MC.removeEventListener(this.DIAMONDREWARD291_4,this.onDiamondReward4);
            this.diamond4MC = null;
         }
         if(this._gameBtn)
         {
            TooltipManager.remove(this._gameBtn);
            this._gameBtn.removeEventListener(MouseEvent.CLICK,this.onGameClick);
            this._gameBtn = null;
         }
      }
   }
}
