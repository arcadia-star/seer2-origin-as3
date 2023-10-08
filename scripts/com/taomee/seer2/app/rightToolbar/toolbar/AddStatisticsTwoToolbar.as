package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import flash.events.MouseEvent;
   
   public class AddStatisticsTwoToolbar extends RightToolbar
   {
       
      
      public function AddStatisticsTwoToolbar()
      {
         super();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         StatisticsManager.newSendNovice("2015活动","ICON点击","点击44号ICON");
         super.onClick(param1);
      }
   }
}
