package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewPlayerGetAwardWidgetClick extends Sprite implements IWidgetable
   {
      
      public static const NEW_PLAYER_GET_AWARD:String = "newPlayerGetAward";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:SimpleButton;
      
      private var _tip:MovieClip;
      
      private const SIGN_DAYS_FOR:uint = 203024;
      
      private const SIGN_DAY:int = 770;
      
      private const MAX_DAYS:int = 7;
      
      public function NewPlayerGetAwardWidgetClick(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         this.initSet();
      }
      
      private function initSet() : void
      {
         var time:uint;
         this._btn = this._mainUI["btn"];
         this._tip = this._mainUI["tip"];
         this._tip.mouseChildren = this._tip.mouseEnabled = this._tip.visible = false;
         time = new Date(2013,5,27).getTime() / 1000;
         if(ActorManager.actorInfo.createTime < time)
         {
            this._mainUI.visible = false;
            return;
         }
         ActiveCountManager.requestActiveCount(this.SIGN_DAYS_FOR,function(param1:int, param2:int):void
         {
            var type:int = param1;
            var val:int = param2;
            if(val == MAX_DAYS)
            {
               _mainUI.visible = false;
               return;
            }
            DayLimitManager.getDoCount(SIGN_DAY,function(param1:int):void
            {
               if(param1 == 0)
               {
                  _tip.visible = true;
               }
               else
               {
                  _tip.visible = false;
               }
               initEventListener();
            });
         });
      }
      
      private function initEventListener() : void
      {
         this._btn.addEventListener(MouseEvent.CLICK,this.onWidgetClick);
      }
      
      private function onWidgetClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("NewPlayerGetAwardPanel"),"正在打开新手连续登录领奖面板...");
      }
      
      public function hideHaveGiftTip() : void
      {
         this._tip.visible = false;
      }
   }
}
