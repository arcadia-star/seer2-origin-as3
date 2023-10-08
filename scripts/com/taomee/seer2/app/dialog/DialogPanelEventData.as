package com.taomee.seer2.app.dialog
{
   public class DialogPanelEventData
   {
       
      
      private var _type:String;
      
      private var _params:String;
      
      public function DialogPanelEventData(param1:String, param2:String)
      {
         super();
         this._type = param1;
         this._params = param2;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get params() : String
      {
         return this._params;
      }
   }
}
