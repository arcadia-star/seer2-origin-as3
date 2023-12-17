package com.taomee.seer2.app.popup
{
   public class AlertInfo
   {
       
      
      private var _alertType:uint = 0;
      
      private var _initInfo:AlertInitInfo;
      
      private var _centralize:Boolean = true;
      
      private var _isFocus:Boolean = true;
      
      public function AlertInfo()
      {
         super();
      }
      
      public function get centralize() : Boolean
      {
         return this._centralize;
      }
      
      public function set centralize(param1:Boolean) : void
      {
         this._centralize = param1;
      }
      
      public function get isFocus() : Boolean
      {
         return this._isFocus;
      }
      
      public function set isFocus(param1:Boolean) : void
      {
         this._isFocus = param1;
      }
      
      public function get alertType() : uint
      {
         return this._alertType;
      }
      
      public function set alertType(param1:uint) : void
      {
         this._alertType = param1;
      }
      
      public function get initInfo() : AlertInitInfo
      {
         return this._initInfo;
      }
      
      public function set initInfo(param1:AlertInitInfo) : void
      {
         this._initInfo = param1;
      }
   }
}
