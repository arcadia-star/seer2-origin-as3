package com.taomee.seer2.app.arena.data
{
   import flash.utils.IDataInput;
   
   public class BuffResultInfoRoundData
   {
       
      
      public var stateId:uint;
      
      public var changeHp:int;
      
      public function BuffResultInfoRoundData(param1:IDataInput)
      {
         super();
         this.stateId = param1.readUnsignedInt();
         this.changeHp = param1.readInt();
      }
   }
}
