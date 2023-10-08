package com.taomee.seer2.core.ui.toolTip.tipSkins
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getDefinitionByName;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.StringUtil;
   
   public class IconTipSkin extends BaseTipSkin
   {
       
      
      private var _nameTxt:TextField;
      
      private var _id:uint;
      
      private var _isPet:Boolean;
      
      private var _icon;
      
      public function IconTipSkin(param1:uint, param2:Boolean)
      {
         super();
         this._id = param1;
         this._isPet = param2;
         this.initialize();
      }
      
      private function initialize() : void
      {
         _tipSkin = UIManager.getMovieClip("UI_IconTooltip");
         this._nameTxt = _tipSkin["nameTxt"] as TextField;
         _tipTxt = _tipSkin["contentTxt"] as TextField;
         _tipTxt.autoSize = TextFieldAutoSize.LEFT;
         _tipTxt.wordWrap = true;
         _back = _tipSkin["bg"];
         _tipSkin.x = 0;
         _tipSkin.y = -30;
         addChild(_tipSkin);
      }
      
      override public function show(param1:String) : void
      {
         var _loc5_:int = 0;
         _tipTxt.htmlText = StringUtil.replace(param1,"\\n","<br>");
         var _loc2_:* = getDefinitionByName("com.taomee.seer2.app.component.IconDisplayer");
         var _loc3_:* = getDefinitionByName("com.taomee.seer2.app.config.ItemConfig");
         var _loc4_:* = getDefinitionByName("com.taomee.seer2.app.config.PetConfig");
         this._icon = new _loc2_();
         if(this._isPet)
         {
            this._nameTxt.text = _loc4_.getPetDefinition(this._id).name;
            this._icon.setIconUrl(URLUtil.getPetIcon(this._id),this.completeFun);
            this._icon.x = 14;
            this._icon.y = (_back.height - this._icon.height) / 2;
         }
         else if(this._id < 1000 && this._id != 1)
         {
            if(_loc3_.getSuitDefinition(this._id))
            {
               this._nameTxt.text = _loc3_.getSuitDefinition(this._id).name;
            }
            this._icon.setIconUrl(_loc3_.getMeeItemIconUrl(this._id));
            this._icon.x = 3;
            this._icon.y = 3;
         }
         else
         {
            this._nameTxt.text = _loc3_.getItemName(this._id);
            this._icon.setIconUrl(_loc3_.getItemIconUrl(this._id));
            this._icon.x = 3;
            this._icon.y = 3;
         }
         if(this._nameTxt.x + this._nameTxt.textWidth > _tipTxt.x + _tipTxt.textWidth)
         {
            _loc5_ = this._nameTxt.x + this._nameTxt.textWidth;
         }
         else
         {
            _loc5_ = _tipTxt.x + _tipTxt.textWidth;
         }
         if(_back)
         {
            _back.width = _loc5_ + 22;
            _back.height = _tipTxt.y + _tipTxt.textHeight + 24;
         }
         this._icon.scaleX = 1.2;
         this._icon.scaleY = 1.2;
         _tipSkin.addChild(this._icon);
         LayerManager.topLayer.addChild(this);
      }
      
      private function completeFun() : void
      {
         this._icon.x = 14;
         this._icon.y = (_back.height - this._icon.height) / 2;
      }
      
      override public function hide() : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         if(this._icon)
         {
            this._icon.dispose();
         }
         DisplayUtil.removeForParent(this._icon);
      }
      
      override public function setData(param1:Object) : void
      {
      }
   }
}
