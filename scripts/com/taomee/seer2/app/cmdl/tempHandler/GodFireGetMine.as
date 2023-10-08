package com.taomee.seer2.app.cmdl.tempHandler
{
   import com.taomee.seer2.app.net.parser.Parser_1548;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.module.ModuleManager;
   
   public class GodFireGetMine implements IHandler
   {
       
      
      public function GodFireGetMine()
      {
         super();
      }
      
      public function handle(param1:Parser_1548) : void
      {
         ServerMessager.addMessage("备战火神节活动挖矿任务已完成!");
         ModuleManager.showAppModule("GodFireActPanel");
      }
   }
}
