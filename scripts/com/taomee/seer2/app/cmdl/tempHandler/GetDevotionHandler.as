package com.taomee.seer2.app.cmdl.tempHandler
{
   import com.taomee.seer2.app.net.parser.Parser_1548;
   import com.taomee.seer2.app.popup.ServerMessager;
   
   public class GetDevotionHandler implements IHandler
   {
       
      
      public function GetDevotionHandler()
      {
         super();
      }
      
      public function handle(param1:Parser_1548) : void
      {
         var _loc2_:uint = 0;
         if(param1 && param1.eventDataVec && param1.eventDataVec.length > 0)
         {
            _loc2_ = uint(param1.eventDataVec[0]);
            ServerMessager.addMessage("恭喜你获得" + _loc2_ + "贡献值!");
         }
      }
   }
}
