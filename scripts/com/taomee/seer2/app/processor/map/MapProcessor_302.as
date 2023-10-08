package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct.GetMoneyRideHorseAct;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_302 extends TitleMapProcessor
   {
       
      
      private var _pipeVec:Vector.<MovieClip>;
      
      private var _getMoneyRideHorseAct:GetMoneyRideHorseAct;
      
      public function MapProcessor_302(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initPipeVec();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_165);
         this._getMoneyRideHorseAct = new GetMoneyRideHorseAct(_map);
      }
      
      private function initPipeVec() : void
      {
         this._pipeVec = new Vector.<MovieClip>();
         var _loc1_:MovieClip = _map.content["pipe1"];
         var _loc2_:MovieClip = _map.content["pipe2"];
         this._pipeVec.push(_loc1_);
         this._pipeVec.push(_loc2_);
         this.initPipeInteracter();
      }
      
      private function initPipeInteracter() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._pipeVec.length)
         {
            initInteractor(this._pipeVec[_loc1_]);
            this._pipeVec[_loc1_].gotoAndStop(1);
            this._pipeVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.onPipeOver);
            this._pipeVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.onPipeOut);
            _loc1_++;
         }
         this._pipeVec[0].addEventListener(MouseEvent.CLICK,this.onPipeClick);
      }
      
      private function onPipeOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      private function onPipeOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      private function onPipeClick(param1:MouseEvent) : void
      {
         this.reward();
      }
      
      private function reward() : void
      {
         if(SwapManager.isSwapNumberMax(39))
         {
            SwapManager.entrySwap(39);
         }
      }
      
      private function closePipeInteracter() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._pipeVec.length)
         {
            this._pipeVec[_loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.onPipeOver);
            this._pipeVec[_loc1_].removeEventListener(MouseEvent.MOUSE_OUT,this.onPipeOut);
            this._pipeVec[_loc1_] = null;
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         this.closePipeInteracter();
         this._pipeVec = null;
         if(this._getMoneyRideHorseAct)
         {
            this._getMoneyRideHorseAct.dispose();
            this._getMoneyRideHorseAct = null;
         }
         super.dispose();
      }
   }
}
