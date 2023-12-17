package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.controls.LeftTopToolBar;
   import com.taomee.seer2.app.init.LoginInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   
   public class SummerSignInManager
   {
      
      private static var getBtn:SimpleButton;
      
      private static var giftindex:int;
      
      private static var isFirst:Boolean = false;
       
      
      public function SummerSignInManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
      }
      
      private static function onMapSwitchComplete(param1:SceneEvent) : void
      {
         if(!isFirst)
         {
            loginShowHandler();
         }
         isFirst = true;
         if(Boolean(getBtn) && LeftTopToolBar.instance.contains(getBtn))
         {
            if(SceneManager.currentSceneType == SceneType.ARENA)
            {
               getBtn.visible = false;
            }
            else
            {
               getBtn.visible = true;
            }
         }
      }
      
      private static function loginShowHandler() : void
      {
         giftindex = LoginInfo.giftIndex;
         initBtn();
      }
      
      private static function initBtn() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("SummerSignInBtn"),LoadType.SWF,onResLoaded);
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         getBtn = (param1.content as MovieClip)["btn"];
         getBtn.addEventListener(MouseEvent.CLICK,showRewardPanel);
         TooltipManager.addCommonTip(getBtn,"暑假签到");
         LeftTopToolBar.instance.addChild(getBtn);
         LeftTopToolBar.show();
         getBtn.x = 150;
         getBtn.y = 110;
      }
      
      private static function showGetRewardBtn(param1:Event) : void
      {
         EventManager.removeEventListener("show_reward_btn",showGetRewardBtn);
         initBtn();
      }
      
      private static function showRewardPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("SummerSignInPanel"),"暑假签到");
      }
   }
}
