package com.taomee.seer2.app.home.dailyQuest
{
   import com.taomee.seer2.app.inventory.ItemDescription;
   
   public class HomeDailyQuest
   {
      
      public static const UNACCEPT:int = 0;
      
      public static const INPROGRESS:int = 1;
      
      public static const COMPLETE:int = 2;
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var _des:String;
      
      private var _status:int;
      
      private var _totalCount:int;
      
      private var _completeCount:int;
      
      private var _category:HomeDailyCategory;
      
      private var _stepVec:Vector.<HomeDailyStep>;
      
      public function HomeDailyQuest(param1:int, param2:String, param3:String, param4:int)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._des = param3;
         this._totalCount = param4;
         this._stepVec = new Vector.<HomeDailyStep>();
      }
      
      public function addStep(param1:int, param2:Array) : void
      {
         this._stepVec.push(new HomeDailyStep(param1,param2));
      }
      
      public function getLastStepItemDesVec() : Vector.<ItemDescription>
      {
         var _loc1_:HomeDailyStep = null;
         for each(_loc1_ in this._stepVec)
         {
            if(_loc1_.id == this._totalCount)
            {
               return _loc1_.itemDesVec;
            }
         }
         return null;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get des() : String
      {
         return this._des;
      }
      
      public function get count() : int
      {
         return this._totalCount;
      }
      
      public function set status(param1:int) : void
      {
         this._status = param1;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function get completeCount() : int
      {
         return this._completeCount;
      }
      
      public function set completeCount(param1:int) : void
      {
         this._completeCount = param1;
      }
      
      public function get category() : HomeDailyCategory
      {
         return this._category;
      }
      
      public function set category(param1:HomeDailyCategory) : void
      {
         this._category = param1;
      }
   }
}
