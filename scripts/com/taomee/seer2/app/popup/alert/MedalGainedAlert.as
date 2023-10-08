package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MedalGainedAlert extends Sprite implements IAlert
   {
       
      
      private var _container:MovieClip;
      
      private var _iconDisplay:IconDisplayer;
      
      private var _nameTxt:TextField;
      
      private var _confirmBtn:SimpleButton;
      
      private var _referenceId:uint;
      
      private var _closeHandler:Function;
      
      public function MedalGainedAlert()
      {
         super();
         this.initialize();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._referenceId = param1.initInfo.referenceId;
         this._closeHandler = param1.initInfo.closeHandler;
         this.displayMessage();
         AlertManager.addPopUp(param1,this);
      }
      
      public function dispose() : void
      {
         this._container = null;
         this._closeHandler = null;
         this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirmBtnClick);
         this._confirmBtn = null;
         this._iconDisplay = null;
         this._nameTxt = null;
         AlertManager.removePopUp(this,false);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function initialize() : void
      {
         this.mouseEnabled = false;
         this._container = UIManager.getMovieClip("UI_MedalGainedAlert");
         this._confirmBtn = this._container["confirm"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmBtnClick);
         this._nameTxt = this._container["medalName"];
         this._iconDisplay = new IconDisplayer();
         this._iconDisplay.x = 104;
         this._iconDisplay.y = 34;
         this._container.addChild(this._iconDisplay);
         this._container.addChild(this._nameTxt);
         addChild(this._container);
      }
      
      private function onConfirmBtnClick(param1:MouseEvent) : void
      {
         if(this._closeHandler != null)
         {
            this._closeHandler();
            this._closeHandler = null;
         }
         this.dispose();
         param1.stopImmediatePropagation();
      }
      
      private function displayMessage() : void
      {
         var _loc1_:String = ItemConfig.getItemIconUrl(this._referenceId);
         var _loc2_:String = ItemConfig.getItemName(this._referenceId);
         this._nameTxt.text = ItemConfig.getItemName(this._referenceId);
         this._iconDisplay.setIconUrl(_loc1_);
      }
   }
}
