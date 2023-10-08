package com.taomee.seer2.app.processor.quest.handler.main.quest86
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_86_80351 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_86_80351(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.getActor().blockNoNo = true;
         (SceneManager.active as LobbyScene).showToolbar();
         if(QuestManager.isCanAccepted(questID) && (QuestManager.isAccepted(83) || QuestManager.isComplete(83)))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.accept(questID);
         }
         else if(QuestManager.isAccepted(questID))
         {
            this.nextQuest1();
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         this.nextQuest1();
      }
      
      private function nextQuest1() : void
      {
         this._npc = this.getMC();
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
         StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入至尊试炼");
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function getMC() : MovieClip
      {
         var _loc1_:MovieClip = _map.content["npc"].actor;
         if(QuestManager.isCanAccepted(83) || QuestManager.isAccepted(83))
         {
            return _map.content["npc"];
         }
         _loc1_.gotoAndStop(4);
         return _map.content["npc"];
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         super.processMapDispose();
      }
   }
}
