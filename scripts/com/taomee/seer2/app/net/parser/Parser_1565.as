package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1565
   {
       
      
      public var monIDVec:Vector.<uint>;
      
      public var capacity:uint;
      
      public function Parser_1565(param1:IDataInput)
      {
         super();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         this.monIDVec = new Vector.<uint>();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.monIDVec.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.capacity = param1.readUnsignedInt();
      }
   }
}
