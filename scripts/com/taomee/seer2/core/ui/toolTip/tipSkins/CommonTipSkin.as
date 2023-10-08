package com.taomee.seer2.core.ui.toolTip.tipSkins
{
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class CommonTipSkin extends BaseTipSkin
   {
       
      
      private var _isFlip:Boolean;
      
      private var _flipBackMc:MovieClip;
      
      public function CommonTipSkin()
      {
         super();
         this.initialize();
         this._isFlip = false;
      }
      
      private function initialize() : void
      {
         _tipSkin = UIManager.getMovieClip("UI_Tooltip");
         _back = _tipSkin["mcBack"] as MovieClip;
         this._flipBackMc = _tipSkin["flipBack"] as MovieClip;
         _tipTxt = _tipSkin["txtTip"] as TextField;
         _tipTxt.autoSize = TextFieldAutoSize.LEFT;
         _tipTxt.multiline = false;
         _tipSkin.x = -9;
         _tipSkin.y = -30;
         addChild(_tipSkin);
      }
      
      public function set isFlip(param1:Boolean) : void
      {
         if(this._isFlip != param1)
         {
            this._isFlip = param1;
            this.updateFlipBack();
         }
      }
      
      override public function show(param1:String) : void
      {
         if(param1 != "")
         {
            super.show(param1);
            this._flipBackMc.width = _back.width;
            this._flipBackMc.height = _back.height;
            this.updateFlipBack();
         }
      }
      
      private function updateFlipBack() : void
      {
         if(this._isFlip)
         {
            this._flipBackMc.visible = true;
            _back.visible = false;
         }
         else
         {
            this._flipBackMc.visible = false;
            _back.visible = true;
         }
      }
   }
}
