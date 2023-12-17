package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FakeDogzAlert extends Sprite implements IAlert
   {
       
      
      private var _closeBtn:SimpleButton;
      
      private var _closeFunction:Function;
      
      public function FakeDogzAlert()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         var _loc1_:MovieClip = UIManager.getMovieClip("UI_FakeDogz");
         addChild(_loc1_);
         this._closeBtn = _loc1_["closeBtn"];
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._closeFunction != null)
         {
            this._closeFunction();
         }
         AlertManager.removePopUp(this,false);
         this.dispose();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._closeFunction = param1.initInfo.closeHandler;
         AlertManager.addPopUp(param1,this);
      }
      
      public function dispose() : void
      {
         if(this._closeBtn)
         {
            this._closeBtn.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         this._closeBtn = null;
         this._closeFunction = null;
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
