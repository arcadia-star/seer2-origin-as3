package com.taomee.seer2.module.login.data
{
   import com.taomee.seer2.module.login.net.LittleEndianByteArray;
   
   public class ConfirmActiveCodeInfo
   {
       
      
      public var resultFlag:int;
      
      public var verifyImgId:LittleEndianByteArray;
      
      public var verifyImgDataSize:int;
      
      public var verifyImgData:LittleEndianByteArray;
      
      public function ConfirmActiveCodeInfo(param1:LittleEndianByteArray)
      {
         super();
         this.resultFlag = param1.readUnsignedInt();
         if(this.resultFlag == 0)
         {
            return;
         }
         this.verifyImgId = new LittleEndianByteArray();
         param1.readBytes(this.verifyImgId,0,16);
         this.verifyImgDataSize = param1.readUnsignedInt();
         this.verifyImgData = new LittleEndianByteArray();
         param1.readBytes(this.verifyImgData,0,this.verifyImgDataSize);
      }
   }
}
