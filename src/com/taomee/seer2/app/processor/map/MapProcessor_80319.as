package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class MapProcessor_80319 extends MapProcessor
   {
      
      private static const FIGHT_INDEX:int = 793;
      
      private static const NPC_ID:int = 817;
       
      
      private var _npc:Mobile;
      
      public function MapProcessor_80319(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         var currentDate:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
         if(currentDate.hours == 18 && currentDate.minutes >= 58)
         {
            currentDate.hours = 19;
         }
         if(currentDate.hours < 19 || currentDate.hours > 20 || currentDate.hours == 20 && currentDate.minutes > 30)
         {
            AlertManager.showAlert("不在活动时间内!",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
            return;
         }
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
         this._npc = MobileManager.getMobile(NPC_ID,MobileType.NPC);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
      }
      
      protected function toFight(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "toFight")
         {
            Connection.addCommandListener(CommandSet.GET_CURR_BLOOD_1231,function getBossHp(param1:MessageEvent):void
            {
               Connection.removeCommandListener(CommandSet.GET_CURR_BLOOD_1231,getBossHp);
               var _loc2_:uint = uint(param1.message.getRawData().readUnsignedInt());
               if(_loc2_ > 0)
               {
                  FightManager.startFightWithBoss(FIGHT_INDEX);
               }
               else
               {
                  AlertManager.showAlert("世界boss的剩余血量没有了!");
               }
            });
            Connection.send(CommandSet.GET_CURR_BLOOD_1231);
         }
         else if((event.content as DialogPanelEventData).params == "seeRank")
         {
            ModuleManager.showAppModule("HeroWorldBossActPanel");
         }
      }
      
      private function buyComplete(param1:*) : void
      {
         FightManager.startFightWithBoss(FIGHT_INDEX);
      }
   }
}
