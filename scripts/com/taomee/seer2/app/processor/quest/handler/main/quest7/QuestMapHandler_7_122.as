package com.taomee.seer2.app.processor.quest.handler.main.quest7
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.utils.NpcUtil;
   
   public class QuestMapHandler_7_122 extends QuestMapHandler_7_Base
   {
       
      
      public function QuestMapHandler_7_122(param1:QuestProcessor)
      {
         super(param1);
         _flagIndex = 0;
      }
      
      override protected function showSeerDialog() : void
      {
         DialogPanel.showForSimple(NpcUtil.getSeerNpcId(),"我",[[0,"小乖乖，走！我带你们回家……"]],"（我感觉自己是海马保姆……）");
      }
   }
}
