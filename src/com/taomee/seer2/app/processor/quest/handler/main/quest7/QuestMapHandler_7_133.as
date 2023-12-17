package com.taomee.seer2.app.processor.quest.handler.main.quest7
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.utils.NpcUtil;
   
   public class QuestMapHandler_7_133 extends QuestMapHandler_7_Base
   {
       
      
      public function QuestMapHandler_7_133(param1:QuestProcessor)
      {
         super(param1);
         _flagIndex = 2;
      }
      
      override protected function showSeerDialog() : void
      {
         DialogPanel.showForSimple(NpcUtil.getSeerNpcId(),"我",[[0,"走啦走啦！回家了……"]],"（这些小家伙还真是可爱）");
      }
   }
}
