package com.taomee.seer2.module.login.data
{
   import com.taomee.seer2.module.login.net.LittleEndianByteArray;
   import com.taomee.seer2.module.login.util.StringUtil;
   
   public class MainServerLoginInfo
   {
       
      
      public var resultFlag:int;
      
      public var account:String;
      
      public var password:String;
      
      public var session:LittleEndianByteArray;
      
      public var hasRole:Boolean = false;
      
      public var verifyImgId:LittleEndianByteArray;
      
      public var verifyImgDataSize:int;
      
      public var verifyImgData:LittleEndianByteArray;
      
      public var lastLoginIP:String;
      
      public var lastLoginTime:uint;
      
      public var lastLoginCity:String;
      
      public var curLoginCity:String;
      
      public function MainServerLoginInfo(param1:LittleEndianByteArray)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.resultFlag = param1.readUnsignedInt();
         if(this.resultFlag < 0)
         {
            return;
         }
         if(this.resultFlag == 0)
         {
            this.session = new LittleEndianByteArray();
            param1.readBytes(this.session,0,16);
            this.hasRole = param1.readUnsignedInt() > 0;
         }
         else if(this.resultFlag < 6)
         {
            this.verifyImgId = new LittleEndianByteArray();
            param1.readBytes(this.verifyImgId,0,16);
            this.verifyImgDataSize = param1.readUnsignedInt();
            this.verifyImgData = new LittleEndianByteArray();
            param1.readBytes(this.verifyImgData,0,this.verifyImgDataSize);
         }
         else
         {
            this.session = new LittleEndianByteArray();
            param1.readBytes(this.session,0,16);
            this.hasRole = param1.readUnsignedInt() > 0;
            this.lastLoginIP = StringUtil.uintToIp(param1.readUnsignedInt());
            this.lastLoginTime = param1.readUnsignedInt();
            this.lastLoginCity = param1.readUTFBytes(64);
            this.curLoginCity = param1.readUTFBytes(64);
         }
      }
   }
}
