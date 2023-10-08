package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1125
   {
       
      
      public var buddyList:Vector.<Info>;
      
      public function Parser_1125(param1:IDataInput)
      {
         super();
         this.buddyList = new Vector.<Info>();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.buddyList.push(new Info(param1));
            _loc3_++;
         }
      }
   }
}

import flash.utils.IDataInput;

class Info
{
    
   
   public var id:uint;
   
   public var name:String;
   
   public function Info(param1:IDataInput)
   {
      super();
      this.id = param1.readUnsignedInt();
      this.name = param1.readUTFBytes(16);
   }
}
