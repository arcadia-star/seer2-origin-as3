package com.taomee.seer2.app.processor.quest.handler.activity.quest30047
{
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_30047_510 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30047_510(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL,this.onQuest);
         }
      }
      
      private function onQuest(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var count:uint = uint(server.readDataAtPostion(4));
         count += 1;
         if(count < 10)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL,4,count);
            ServerMessager.addMessage("您成功获得了1支彩棉");
         }
         else
         {
            if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL,4,10);
               QuestManager.completeStep(_quest.id,1);
            }
            AlertManager.showAlert("恭喜您收集到了所有的彩棉",function():void
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("MakeBattleSuitPanel"),"");
            });
         }
      }
   }
}
