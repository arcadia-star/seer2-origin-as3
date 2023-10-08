package com.taomee.seer2.app.processor.quest.handler.branch.quest10125
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_46;
   
   public class QuestMapHandler_10125_192 extends QuestMapHandler_10125_Peddle
   {
       
      
      private var mine:com.taomee.seer2.app.processor.quest.handler.branch.quest10125.QuestMapHandler_10125_Mine;
      
      public function QuestMapHandler_10125_192(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         npcid = 31;
         buffPosition = ServerBufferPosition_46.SCALE_STATE_31;
         this.mine = new com.taomee.seer2.app.processor.quest.handler.branch.quest10125.QuestMapHandler_10125_Mine(_processor);
         this.mine.mineId = 400002;
         this.mine.processMapComplete();
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this.mine)
         {
            this.mine.dispose();
            this.mine = null;
         }
      }
   }
}
