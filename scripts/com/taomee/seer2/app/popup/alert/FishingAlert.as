package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FishingAlert extends Sprite implements IAlert
   {
       
      
      private var _ui:MovieClip;
      
      private var _confirmBtn:SimpleButton;
      
      private var _cancelBtn:SimpleButton;
      
      private var _confirmHandler:Function;
      
      private var _cancelHandler:Function;
      
      private var _referenceId:uint;
      
      private var _iconDisplay:IconDisplayer;
      
      public function FishingAlert()
      {
         super();
         this.mouseEnabled = false;
         this._ui = UIManager.getMovieClip("UI_FishingFight");
         this._confirmBtn = this._ui["fightBtn"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmBtnClick);
         this._cancelBtn = this._ui["cancelBtn"];
         this._cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancelBtnClick);
         this._iconDisplay = new IconDisplayer();
         this._iconDisplay.setBoundary(90,90);
         this._iconDisplay.x = 135;
         this._iconDisplay.y = 21;
         this._ui.addChild(this._iconDisplay);
         addChild(this._ui);
      }
      
      private function onCancelBtnClick(param1:MouseEvent) : void
      {
         if(this._cancelHandler != null)
         {
            this._cancelHandler();
            this._cancelHandler = null;
         }
         this.dispose();
         param1.stopImmediatePropagation();
      }
      
      private function onConfirmBtnClick(param1:MouseEvent) : void
      {
         if(this._confirmHandler != null)
         {
            this._confirmHandler();
            this._confirmHandler = null;
         }
         this.dispose();
         param1.stopImmediatePropagation();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._referenceId = param1.initInfo.referenceId;
         this._confirmHandler = param1.initInfo.confirmHandler;
         this._cancelHandler = param1.initInfo.cancelHandler;
         var _loc2_:String = ItemConfig.getItemIconUrl(this._referenceId);
         var _loc3_:String = String(URLUtil.getPetIcon(this._referenceId));
         this._iconDisplay.setIconUrl(_loc3_);
         AlertManager.addPopUp(param1,this);
      }
      
      public function dispose() : void
      {
         this._confirmHandler = null;
         this._cancelHandler = null;
         this._ui = null;
         this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirmBtnClick);
         this._cancelBtn.removeEventListener(MouseEvent.CLICK,this.onCancelBtnClick);
         this._confirmBtn = null;
         this._cancelBtn = null;
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
