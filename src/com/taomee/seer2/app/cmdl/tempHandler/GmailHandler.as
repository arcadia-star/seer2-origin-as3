package com.taomee.seer2.app.cmdl.tempHandler
{
   import com.taomee.seer2.app.mail.GmailDataManager;
   import com.taomee.seer2.app.net.parser.Parser_1548;
   
   public class GmailHandler implements IHandler
   {
       
      
      public function GmailHandler()
      {
         super();
      }
      
      public function handle(param1:Parser_1548) : void
      {
         GmailDataManager.getInstance().updateMailNum();
      }
   }
}
