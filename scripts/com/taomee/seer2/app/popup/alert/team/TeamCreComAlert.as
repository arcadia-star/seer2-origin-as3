package com.taomee.seer2.app.popup.alert.team
{
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.alert.IAlert;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TeamCreComAlert extends Sprite implements IAlert
   {
       
      
      private var _mainUI:MovieClip;
      
      private var _confirmBtn:SimpleButton;
      
      private var _onConfirm:Function;
      
      private var _txt:TextField;
      
      public function TeamCreComAlert()
      {
         super();
         this._mainUI = UIManager.getMovieClip("UI_TeamCreComUI");
         addChild(this._mainUI);
         this._confirmBtn = this._mainUI["confirmBtn"];
         this._txt = this._mainUI["txt"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmClick);
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._onConfirm = param1.initInfo.confirmHandler;
         this._txt.text = param1.initInfo.message;
         AlertManager.addPopUp(param1,this);
      }
      
      private function onConfirmClick(param1:MouseEvent) : void
      {
         if(this._onConfirm != null)
         {
            this._onConfirm();
            this._onConfirm = null;
         }
         this.dispose();
      }
      
      public function dispose() : void
      {
         this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirmClick);
         this._mainUI = null;
         this._confirmBtn = null;
         this._onConfirm = null;
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
