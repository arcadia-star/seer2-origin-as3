package com.taomee.seer2.core.ui.toolTip.tipSkins
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   
   public class ExternalTipSkin extends BaseTipSkin
   {
       
      
      public function ExternalTipSkin(param1:MovieClip)
      {
         super();
         _tipSkin = param1;
         _tipSkin.x = 10;
         _tipSkin.y = 25;
         addChild(_tipSkin);
      }
      
      override public function show(param1:String) : void
      {
         LayerManager.topLayer.addChild(this);
      }
   }
}
