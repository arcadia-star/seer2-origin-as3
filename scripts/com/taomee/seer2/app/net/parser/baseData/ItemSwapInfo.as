package com.taomee.seer2.app.net.parser.baseData
{
   import flash.utils.IDataInput;
   
   public class ItemSwapInfo
   {
       
      
      public var id:uint;
      
      public var count:Number;
      
      public var expireTime:uint;
      
      public function ItemSwapInfo(param1:IDataInput)
      {
         super();
         this.id = param1.readUnsignedInt();
         this.count = param1.readShort();
         this.expireTime = param1.readUnsignedInt();
      }
   }
}
