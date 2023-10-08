package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.GadIssueAct;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_301 extends TitleMapProcessor
   {
       
      
      private var _lightVec:Vector.<MovieClip>;
      
      private var _gameBtn:SimpleButton;
      
      public function MapProcessor_301(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initLightVec();
         this.initGame();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_164);
         GadIssueAct.getInstance().setup();
      }
      
      private function initLightVec() : void
      {
         this._lightVec = new Vector.<MovieClip>();
         var _loc1_:MovieClip = _map.content["light1"];
         var _loc2_:MovieClip = _map.content["light2"];
         this._lightVec.push(_loc1_);
         this._lightVec.push(_loc2_);
         this.initLightInteracter();
      }
      
      private function initGame() : void
      {
         this._gameBtn = _map.content["gameBtn"];
         TooltipManager.addGameTip(this._gameBtn,"火箭小岩浮");
         this._gameBtn.addEventListener(MouseEvent.CLICK,this.onGame);
      }
      
      private function onGame(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_259);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开" + "小游戏" + "...",{"gameId":6});
      }
      
      private function initLightInteracter() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._lightVec.length)
         {
            initInteractor(this._lightVec[_loc1_]);
            this._lightVec[_loc1_].gotoAndStop(1);
            this._lightVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.onLightOver);
            this._lightVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.onLightOut);
            _loc1_++;
         }
         this._lightVec[1].addEventListener(MouseEvent.CLICK,this.onLightClick);
      }
      
      private function onLightOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      private function onLightOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      private function onLightClick(param1:MouseEvent) : void
      {
         this.reward();
      }
      
      private function reward() : void
      {
         if(SwapManager.isSwapNumberMax(38))
         {
            SwapManager.entrySwap(38);
         }
      }
      
      private function closeLightInteracter() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._lightVec.length)
         {
            this._lightVec[_loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.onLightOver);
            this._lightVec[_loc1_].removeEventListener(MouseEvent.MOUSE_OUT,this.onLightOut);
            this._lightVec[_loc1_] = null;
            _loc1_++;
         }
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
         this.closeLightInteracter();
         this.clearGame();
         this._lightVec = null;
         super.dispose();
      }
   }
}
