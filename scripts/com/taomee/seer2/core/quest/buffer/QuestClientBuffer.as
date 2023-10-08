package com.taomee.seer2.core.quest.buffer
{
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import flash.utils.IDataInput;
   
   public class QuestClientBuffer
   {
      
      private static const MAX_STEP_NUM:int = 11;
      
      private static const EXTRA_DATA_LEN:int = 3;
       
      
      private var _statusVec:Vector.<int>;
      
      private var _extraDataVec:Vector.<Vector.<int>>;
      
      public function QuestClientBuffer(param1:IDataInput)
      {
         super();
         this.parseData(param1);
      }
      
      private function parseData(param1:IDataInput) : void
      {
         var _loc3_:Vector.<int> = null;
         var _loc4_:int = 0;
         this._statusVec = new Vector.<int>();
         this._extraDataVec = new Vector.<Vector.<int>>();
         var _loc2_:int = 0;
         while(_loc2_ < MAX_STEP_NUM)
         {
            this._statusVec.push(param1.readByte());
            _loc3_ = new Vector.<int>();
            this._extraDataVec.push(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < EXTRA_DATA_LEN)
            {
               _loc3_.push(param1.readByte());
               _loc4_++;
            }
            _loc2_++;
         }
      }
      
      public function getStepStatus(param1:int) : int
      {
         return this._statusVec[param1 - 1];
      }
      
      public function setStepStatus(param1:int, param2:int) : void
      {
         if(param2 < 255 && param2 >= 0)
         {
            this._statusVec[param1 - 1] = param2;
         }
      }
      
      public function getStepData(param1:int, param2:int) : int
      {
         return this._extraDataVec[param1 - 1][param2];
      }
      
      public function setStepData(param1:int, param2:int, param3:int) : void
      {
         if(param2 >= 0 && param2 < EXTRA_DATA_LEN)
         {
            this._extraDataVec[param1 - 1][param2] = param3;
         }
      }
      
      public function pack() : LittleEndianByteArray
      {
         var _loc3_:int = 0;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc2_:int = 0;
         while(_loc2_ < MAX_STEP_NUM)
         {
            _loc1_.writeByte(this._statusVec[_loc2_]);
            _loc3_ = 0;
            while(_loc3_ < EXTRA_DATA_LEN)
            {
               _loc1_.writeByte(this._extraDataVec[_loc2_][_loc3_]);
               _loc3_++;
            }
            _loc2_++;
         }
         _loc1_.position = 0;
         return _loc1_;
      }
   }
}
