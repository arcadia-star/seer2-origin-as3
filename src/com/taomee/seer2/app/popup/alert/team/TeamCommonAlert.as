package com.taomee.seer2.app.popup.alert.team
{
   import com.taomee.seer2.app.component.TeamLogoDisplayer;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.alert.IAlert;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TeamCommonAlert extends Sprite implements IAlert
   {
       
      
      private var _mainUI:MovieClip;
      
      private var _confirmBtn:SimpleButton;
      
      private var _cancelBtn:SimpleButton;
      
      private var _logoDisplayer:TeamLogoDisplayer;
      
      private var _onConfirm:Function;
      
      private var _onCancel:Function;
      
      public function TeamCommonAlert()
      {
         super();
         this._mainUI = UIManager.getMovieClip("UI_TeamInviteNoticeViewUI");
         addChild(this._mainUI);
         this._confirmBtn = this._mainUI["confirmBtn"];
         this._cancelBtn = this._mainUI["cancelBtn"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmClick);
         this._cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancelClick);
         this._logoDisplayer = new TeamLogoDisplayer();
         this._logoDisplayer.x = 155;
         this._logoDisplayer.y = 41;
         this._mainUI.addChild(this._logoDisplayer);
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._mainUI["txt"].text = param1.initInfo.message;
         if(param1.initInfo.teamInfo.isCre == 1)
         {
            this._mainUI["creTxt"].visible = true;
         }
         else
         {
            this._mainUI["creTxt"].visible = false;
         }
         this._logoDisplayer.changeFront(param1.initInfo.teamInfo.logoFront);
         this._logoDisplayer.changeBack(param1.initInfo.teamInfo.logoBack);
         this._logoDisplayer.changeColor(param1.initInfo.teamInfo.logoColor);
         this._onConfirm = param1.initInfo.confirmHandler;
         this._onCancel = param1.initInfo.cancelHandler;
         AlertManager.addPopUp(param1,this);
      }
      
      public function dispose() : void
      {
         this._logoDisplayer.dispose();
         this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirmClick);
         this._cancelBtn.removeEventListener(MouseEvent.CLICK,this.onCancelClick);
         this._mainUI = null;
         this._confirmBtn = null;
         this._cancelBtn = null;
         this._logoDisplayer = null;
         this._onConfirm = null;
         this._onCancel = null;
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
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
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         if(this._onCancel != null)
         {
            this._onCancel();
            this._onCancel = null;
         }
         this.dispose();
      }
   }
}
