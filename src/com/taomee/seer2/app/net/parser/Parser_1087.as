package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1087
   {
       
      
      public var itemVec:Vector.<Info>;
      
      public function Parser_1087(param1:IDataInput)
      {
         super();
         this.itemVec = new Vector.<Info>();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.itemVec.push(new Info(param1));
            _loc3_++;
         }
      }
   }
}

import flash.utils.IDataInput;

class Info
{
    
   
   public var petCatchTime:uint;
   
   public var itemId:uint;
   
   public var itemCount:uint;
   
   public function Info(param1:IDataInput)
   {
      super();
      this.petCatchTime = param1.readUnsignedInt();
      this.itemId = param1.readUnsignedInt();
      this.itemCount = param1.readUnsignedShort();
   }
}
