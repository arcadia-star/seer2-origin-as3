package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1140
   {
       
      
      public var index:uint;
      
      public var id:uint;
      
      public var count:uint;
      
      public var flag:uint;
      
      public function Parser_1140(param1:IDataInput)
      {
         super();
         this.index = param1.readUnsignedInt();
         this.id = param1.readUnsignedInt();
         this.count = param1.readUnsignedInt();
         this.flag = param1.readUnsignedInt();
      }
   }
}
