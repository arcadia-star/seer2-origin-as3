package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1138
   {
       
      
      public var contributeValue:uint;
      
      public var userCoins:uint;
      
      public var teamCoins:uint;
      
      public function Parser_1138(param1:IDataInput)
      {
         super();
         this.userCoins = param1.readUnsignedInt();
         this.teamCoins = param1.readUnsignedInt();
         this.contributeValue = param1.readUnsignedInt();
      }
   }
}
