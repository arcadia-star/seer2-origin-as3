package com.taomee.seer2.app.arena.animation.core
{
   import flash.display.Sprite;
   
   public class BaseAnimation extends Sprite implements IArenaAnimation
   {
       
      
      private var _onComplete:Function;
      
      private var _completeParams:Object;
      
      public function BaseAnimation()
      {
         super();
      }
      
      public function initialize() : void
      {
      }
      
      public function initData(param1:Object) : void
      {
      }
      
      public function play() : void
      {
      }
      
      public function dispose() : void
      {
         this._onComplete = null;
         this._completeParams = null;
      }
      
      public function get onComplete() : Function
      {
         return this._onComplete;
      }
      
      public function set onComplete(param1:Function) : void
      {
         this._onComplete = param1;
      }
      
      public function get completeParams() : Object
      {
         return this._completeParams;
      }
      
      public function set completeParams(param1:Object) : void
      {
         this._completeParams = param1;
      }
   }
}
