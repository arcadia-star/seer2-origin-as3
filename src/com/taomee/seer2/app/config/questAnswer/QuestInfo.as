package com.taomee.seer2.app.config.questAnswer
{
   public class QuestInfo
   {
       
      
      private var _id:int;
      
      private var _ask:String;
      
      private var _selectItems:Vector.<String>;
      
      private var _answer:int;
      
      public function QuestInfo()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function set ask(param1:String) : void
      {
         this._ask = param1;
      }
      
      public function set selectItems(param1:Vector.<String>) : void
      {
         this._selectItems = param1;
      }
      
      public function set answer(param1:int) : void
      {
         this._answer = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get ask() : String
      {
         return this._ask;
      }
      
      public function get selectItems() : Vector.<String>
      {
         return this._selectItems;
      }
      
      public function get answer() : int
      {
         return this._answer;
      }
   }
}
