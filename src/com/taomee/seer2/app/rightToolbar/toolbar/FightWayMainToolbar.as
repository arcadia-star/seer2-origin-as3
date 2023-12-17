package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import flash.events.MouseEvent;
   
   public class FightWayMainToolbar extends RightToolbar
   {
       
      
      public function FightWayMainToolbar()
      {
         super();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         NewGuidStatisManager.newPlayerStatisHandle(15);
         if(NewPlayerGuideTimeManager.timeCheckNewGuide())
         {
            super.onClick(param1);
         }
      }
   }
}
