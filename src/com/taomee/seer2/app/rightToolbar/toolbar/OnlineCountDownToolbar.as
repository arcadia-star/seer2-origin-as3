package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   import flash.events.Event;
   import org.taomee.manager.EventManager;
   
   public class OnlineCountDownToolbar extends RightToolbar
   {
       
      
      public function OnlineCountDownToolbar()
      {
         super();
      }
      
      override public function init(param1:RightToolbarInfo) : void
      {
         super.init(param1);
         EventManager.addEventListener("SwapOnlineReward",this.onChangeCountDown);
         this.onChangeCountDown(null);
      }
      
      private function onChangeCountDown(param1:Event) : void
      {
         var evt:Event = param1;
         DayLimitManager.getDoCount(5583,function callBack(param1:uint):void
         {
            var _loc2_:int = param1 - TimeManager.getServerTime();
            if(_loc2_ > 0)
            {
               setShowTime(true,_loc2_);
               update();
            }
         });
      }
   }
}
