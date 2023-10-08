package com.taomee.seer2.app.processor.quest.handler.branch.quest10218
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10218_80129 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10218_80129(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10218) && QuestManager.isStepComplete(10218,4) == false)
         {
            this.initStep4();
         }
      }
      
      private function initStep4() : void
      {
         NpcDialog.show(80,"葛蕾芬兵团长",[[0,"是谁？胆敢闯入飞翼群岛。"]],["啊，没有，我来找总督大人签署契约！"],[function():void
         {
            NpcDialog.show(80,"葛蕾芬兵团长",[[0,"什么契约？"]],["事情是这样的……"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_3"),function():void
               {
                  NpcDialog.show(80,"葛蕾芬兵团长",[[0,"原来是这样啊，可是我们的总督大人平时飘忽不定，我也不知道他现在在哪里。"]],["那怎么办啊……"],[function():void
                  {
                     NpcDialog.show(80,"葛蕾芬兵团长",[[0,"先别着急，你可以去时镜之岛，使用望远镜看看，应该可以找到总督大人。"]],["好的，事不宜迟，我先去了！"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                        QuestManager.completeStep(10218,4);
                     }]);
                  }]);
               },true,true);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80130);
      }
   }
}
