package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertInitInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ItemMaxAlert extends Sprite implements IAlert
   {
       
      
      private var _ui:MovieClip;
      
      private var _confirmBtn:SimpleButton;
      
      private var _iconDisplay:IconDisplayer;
      
      private var _contentTxt:TextField;
      
      private var _msgTxt:TextField;
      
      private var _nameTxt:TextField;
      
      private var _info:AlertInitInfo;
      
      public function ItemMaxAlert()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.mouseEnabled = false;
         this._ui = UIManager.getMovieClip("UI_ItemMaxAlert");
         this._confirmBtn = this._ui["confirmBtn"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmBtnClick);
         this._contentTxt = this._ui["contentTxt"];
         this._msgTxt = this._ui["msgTxt"];
         this._nameTxt = this._ui["nameTxt"];
         this._iconDisplay = new IconDisplayer();
         this._iconDisplay.setBoundary(60,60);
         this._iconDisplay.x = 180;
         this._iconDisplay.y = 36;
         this._ui.addChild(this._iconDisplay);
         addChild(this._ui);
      }
      
      private function onConfirmBtnClick(param1:MouseEvent) : void
      {
         if(this._info.closeHandler != null)
         {
            this._info.closeHandler();
            this._info.closeHandler = null;
         }
         this.dispose();
         param1.stopImmediatePropagation();
      }
      
      private function displayMessage() : void
      {
         var _loc1_:String = ItemConfig.getItemIconUrl(this._info.referenceId);
         var _loc2_:String = ItemConfig.getItemName(this._info.referenceId);
         this._iconDisplay.setIconUrl(_loc1_);
         if(this._info.message == "")
         {
            this._msgTxt.text = "";
            this._contentTxt.htmlText = "数量已经达到上限,请及时整理背包。";
            this._nameTxt.text = _loc2_;
         }
         else
         {
            this._msgTxt.text = this._info.message;
            this._contentTxt.text = "";
            this._nameTxt.text = "";
         }
      }
      
      public function show(param1:AlertInfo) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         this._info = param1.initInfo;
         this.displayMessage();
         if(param1.centralize == true)
         {
            _loc2_ = LayerManager.root.width - this.width >> 1;
            _loc3_ = LayerManager.root.height - this.height >> 1;
            this.x = _loc2_;
            this.y = _loc3_;
         }
         LayerManager.topLayer.addChild(this);
      }
      
      public function dispose() : void
      {
         this._iconDisplay = null;
         this._info = null;
         this._ui = null;
         this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirmBtnClick);
         this._confirmBtn = null;
         AlertManager.removePopUp(this,false);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
