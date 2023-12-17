package com.taomee.seer2.app.processor.quest.handler.activity.quest30043
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_30043_141 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30043_141(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.OPEN_SCROOL,this.onQuest);
         }
      }
      
      private function onQuest(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var count:uint = uint(server.readDataAtPostion(4));
         count++;
         if(count < 10)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL,4,count);
            ServerMessager.addMessage("获得1个彩角");
         }
         else
         {
            if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL,4,10);
               QuestManager.completeStep(_quest.id,1);
            }
            NpcDialog.show(113,"NONO",[[0,"主人！10个彩角已经拿回来了，我们现在就回到传送室交给包工头吧！"]],["好的！"],[function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            }]);
         }
      }
      
      override public function processMapDispose() : void
      {
      }
   }
}
