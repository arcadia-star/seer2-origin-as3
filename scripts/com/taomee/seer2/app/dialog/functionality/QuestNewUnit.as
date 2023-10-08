package com.taomee.seer2.app.dialog.functionality
{
   import com.taomee.seer2.app.dialog.constant.FunctionalityPriority;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.events.MouseEvent;
   
   public class QuestNewUnit extends BaseUnit
   {
       
      
      private var _questId:int;
      
      private var _stepId:int;
      
      public function QuestNewUnit()
      {
         super();
      }
      
      override protected function addIcon() : void
      {
         _icon = UIManager.getSprite("UI_DialogQuest");
         addChild(_icon);
      }
      
      public function setData(param1:String, param2:int, param3:int) : void
      {
         this._stepId = param3;
         this._questId = param2;
         this.label = param1;
         this.type = FunctionalityType.QUEST;
         if(this._stepId == 0)
         {
            this.priority = FunctionalityPriority.QUEST_ACCEPTABLE;
         }
         else
         {
            this.priority = FunctionalityPriority.QUEST_IN_PROGRESS;
         }
      }
      
      override protected function onBtnClick(param1:MouseEvent) : void
      {
         dispatchEvent(new FunctionalityBoxEvent(FunctionalityBoxEvent.QUEST_NEW_CLICK,{
            "questId":this._questId,
            "stepId":this._stepId
         },true));
      }
   }
}
