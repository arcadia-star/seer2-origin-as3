package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class MapProcessor_80051 extends MapProcessor
   {
       
      
      private const FIGHT_ID:uint = 578;
      
      public function MapProcessor_80051(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
      }
      
      override public function init() : void
      {
         var currentDate:Date;
         var isA:Boolean;
         var isB:Boolean;
         StatisticsManager.sendNovice("0x10034072");
         currentDate = new Date(TimeManager.getPrecisionServerTime() * 1000);
         isA = currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 1 && currentDate.hours == 14 && currentDate.minutes < 31;
         isB = currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 3 && currentDate.hours == 14 && currentDate.minutes < 31;
         if(isA || isB)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
         }
         else
         {
            AlertManager.showAlert("活动时间已经结束了,去传送室看看其他活动吧!",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
      }
      
      protected function toFight(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "toFight")
         {
            FightManager.startFightWithWild(this.FIGHT_ID);
         }
      }
   }
}
