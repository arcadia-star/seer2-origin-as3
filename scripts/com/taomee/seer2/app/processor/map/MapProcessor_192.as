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
   
   public class MapProcessor_192 extends TitleMapProcessor
   {
      
      private static const FLOWER_REWARD_2:String = "flowerReward2";
       
      
      private var flower:MovieClip;
      
      private var _gameMc:MovieClip;
      
      private var _bubbleStone:MovieClip;
      
      public function MapProcessor_192(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initBubbleStone();
         this.reward();
         this.initGame();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_140);
      }
      
      private function initGame() : void
      {
         this._gameMc = _map.content["gameMc"];
         this._gameMc.buttonMode = true;
         this._gameMc.addEventListener(MouseEvent.CLICK,this.onGame);
         TooltipManager.addGameTip(this._gameMc,"影子大战");
      }
      
      private function onGame(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开" + "小游戏" + "...",{"gameId":9});
      }
      
      private function initBubbleStone() : void
      {
         this._bubbleStone = _map.content["bubbleStone"] as MovieClip;
         this._bubbleStone.gotoAndStop(1);
         initInteractor(this._bubbleStone);
         this._bubbleStone.addEventListener(MouseEvent.CLICK,this.onStoneClick);
      }
      
      private function onStoneClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         closeInteractor(this._bubbleStone);
         this._bubbleStone.removeEventListener(MouseEvent.CLICK,this.onStoneClick);
         this._bubbleStone.gotoAndStop(2);
      }
      
      private function reward() : void
      {
         this.flower = _map.content["flower5"];
         this.flower.addEventListener(FLOWER_REWARD_2,this.onFlowerReward);
      }
      
      private function onFlowerReward(param1:Event) : void
      {
         this.flower.removeEventListener(FLOWER_REWARD_2,this.onFlowerReward);
         if(SwapManager.isSwapNumberMax(7))
         {
            SwapManager.entrySwap(7);
         }
      }
      
      override public function dispose() : void
      {
         if(this.flower)
         {
            this.flower.removeEventListener(FLOWER_REWARD_2,this.onFlowerReward);
         }
         this._bubbleStone = null;
         this.flower = null;
         if(this._gameMc)
         {
            TooltipManager.remove(this._gameMc);
            this._gameMc.removeEventListener(MouseEvent.CLICK,this.onGame);
         }
         super.dispose();
      }
   }
}
