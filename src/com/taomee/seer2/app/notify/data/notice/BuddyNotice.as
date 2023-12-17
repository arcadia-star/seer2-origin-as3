package com.taomee.seer2.app.notify.data.notice
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   
   public class BuddyNotice extends Notice
   {
       
      
      private var _nick:String;
      
      public function BuddyNotice(param1:uint, param2:String)
      {
         super(NoticeType.BUDDY,param1);
         this._nick = param2;
      }
      
      override public function process() : void
      {
         AlertManager.showConfirm("是否要添加" + this._nick + "为你的好友？",function():void
         {
            Connection.send(CommandSet.BUDDY_ADD_1024,userId,LittleEndianByteArray.writeIntergerAsUnsignedByte(0));
         });
      }
   }
}
