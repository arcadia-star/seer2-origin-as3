package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_1310 extends TitleMapProcessor
   {
      
      private static const FRUITS_REWARD_1_A:String = "fruitsReward1A";
       
      
      private var _fruitsMC:MovieClip;
      
      private var _mushroomBig:MovieClip;
      
      private var _eye:MovieClip;
      
      public function MapProcessor_1310(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMushroom();
         this.initEye();
         this.initFruits();
      }
      
      private function initMushroom() : void
      {
         this._mushroomBig = _map.content["mushroomBig"];
         initInteractor(this._mushroomBig);
         this._mushroomBig.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._mushroomBig.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function initEye() : void
      {
         this._eye = _map.content["eye"];
         initInteractor(this._eye);
         this._eye.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._eye.addEventListener(MouseEvent.MOUSE_OVER,this.onEyeOver);
         this._eye.addEventListener(MouseEvent.MOUSE_OUT,this.onEyeOut);
      }
      
      private function initFruits() : void
      {
         this._fruitsMC = _map.content["fruits"];
         this._fruitsMC.addEventListener(FRUITS_REWARD_1_A,this.onFruitsReward);
      }
      
      private function onFruitsReward(param1:Event) : void
      {
         this._fruitsMC.removeEventListener(FRUITS_REWARD_1_A,this.onFruitsReward);
         if(SwapManager.isSwapNumberMax(17))
         {
            SwapManager.entrySwap(17);
         }
      }
      
      private function onEyeOut(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndPlay("Loop");
      }
      
      private function onEyeOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndPlay("Hit");
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         closeInteractor(_loc2_);
         if(_loc2_.currentFrameLabel == "HitEnd")
         {
            _loc2_.gotoAndPlay("Loop");
            initInteractor(_loc2_);
         }
         else
         {
            _loc2_.gotoAndPlay("Hit");
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrameLabel == "LoopEnd")
         {
            _loc2_.stop();
         }
         else if(_loc2_.currentFrameLabel == "HitEnd")
         {
            _loc2_.stop();
            initInteractor(_loc2_);
         }
      }
      
      private function clearEventListener() : void
      {
         this._mushroomBig.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._mushroomBig.removeEventListener(MouseEvent.CLICK,this.onClick);
         this._eye.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._eye.removeEventListener(MouseEvent.MOUSE_OVER,this.onEyeOver);
         this._eye.removeEventListener(MouseEvent.MOUSE_OUT,this.onEyeOut);
      }
      
      override public function dispose() : void
      {
         this.clearEventListener();
         this._mushroomBig = null;
         this._eye = null;
         if(this._fruitsMC)
         {
            this._fruitsMC.removeEventListener(FRUITS_REWARD_1_A,this.onFruitsReward);
            this._fruitsMC = null;
         }
         super.dispose();
      }
   }
}
