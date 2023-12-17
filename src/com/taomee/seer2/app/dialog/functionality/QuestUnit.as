package com.taomee.seer2.app.dialog.functionality
{
   import com.taomee.seer2.app.dialog.constant.FunctionalityPriority;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.events.MouseEvent;
   
   public class QuestUnit extends BaseUnit
   {
       
      
      private var _quest:Quest;
      
      private var _stepId:int;
      
      public function QuestUnit()
      {
         super();
      }
      
      override protected function addIcon() : void
      {
         _icon = UIManager.getSprite("UI_DialogQuest");
         addChild(_icon);
      }
      
      public function setData(param1:Quest, param2:int) : void
      {
         this._quest = param1;
         this._stepId = param2;
         this.createrQuestLabel();
         this.type = FunctionalityType.QUEST;
         if(this._quest.status == QuestStatus.ACCEPTABLE)
         {
            this.priority = FunctionalityPriority.QUEST_ACCEPTABLE;
         }
         else
         {
            this.priority = FunctionalityPriority.QUEST_IN_PROGRESS;
         }
      }
      
      private function createrQuestLabel() : void
      {
         var _loc1_:String = null;
         switch(this._quest.type)
         {
            case 0:
            case 1:
               _loc1_ = "(主线) ";
               break;
            case 2:
               _loc1_ = "(精灵) ";
               break;
            case 3:
               _loc1_ = "(NPC) ";
               break;
            case 4:
               _loc1_ = "(支线) ";
               break;
            case 5:
               _loc1_ = "(活动) ";
               break;
            default:
               _loc1_ = " ";
         }
         this.label = _loc1_ + this._quest.name;
      }
      
      override protected function onBtnClick(param1:MouseEvent) : void
      {
         dispatchEvent(new FunctionalityBoxEvent(FunctionalityBoxEvent.QUEST_CLICK,{
            "quest":this._quest,
            "stepId":this._stepId
         },true));
      }
      
      public function getQuest() : Quest
      {
         return this._quest;
      }
   }
}
