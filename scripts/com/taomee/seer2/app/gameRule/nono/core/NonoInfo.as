package com.taomee.seer2.app.gameRule.nono.core
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.gameRule.nono.NonoInfoEvent;
   import com.taomee.seer2.app.gameRule.nono.NonoUtil;
   import flash.utils.IDataInput;
   
   public class NonoInfo
   {
       
      
      public var isHava:Boolean;
      
      public var nonoName:String;
      
      public var color:uint = 0;
      
      public var equipId:uint = 0;
      
      private var _flag:int = 0;
      
      private var _isFollowing:Boolean = false;
      
      public function NonoInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : void
      {
         this.isHava = param1.readUnsignedByte() == 1;
         if(this.isHava)
         {
            this.nonoName = param1.readUTFBytes(16);
            this.flag = param1.readUnsignedInt();
            this.color = param1.readUnsignedInt();
         }
         else
         {
            this.nonoName = param1.readUTFBytes(16);
            this.flag = param1.readUnsignedInt();
            this.color = param1.readUnsignedInt();
            this.nonoName = "";
            this.flag = 0;
            this.color = 0;
         }
      }
      
      public function getNonoType(param1:UserInfo) : uint
      {
         if(param1.vipInfo.isVip())
         {
            return 9998;
         }
         return 9999;
      }
      
      public function set flag(param1:int) : void
      {
         this._flag = param1;
         this._isFollowing = (param1 & 1) == 1;
         NonoUtil.dispatchEvent(new NonoInfoEvent(NonoInfoEvent.NONO_FLAG_CHANGE));
      }
      
      public function get isFollowing() : Boolean
      {
         return this._isFollowing && this.isHava;
      }
      
      public function set isFollowing(param1:Boolean) : void
      {
         this._isFollowing = param1;
         this.updateFlag();
      }
      
      private function updateFlag() : void
      {
         var _loc1_:int = 0;
         _loc1_ += this._isFollowing ? 1 : 0;
         this._flag = _loc1_;
         NonoUtil.dispatchEvent(new NonoInfoEvent(NonoInfoEvent.NONO_FLAG_CHANGE));
      }
   }
}
