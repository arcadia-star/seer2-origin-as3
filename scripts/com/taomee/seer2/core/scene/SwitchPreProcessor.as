package com.taomee.seer2.core.scene
{
   public class SwitchPreProcessor
   {
       
      
      protected var _callBack:Function;
      
      protected var _data:com.taomee.seer2.core.scene.SwitchData;
      
      public function SwitchPreProcessor()
      {
         super();
      }
      
      public function process(param1:com.taomee.seer2.core.scene.SwitchData, param2:Function) : void
      {
         this._data = param1;
         this._callBack = param2;
         this.handlerCallBack();
      }
      
      protected function handlerCallBack() : void
      {
         this._callBack(this._data);
         this._callBack = null;
         this._data = null;
      }
   }
}
