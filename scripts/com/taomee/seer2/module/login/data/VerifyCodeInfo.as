package com.taomee.seer2.module.login.data
{
   import com.taomee.seer2.module.login.net.LittleEndianByteArray;
   import flash.utils.IDataInput;
   
   public class VerifyCodeInfo
   {
       
      
      private var _isNeedVerify:Boolean = false;
      
      private var _verifyImgIdData:LittleEndianByteArray;
      
      private var _verifyImgData:LittleEndianByteArray;
      
      private var _verifyCodeData:LittleEndianByteArray;
      
      public function VerifyCodeInfo(param1:IDataInput = null)
      {
         var _loc3_:uint = 0;
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:uint = uint(param1.readUnsignedInt());
         if(_loc2_ == 1)
         {
            this._verifyImgIdData = new LittleEndianByteArray();
            param1.readBytes(this._verifyImgIdData,0,16);
            _loc3_ = uint(param1.readUnsignedInt());
            this._verifyImgData = new LittleEndianByteArray();
            param1.readBytes(this._verifyImgData,0,_loc3_);
            this._isNeedVerify = true;
         }
         else
         {
            this._isNeedVerify = false;
         }
      }
      
      public function get isNeedVerify() : Boolean
      {
         return this._isNeedVerify;
      }
      
      public function set isNeedVerify(param1:Boolean) : void
      {
         this._isNeedVerify = param1;
      }
      
      public function setVerifyImgIdData(param1:LittleEndianByteArray) : void
      {
         this._verifyImgIdData = param1;
      }
      
      public function getVerifyImgIdData() : LittleEndianByteArray
      {
         var _loc1_:int = 0;
         if(this._verifyImgIdData == null)
         {
            this._verifyImgIdData = new LittleEndianByteArray();
            _loc1_ = 0;
            while(_loc1_ < 16)
            {
               this._verifyImgIdData.writeByte(0);
               _loc1_++;
            }
         }
         return this._verifyImgIdData;
      }
      
      public function setVerifyImgData(param1:LittleEndianByteArray) : void
      {
         this._verifyImgData = param1;
      }
      
      public function getVerifyImgData() : LittleEndianByteArray
      {
         return this._verifyImgData;
      }
      
      public function setVerifyCodeData(param1:LittleEndianByteArray) : void
      {
         this._verifyCodeData = param1;
      }
      
      public function getVerifyCodeData() : LittleEndianByteArray
      {
         var _loc1_:int = 0;
         if(this._verifyCodeData == null)
         {
            this._verifyCodeData = new LittleEndianByteArray();
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               this._verifyCodeData.writeByte(0);
               _loc1_++;
            }
         }
         return this._verifyCodeData;
      }
   }
}
