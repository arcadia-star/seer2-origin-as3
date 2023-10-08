package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class WaitLoadingBar
   {
      
      private static var _loadingPanel:MovieClip;
      
      {
         init();
      }
      
      public function WaitLoadingBar()
      {
         super();
      }
      
      private static function init() : void
      {
         _loadingPanel = new UI_WaitForServer();
         _loadingPanel.gotoAndStop(1);
      }
      
      public static function show(param1:DisplayObjectContainer, param2:int = 566, param3:int = 287) : void
      {
         _loadingPanel.x = param2;
         _loadingPanel.y = param3;
         _loadingPanel.gotoAndPlay(2);
         param1.addChild(_loadingPanel);
      }
      
      public static function hide() : void
      {
         DisplayObjectUtil.removeFromParent(_loadingPanel);
         _loadingPanel.gotoAndStop(1);
      }
   }
}
