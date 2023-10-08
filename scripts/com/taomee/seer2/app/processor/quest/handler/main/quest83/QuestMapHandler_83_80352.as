package com.taomee.seer2.app.processor.quest.handler.main.quest83
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_83_80352 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_83_80352(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.GUDIE_ARENA4)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(_quest.id,2);
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,2))
         {
            this._npc = MobileManager.getMobile(111111,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入战斗试炼2");
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         var _loc2_:Object = new Object();
         _loc2_.index = 1;
         ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"),"",_loc2_);
         StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","完成战斗试炼2");
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         FightManager.startFightWithGudiePet(100000,null,null,null,1,2);
      }
   }
}
