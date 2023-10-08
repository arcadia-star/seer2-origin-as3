package com.taomee.seer2.core.quest.data
{
   public class QuestDefinition
   {
       
      
      public var id:uint;
      
      public var name:String;
      
      public var type:uint;
      
      public var autoNext:Boolean;
      
      public var trackable:Boolean;
      
      public var needAcceptMark:Boolean;
      
      public var acceptMapId:int;
      
      public var relatedMapIds:Vector.<int>;
      
      public var onlineTime:String;
      
      public var des:String;
      
      public var acceptDialog:com.taomee.seer2.core.quest.data.DialogDefinition;
      
      public var acceptNpcId:int;
      
      public var prerequisiteDefinition:com.taomee.seer2.core.quest.data.QuestPrerequisiteDefinition;
      
      public var stepDefinitionVec:Vector.<com.taomee.seer2.core.quest.data.QuestStepDefinition>;
      
      public var monLvlUp:String;
      
      public var isShow:Boolean;
      
      public function QuestDefinition(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:String, param10:String, param11:int, param12:Vector.<int>)
      {
         super();
         this.id = param1;
         this.name = param2;
         this.type = param3;
         this.autoNext = param4 == 1;
         this.trackable = param5 == 1;
         this.needAcceptMark = param6 == 1;
         this.relatedMapIds = param12;
         this.acceptMapId = param7;
         this.acceptNpcId = param8;
         this.onlineTime = param9;
         this.monLvlUp = param10;
         this.isShow = param11 == 1;
      }
   }
}
