package com.taomee.seer2.app.notify.data.notice
{
   public class Notice
   {
       
      
      private var _type:String;
      
      private var _userId:uint;
      
      public function Notice(param1:String, param2:uint)
      {
         super();
         this._type = param1;
         this._userId = param2;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get userId() : uint
      {
         return this._userId;
      }
      
      public function process() : void
      {
      }
   }
}
