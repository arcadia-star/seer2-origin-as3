package com.taomee.seer2.app.processor.quest.handler.main
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class QuestGame
   {
       
      
      protected var _mc:MovieClip;
      
      protected var _onHide:Function;
      
      protected var _closeBtn:SimpleButton;
      
      protected var _isSuccess:Boolean;
      
      public function QuestGame(param1:MovieClip, param2:Function)
      {
         super();
         this._mc = param1;
         this._mc.x += 120;
         this._mc.y += 50;
         var _loc3_:MovieClip = UIManager.getMovieClip("UI_PlayScreen");
         _loc3_.x -= 120;
         _loc3_.y -= 50;
         this._mc.addChild(_loc3_);
         this._onHide = param2;
         this.init();
      }
      
      public function init() : void
      {
         this._closeBtn = this._mc["close"];
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.onCloseBtnClick);
      }
      
      private function onCloseBtnClick(param1:MouseEvent) : void
      {
         this.hide();
      }
      
      public function show() : void
      {
         LayerManager.focusOnTopLayer();
         LayerManager.topLayer.addChild(this._mc);
      }
      
      public function hide() : void
      {
         DisplayObjectUtil.removeFromParent(this._mc);
         LayerManager.resetOperation();
         this._onHide(this._isSuccess);
      }
      
      public function dispose() : void
      {
         this._closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseBtnClick);
      }
   }
}
