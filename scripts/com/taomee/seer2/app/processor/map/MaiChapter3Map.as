package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MaiChapter3Map extends TitleMapProcessor
   {
       
      
      private var npc:Mobile;
      
      protected var npcId:int;
      
      private var activeType:int = 202139;
      
      protected var currentCount:int;
      
      protected var fightId:int = 123;
      
      protected var maxCount:int = 0;
      
      private var _reBloodBtn:SimpleButton;
      
      public function MaiChapter3Map(param1:MapModel)
      {
         super(param1);
      }
      
      private static function exitHandler(param1:* = null) : void
      {
         var e:* = param1;
         AlertManager.showConfirm("离开地图将结束挑战，你确定要离开吗？",function():void
         {
            leaveMap();
         });
      }
      
      public static function leaveMap() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
         if(SceneManager.active.mapModel.content["exitBtn"])
         {
            SceneManager.active.mapModel.content["exitBtn"].removeEventListener(MouseEvent.CLICK,exitHandler);
         }
         TweenNano.delayedCall(1,function():void
         {
            ModuleManager.showAppModule("FeiyiteSuperPanel");
         });
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function init() : void
      {
         this.initNpc();
         ActiveCountManager.requestActiveCount(this.activeType,this.getCount);
      }
      
      private function initNpc() : void
      {
         this.npc = MobileManager.getMobile(this.npcId,MobileType.NPC);
         this.npc.mouseChildren = false;
         this.npc.buttonMode = true;
         if(this.npc != null)
         {
            this.npc.addEventListener(MouseEvent.CLICK,this.toFight);
         }
      }
      
      private function getCount(param1:int, param2:int) : void
      {
         var type:int = param1;
         var times:int = param2;
         if(this.activeType == type)
         {
            this.currentCount = times;
            if(this.currentCount == 7)
            {
               AlertManager.showAlert("你已经收集满7个光源石。可以去找洛水了。",function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
                  QuestManager.completeStep(10170,4);
               });
               return;
            }
            if(this.currentCount > this.maxCount)
            {
               AlertManager.showAlert("你已经在他这儿成功获取了1个光源石。打开约瑟日志去找其他的吧!",function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("BagginsLogPanel"),"",{});
               });
            }
         }
      }
      
      private function onCompleteStep(param1:QuestEvent) : void
      {
         if(param1.questId == 10170)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
            SceneManager.changeScene(SceneType.LOBBY,160);
         }
      }
      
      protected function toFight(param1:MouseEvent) : void
      {
         var _loc2_:ButtonPanelData = null;
         if(this.currentCount == this.maxCount)
         {
            _loc2_ = new ButtonPanelData();
            _loc2_.catchEnabled = false;
            FightManager.startFightWithWild(this.fightId,null,null,_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this.npc)
         {
            this.npc.removeEventListener(MouseEvent.CLICK,this.toFight);
         }
      }
   }
}
