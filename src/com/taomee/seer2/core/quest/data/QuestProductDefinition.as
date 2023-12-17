package com.taomee.seer2.core.quest.data
{
   public class QuestProductDefinition
   {
       
      
      public var referenceIdVec:Vector.<int>;
      
      public var quantityVec:Vector.<int>;
      
      public var isPetVec:Vector.<Boolean>;
      
      public function QuestProductDefinition(param1:Array, param2:Array, param3:Array)
      {
         super();
         this.referenceIdVec = Vector.<int>(param1);
         this.quantityVec = Vector.<int>(param2);
         this.isPetVec = Vector.<Boolean>(param3);
      }
   }
}
