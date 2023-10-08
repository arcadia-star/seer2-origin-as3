package com.taomee.seer2.core.ui.toolTip.tipSkins
{
   import com.taomee.seer2.core.ui.UIManager;
   
   public class GameTipSkin extends BaseTipSkin
   {
       
      
      public function GameTipSkin()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         _tipSkin = UIManager.getMovieClip("UI_GameTooltip");
         _tipTxt = _tipSkin["gameTxt"];
         _back = _tipSkin["mcBack"];
         _tipSkin.x = 0;
         _tipSkin.y = -20;
         addChild(_tipSkin);
      }
   }
}
