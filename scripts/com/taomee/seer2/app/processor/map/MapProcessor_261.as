package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.gameRule.fish.FishRule_261;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_261 extends TitleMapProcessor
   {
       
      
      private var _gameBtn:SimpleButton;
      
      private var _fishRule:FishRule_261;
      
      public function MapProcessor_261(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initGame();
         this._fishRule = new FishRule_261();
         this._fishRule.init(_map);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_170);
      }
      
      private function initGame() : void
      {
         this._gameBtn = _map.content["gameBtn"];
         TooltipManager.addGameTip(this._gameBtn,"绚丽的火花");
         this._gameBtn.addEventListener(MouseEvent.CLICK,this.onGame);
      }
      
      private function onGame(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_261);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开" + "小游戏" + "...",{"gameId":7});
      }
      
      private function clearGame() : void
      {
         if(this._gameBtn)
         {
            this._gameBtn.removeEventListener(MouseEvent.CLICK,this.onGame);
            this._gameBtn = null;
         }
      }
      
      override public function dispose() : void
      {
         this.clearGame();
         this._fishRule.dispose();
         this._fishRule = null;
         super.dispose();
      }
   }
}
