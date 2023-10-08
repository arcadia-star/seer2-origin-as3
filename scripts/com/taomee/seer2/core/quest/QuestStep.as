package com.taomee.seer2.core.quest
{
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.quest.data.QuestStepDefinition;
   import com.taomee.seer2.core.quest.data.TargetDefinition;
   import flash.geom.Point;
   
   public class QuestStep
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var _sum:String;
      
      private var _des:String;
      
      private var _transport:String;
      
      private var _dialog:DialogDefinition;
      
      public var relatedNpcId:int;
      
      private var _income:com.taomee.seer2.core.quest.QuestProduct;
      
      private var _outcome:com.taomee.seer2.core.quest.QuestProduct;
      
      private var _quest:com.taomee.seer2.core.quest.Quest;
      
      private var _target:TargetDefinition;
      
      private var _point:Point;
      
      public function QuestStep(param1:com.taomee.seer2.core.quest.Quest, param2:QuestStepDefinition)
      {
         super();
         this._quest = param1;
         this.parseDefinition(param2);
      }
      
      private function parseDefinition(param1:QuestStepDefinition) : void
      {
         this._id = param1.id;
         this._name = param1.name;
         this._sum = param1.sum;
         this._des = param1.des;
         this._transport = param1.transport;
         this._income = new com.taomee.seer2.core.quest.QuestProduct(param1.income);
         this._outcome = new com.taomee.seer2.core.quest.QuestProduct(param1.outcome);
         this._dialog = param1.dialogDefinition;
         this.relatedNpcId = param1.relatedNpcId;
         if(this.relatedNpcId == 0 && Boolean(this._dialog))
         {
            this.relatedNpcId = this._dialog.npcId;
         }
         this._target = param1.targetDefinition;
         this._point = param1.point;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get sum() : String
      {
         return this._sum;
      }
      
      public function get des() : String
      {
         return this._des;
      }
      
      public function get transport() : String
      {
         return this._transport;
      }
      
      public function get dialog() : DialogDefinition
      {
         return this._dialog;
      }
      
      public function get target() : TargetDefinition
      {
         return this._target;
      }
      
      public function get point() : Point
      {
         return this._point;
      }
      
      public function get income() : com.taomee.seer2.core.quest.QuestProduct
      {
         return this._income;
      }
      
      public function get outcome() : com.taomee.seer2.core.quest.QuestProduct
      {
         return this._outcome;
      }
      
      public function get quest() : com.taomee.seer2.core.quest.Quest
      {
         return this._quest;
      }
   }
}
