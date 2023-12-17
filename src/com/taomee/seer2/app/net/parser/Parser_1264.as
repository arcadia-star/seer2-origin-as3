package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1264
   {
       
      
      public var haveLi:int;
      
      public var allLi:int;
      
      public function Parser_1264(param1:IDataInput)
      {
         super();
         this.haveLi = param1.readUnsignedInt();
         this.allLi = param1.readUnsignedInt();
      }
   }
}
