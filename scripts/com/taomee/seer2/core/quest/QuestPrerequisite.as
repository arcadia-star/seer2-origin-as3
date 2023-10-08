package com.taomee.seer2.core.quest
{
   import com.taomee.seer2.core.quest.data.QuestPrerequisiteDefinition;
   
   public class QuestPrerequisite
   {
       
      
      private var _definition:QuestPrerequisiteDefinition;
      
      public function QuestPrerequisite(param1:QuestPrerequisiteDefinition)
      {
         super();
         this._definition = param1;
      }
      
      public function verifyPrerequisite() : Boolean
      {
         return true;
      }
   }
}
