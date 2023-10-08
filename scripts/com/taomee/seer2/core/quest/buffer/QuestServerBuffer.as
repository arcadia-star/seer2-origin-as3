package com.taomee.seer2.core.quest.buffer
{
   import flash.utils.IDataInput;
   
   public class QuestServerBuffer
   {
      
      private static const MAX_STEP_NUM:int = 10;
       
      
      private var _statusVec:Vector.<int>;
      
      private var _extraDataVec:Vector.<int>;
      
      public function QuestServerBuffer(param1:IDataInput)
      {
         super();
         this.parseData(param1);
      }
      
      private function parseData(param1:IDataInput) : void
      {
         this._statusVec = new Vector.<int>();
         this._extraDataVec = new Vector.<int>();
         var _loc2_:int = 0;
         while(_loc2_ < MAX_STEP_NUM)
         {
            this._statusVec.push(param1.readByte());
            this._extraDataVec.push(param1.readByte());
            _loc2_++;
         }
      }
      
      public function getStepStatus(param1:int) : int
      {
         return this._statusVec[param1 - 1];
      }
      
      public function getStepData(param1:int) : int
      {
         return this._extraDataVec[param1 - 1];
      }
   }
}
