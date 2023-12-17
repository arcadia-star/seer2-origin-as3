package com.taomee.seer2.app.mail
{
   public class GmailDataObj
   {
       
      
      public var readSymble:Boolean;
      
      public var senderId:int;
      
      public var senderName:String;
      
      public var mailTitle:String;
      
      public var rawSendTime:int;
      
      public var attachmentSymble:Boolean;
      
      public var attachmentArray:Array;
      
      public var type:int;
      
      public var mailId:int;
      
      public var contentTxt:String;
      
      public function GmailDataObj()
      {
         super();
      }
      
      public function get sendTime() : String
      {
         var _loc1_:Date = new Date(this.rawSendTime * 1000);
         return String(_loc1_.fullYear) + "-" + String(_loc1_.month + 1) + "-" + String(_loc1_.date);
      }
   }
}
