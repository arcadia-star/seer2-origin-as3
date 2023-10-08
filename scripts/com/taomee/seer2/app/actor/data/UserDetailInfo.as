package com.taomee.seer2.app.actor.data
{
   import flash.utils.IDataInput;
   
   public class UserDetailInfo
   {
       
      
      public var petCount:int;
      
      public var petLevel:int;
      
      public var sptCount:int;
      
      public var medalCount:int;
      
      public var signature:String;
      
      public function UserDetailInfo(param1:IDataInput = null)
      {
         var _loc2_:uint = 0;
         super();
         if(param1 != null)
         {
            this.petCount = param1.readUnsignedInt();
            this.petLevel = param1.readUnsignedByte();
            this.sptCount = param1.readUnsignedInt();
            this.medalCount = param1.readUnsignedInt();
            _loc2_ = uint(param1.readUnsignedInt());
            this.signature = param1.readUTFBytes(_loc2_);
         }
      }
      
      public function update(param1:UserDetailInfo) : void
      {
         this.petCount = param1.petCount;
         this.petLevel = param1.petLevel;
         this.sptCount = param1.sptCount;
         this.medalCount = param1.medalCount;
      }
   }
}
