package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_330 extends TitleMapProcessor
   {
       
      
      private var _adBoard:MovieClip;
      
      private var _adBoardClick:MovieClip;
      
      private var _npc:Mobile;
      
      public function MapProcessor_330(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initAdBorad();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_160);
      }
      
      private function initAdBorad() : void
      {
         this._adBoard = _map.content["adBoard"];
         this._adBoard.gotoAndStop(1);
         this._adBoardClick = _map.content["swapBtn"];
         this._adBoardClick.buttonMode = true;
         DisplayObjectUtil.enableSprite(this._adBoardClick);
         this._adBoardClick.addEventListener(MouseEvent.CLICK,this.onAdBoardClick);
      }
      
      private function onAdBoardClick(param1:MouseEvent) : void
      {
         DisplayObjectUtil.disableSprite(this._adBoardClick);
         this._adBoard.addEventListener(Event.ENTER_FRAME,this.onAdBoardEnd);
         this._adBoard.gotoAndStop(2);
         if(SwapManager.isSwapNumberMax(86))
         {
            SwapManager.entrySwap(86);
         }
      }
      
      private function onAdBoardEnd(param1:Event) : void
      {
         if(this._adBoard.currentFrame == this._adBoard.totalFrames)
         {
            this._adBoard.removeEventListener(Event.ENTER_FRAME,this.onAdBoardEnd);
            DisplayObjectUtil.enableSprite(this._adBoardClick);
         }
      }
      
      override public function dispose() : void
      {
         this._adBoardClick.removeEventListener(MouseEvent.CLICK,this.onAdBoardClick);
         this._adBoard.removeEventListener(Event.ENTER_FRAME,this.onAdBoardEnd);
         this._adBoard = null;
         this._adBoardClick = null;
         super.dispose();
      }
   }
}
