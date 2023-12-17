package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
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
   
   public class MapProcessor_80443 extends MapProcessor
   {
      
      private static const MAX_BLOOD:uint = 199999999;
       
      
      private const FIGHT_COUNT:uint = 958;
      
      private const BUY_COUNT:uint = 203669;
      
      private var leftCount:int;
      
      private var npc:Mobile;
      
      private var leftBlood:uint;
      
      public function MapProcessor_80443(param1:MapModel)
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
            AlertManager.showAlert("不在活动范围内，活动时间为19：00-20：30",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
            return;
         }
         DayLimitManager.getDoCount(this.FIGHT_COUNT,this.getDayData);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
         this.npc = MobileManager.getMobile(888,MobileType.NPC);
         this.npc.mouseChildren = this.npc.mouseEnabled = false;
      }
      
      private function getDayData(param1:uint) : void
      {
         if(param1 < 10)
         {
            this.leftCount = 10 - param1;
         }
         else
         {
            this.leftCount = 0;
         }
         ActiveCountManager.requestActiveCount(this.BUY_COUNT,this.getBuyCount);
      }
      
      private function getBuyCount(param1:uint, param2:uint) : void
      {
         this.leftCount += param2;
         this.npc.mouseEnabled = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
      }
      
      protected function toFight(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "yueSeKingToFight")
         {
            Connection.addCommandListener(CommandSet.GET_CURR_BLOOD_1231,this.getBossHp);
            Connection.send(CommandSet.GET_CURR_BLOOD_1231);
         }
         else if((param1.content as DialogPanelEventData).params == "yueSeKingSeeRank")
         {
            ModuleManager.showAppModule("YueSeKingBossActPanel");
         }
      }
      
      private function getBossHp(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_CURR_BLOOD_1231,this.getBossHp);
         this.leftBlood = param1.message.getRawData().readUnsignedInt();
         if(this.leftBlood == 0)
         {
            AlertManager.showAlert("世界boss已被战胜，不可以再打了哦!");
         }
         else
         {
            FightManager.startFightWithBoss(793);
         }
      }
      
      private function toConfirm() : void
      {
         var _loc1_:BuyPropInfo = new BuyPropInfo();
         _loc1_.buyComplete = this.buyComplete;
         _loc1_.itemId = 603441;
         ShopManager.buyVirtualItem(_loc1_);
      }
      
      private function buyComplete(param1:*) : void
      {
         FightManager.startFightWithBoss(793);
      }
   }
}
