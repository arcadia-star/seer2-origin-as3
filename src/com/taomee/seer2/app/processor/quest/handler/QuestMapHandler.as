package com.taomee.seer2.app.processor.quest.handler
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.quest.Quest;
   
   public class QuestMapHandler
   {
       
      
      protected var _processor:QuestProcessor;
      
      protected var _quest:Quest;
      
      protected var _map:MapModel;
      
      public function QuestMapHandler(param1:QuestProcessor)
      {
         super();
         this._processor = param1;
         this._quest = param1.quest;
      }
      
      public function processMapComplete() : void
      {
         this._map = this._processor.mapModel;
      }
      
      public function processMapDispose() : void
      {
         this._map = null;
      }
      
      public function dispose() : void
      {
         this._processor = null;
         this._quest = null;
      }
      
      protected function get questID() : int
      {
         return this._quest.id;
      }
      
      protected function isStepComplete(param1:int) : Boolean
      {
         return QuestManager.isStepComplete(this.questID,param1);
      }
      
      protected function isAccepted() : Boolean
      {
         return QuestManager.isAccepted(this.questID);
      }
      
      protected function isNeedToAccept() : Boolean
      {
         if(QuestManager.isCanAccepted(this.questID) && !QuestManager.isAccepted(this.questID))
         {
            return true;
         }
         return false;
      }
      
      protected function isNeedCompleteStep(param1:int) : Boolean
      {
         if(param1 == 1)
         {
            if(QuestManager.isAccepted(this.questID) && !this.isStepComplete(param1))
            {
               return true;
            }
         }
         else if(param1 > 1)
         {
            if(this.isStepComplete(param1 - 1) && !this.isStepComplete(param1))
            {
               return true;
            }
         }
         return false;
      }
   }
}
