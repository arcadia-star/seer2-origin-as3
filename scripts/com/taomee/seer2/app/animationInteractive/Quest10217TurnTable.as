package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Quest10217TurnTable extends BaseAniamationInteractive
   {
       
      
      private var _shuMC:MovieClip;
      
      private var _hengMC:MovieClip;
      
      private var _keyCount:uint;
      
      private var _setTimeout:uint;
      
      public function Quest10217TurnTable()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         LayerManager.showMap();
         LayerManager.moduleLayer.addChild(_animation);
         this.init();
      }
      
      private function init() : void
      {
         this._keyCount = 0;
         this._shuMC = _animation["shuMC"];
         this._shuMC.gotoAndPlay(1);
         this._hengMC = _animation["hengMC"];
         this._hengMC.gotoAndStop(1);
         LayerManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onDown);
      }
      
      private function onDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            if(this._keyCount == 0)
            {
               this._shuMC.stop();
               this._hengMC.play();
               this._keyCount = 1;
            }
            else if(this._keyCount == 1)
            {
               this._hengMC.stop();
               this.checkWin();
            }
         }
      }
      
      private function checkWin() : void
      {
         if((this._shuMC.currentFrame >= 36 && this._shuMC.currentFrame < 39 || this._shuMC.currentFrame >= 61 && this._shuMC.currentFrame < 65) && (this._hengMC.currentFrame >= 25 && this._hengMC.currentFrame < 30 || this._hengMC.currentFrame >= 71 && this._hengMC.currentFrame < 77))
         {
            _isSuccess = true;
         }
         this._setTimeout = setTimeout(function():void
         {
            dispose();
         },1500);
      }
      
      override public function dispose() : void
      {
         clearTimeout(this._setTimeout);
         this._setTimeout = 0;
         LayerManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onDown);
         this._shuMC = null;
         this._hengMC = null;
         super.dispose();
      }
   }
}
