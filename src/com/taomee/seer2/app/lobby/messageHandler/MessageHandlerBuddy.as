package com.taomee.seer2.app.lobby.messageHandler
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.group.UserGroupManager;
   import com.taomee.seer2.app.actor.group.UserGroupType;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.notify.NoticeManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import com.taomee.seer2.core.net.message.Message;
   import flash.utils.IDataInput;
   
   public class MessageHandlerBuddy implements IMessageHandler
   {
      
      private static const COOKIE_NAME:String = "buddyList";
       
      
      public function MessageHandlerBuddy()
      {
         super();
      }
      
      public function setup() : void
      {
         Connection.addCommandListener(CommandSet.BUDDY_ADD_1024,this.onMessage);
         Connection.addCommandListener(CommandSet.BUDDY_NOTIFY_ADD_1026,this.onMessage);
         Connection.addCommandListener(CommandSet.BUDDY_REPLY_ADD_1027,this.onMessage);
         Connection.addCommandListener(CommandSet.BUDDY_REMOVE_1025,this.onMessage);
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
         switch(param1.message.commandId)
         {
            case CommandSet.BUDDY_ADD_1024.id:
               this.parseAddBuddy(param1.message);
               break;
            case CommandSet.BUDDY_NOTIFY_ADD_1026.id:
               this.parseNotifyAddBuddy(param1.message);
               break;
            case CommandSet.BUDDY_REPLY_ADD_1027.id:
               this.parseReplyAddBuddy(param1.message);
               break;
            case CommandSet.BUDDY_REMOVE_1025.id:
               this.parseRemoveBuddy(param1.message);
         }
      }
      
      private function parseAddBuddy(param1:Message) : void
      {
         var _loc6_:String = null;
         var _loc7_:* = null;
         var _loc2_:IDataInput = param1.getRawData();
         var _loc3_:UserInfo = new UserInfo();
         UserInfoParseHelper.parseUserSimpleInfo(_loc3_,_loc2_);
         var _loc4_:Boolean = Boolean(_loc2_.readUnsignedByte());
         var _loc5_:Boolean = Boolean(_loc2_.readUnsignedByte());
         if(_loc4_ == false)
         {
            _loc6_ = UserGroupType.BUDDY;
            _loc7_ = _loc3_.nick + "已经成为你的好友";
         }
         else
         {
            _loc6_ = UserGroupType.BLACK;
            _loc7_ = _loc3_.nick + "已经加入黑名单";
         }
         if(_loc5_ == true)
         {
            _loc3_.serverID = 1;
         }
         else
         {
            _loc3_.serverID = 0;
         }
         UserGroupManager.addUser(_loc6_,_loc3_);
         ServerMessager.addMessage(_loc7_);
      }
      
      private function parseRemoveBuddy(param1:Message) : void
      {
         var _loc7_:String = null;
         var _loc8_:* = null;
         var _loc2_:IDataInput = param1.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:String = String(_loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN));
         var _loc5_:Boolean = Boolean(_loc2_.readUnsignedByte());
         var _loc6_:UserInfo;
         (_loc6_ = new UserInfo()).id = _loc3_;
         _loc6_.nick = _loc4_;
         if(_loc5_ == false)
         {
            _loc7_ = UserGroupType.BUDDY;
            _loc8_ = _loc6_.nick + "已经从你的好友列表中删除";
         }
         else
         {
            _loc7_ = UserGroupType.BLACK;
            _loc8_ = _loc6_.nick + "已经从你的黑名单中删除";
         }
         UserGroupManager.removeUser(_loc7_,_loc6_);
         ServerMessager.addMessage(_loc8_);
      }
      
      private function parseNotifyAddBuddy(param1:Message) : void
      {
         var _loc2_:IDataInput = param1.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:String = String(_loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN));
         NoticeManager.addBuddyNotice(_loc3_,_loc4_);
      }
      
      private function parseReplyAddBuddy(param1:Message) : void
      {
         var _loc7_:String = null;
         var _loc2_:IDataInput = param1.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:String = String(_loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN));
         var _loc5_:UserInfo;
         (_loc5_ = new UserInfo()).id = _loc3_;
         _loc5_.nick = _loc4_;
         var _loc6_:Boolean;
         if((_loc6_ = Boolean(_loc2_.readUnsignedByte())) == false)
         {
            _loc7_ = UserGroupType.BUDDY;
         }
         else
         {
            _loc7_ = UserGroupType.BLACK;
         }
         UserGroupManager.addUser(_loc7_,_loc5_);
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.BUDDY_ADD_1024,this.onMessage);
         Connection.removeCommandListener(CommandSet.BUDDY_NOTIFY_ADD_1026,this.onMessage);
         Connection.removeCommandListener(CommandSet.BUDDY_REPLY_ADD_1027,this.onMessage);
         Connection.removeCommandListener(CommandSet.BUDDY_REMOVE_1025,this.onMessage);
      }
   }
}
