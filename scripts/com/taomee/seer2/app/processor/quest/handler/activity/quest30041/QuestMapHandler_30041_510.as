package com.taomee.seer2.app.processor.quest.handler.activity.quest30041
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
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
   
   public class QuestMapHandler_30041_510 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30041_510(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               ServerBufferManager.getServerBuffer(ServerBufferType.OPEN_SCROOL,this.onQuest);
            }
         }
      }
      
      private function onQuest(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var count:uint = uint(server.readDataAtPostion(0));
         count++;
         if(count < 5)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL,0,count);
            ServerMessager.addMessage("获得1件针织毛纺");
         }
         else
         {
            if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL,0,10);
               QuestManager.completeStep(_quest.id,1);
            }
            NpcDialog.show(113,"NONO",[[0,"主人！5件针织毛纺已经拿回来了，我们现在就回到传送室交给包工头吧！"]],["好的！"],[function():void
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
