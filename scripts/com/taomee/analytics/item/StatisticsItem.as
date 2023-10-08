package com.taomee.analytics.item
{
   public class StatisticsItem
   {
       
      
      private var _submitLimit:int;
      
      private var _data:int;
      
      private var _label:String;
      
      public function StatisticsItem(param1:String, param2:int, param3:int = 1)
      {
         super();
         _label = param1;
         _data = param2;
         _submitLimit = param3;
      }
      
      public function get submitLimit() : int
      {
         return _submitLimit;
      }
      
      public function set submitLimit(param1:int) : void
      {
         _submitLimit = param1;
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function set label(param1:String) : void
      {
         _label = param1;
      }
      
      public function set data(param1:int) : void
      {
         _data = param1;
      }
      
      public function get label() : String
      {
         return _label;
      }
   }
}
