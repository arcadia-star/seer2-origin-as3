package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.popup.AlertInfo;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class AutoCloseAlert extends Alert
   {
       
      
      private var _delayTime:uint;
      
      private var _intervalId:uint;
      
      public function AutoCloseAlert()
      {
         super();
      }
      
      override public function show(param1:AlertInfo) : void
      {
         this._delayTime = param1.initInfo.autoCloseDelayTime;
         this._intervalId = setTimeout(this.autoCloseHandler,this._delayTime * 1000);
         super.show(param1);
      }
      
      override protected function onConfirmBtnClick(param1:MouseEvent) : void
      {
         clearTimeout(this._intervalId);
         super.onConfirmBtnClick(param1);
      }
      
      private function autoCloseHandler() : void
      {
         this.onConfirmBtnClick(null);
      }
   }
}
