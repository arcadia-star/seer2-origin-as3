package com.taomee.seer2.app.processor.quest.handler
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.events.MouseEvent;
   
   public class BranchQuestMapHandler extends QuestMapHandler
   {
       
      
      protected var _npc:Mobile;
      
      protected var _npcDefinition:NpcDefinition;
      
      protected var _questId:int;
      
      protected var _tip:String;
      
      public function BranchQuestMapHandler(param1:QuestProcessor)
      {
         super(param1);
         this._questId = _quest.id;
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
      
      override public function processMapDispose() : void
      {
         this.clearQuest();
      }
      
      protected function set tip(param1:String) : void
      {
         this._tip = param1;
      }
      
      public function initNpc(param1:XML) : void
      {
         this.createNpc(param1);
         this.initEventListener();
      }
      
      private function createNpc(param1:XML) : void
      {
         this._npcDefinition = new NpcDefinition(param1);
         this._npc = MobileManager.createNpc(this._npcDefinition);
         this._npc.buttonMode = true;
      }
      
      private function initEventListener() : void
      {
         this._npc.addEventListener(MouseEvent.CLICK,this.onQuestClick);
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onSepComplete);
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
      }
      
      protected function onQuestClick(param1:MouseEvent) : void
      {
         if(QuestManager.isCompletable(this._questId))
         {
            this.completeQuest();
         }
         DialogPanel.showForNpc(this._npcDefinition);
      }
      
      protected function onQuestAccept(param1:QuestEvent) : void
      {
         if(this._questId == param1.questId)
         {
            if(this._tip != "")
            {
               ServerMessager.addMessage(this._tip);
            }
         }
      }
      
      protected function onSepComplete(param1:QuestEvent) : void
      {
         if(this._questId == param1.questId && QuestManager.isCompletable(this._questId))
         {
            this.completeQuest();
         }
      }
      
      protected function onQuestComplete(param1:QuestEvent) : void
      {
         if(this._questId == param1.questId)
         {
            this.clearQuest();
         }
      }
      
      protected function completeQuest() : void
      {
      }
      
      protected function clearQuest() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onSepComplete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onQuestClick);
            this._npc.dispose();
         }
         this._npc = null;
         this._npcDefinition = null;
      }
   }
}
