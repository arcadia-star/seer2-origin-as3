package com.taomee.seer2.core.ui.toolTip.tipSkins
{
   import com.taomee.seer2.core.ui.UIManager;
   import flash.text.TextFieldAutoSize;
   
   public class MultipletipSkin extends BaseTipSkin
   {
       
      
      public function MultipletipSkin()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         _tipSkin = UIManager.getMovieClip("UI_multipleTooltip");
         _tipTxt = _tipSkin["tipTxt"];
         _tipTxt.width = 160;
         _tipTxt.wordWrap = true;
         _tipTxt.autoSize = TextFieldAutoSize.LEFT;
         _back = _tipSkin["backMC"];
         _tipSkin.x = 10;
         _tipSkin.y = 25;
         addChild(_tipSkin);
      }
      
      override public function show(param1:String) : void
      {
         super.show(param1);
         _back.width = _tipTxt.textWidth + 20;
         _back.height = _tipTxt.textHeight + 20;
      }
   }
}
