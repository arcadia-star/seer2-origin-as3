package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.module.ModuleManager;
   import flash.events.MouseEvent;
   
   public class ShakeMoneyToolBar extends RightToolbar
   {
       
      
      public function ShakeMoneyToolBar()
      {
         super();
      }
      
      override public function init(param1:RightToolbarInfo) : void
      {
         super.init(param1);
         setShowTime(false,0);
         setShowTimeComplete(true);
         update();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         _isShowTimeComplete = false;
         removeTimeComplete();
         ModuleManager.showAppModule("ShakeMoneyTreePanel");
         SoundEffects.playSoundMouseClick();
      }
   }
}
