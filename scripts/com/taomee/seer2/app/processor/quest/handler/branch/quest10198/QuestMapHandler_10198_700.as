package com.taomee.seer2.app.processor.quest.handler.branch.quest10198
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10198_700 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10198_700(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) == false)
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         if(QuestManager.isAccepted(_quest.id) == true && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.playMovie();
         }
         if(QuestManager.isStepComplete(10198,2) == true && QuestManager.isStepComplete(10198,3) == false)
         {
            this.complete();
         }
      }
      
      private function complete() : void
      {
         AlertManager.showAlert("哇，已经全部找到了。",function():void
         {
            QuestManager.completeStep(10198,2);
            NpcDialog.show(400,"小赛尔",[[1,"哎呀，经历前行万苦，终于找到这些发光物体。让我来仔细观看一下。"]],["仔细观察线索"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10198_1"),function():void
               {
                  NpcDialog.show(400,"小赛尔",[[4,"哎~不管了，先去找观察员纳格托告诉他我的发现吧！"]],["Go！Go！Go！"],[function():void
                  {
                     QuestManager.completeStep(10198,3);
                  }]);
               });
            }]);
         });
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.playMovie();
         }
      }
      
      private function playMovie() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10198_0"),function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"你是不是希望我帮你调查下这奇妙的光芒是什么对吗？"]],["真聪明！"],[function():void
            {
               NpcDialog.show(102,"观察员纳格托",[[0,"不过这个光芒白天几乎看不见，只有晚上才会比较明显。"]],["那他们分别消失在哪里呢？"],[function():void
               {
                  NpcDialog.show(102,"观察员纳格托",[[0,"它们消失飞翼氏族主城的附近，建议你可以到街心花园、汲雨之岛、空港调查看看。"]],["打开约瑟传说"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                     QuestManager.completeStep(_quest.id,1);
                  }]);
               }]);
            }]);
         });
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"),"","1");
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         super.processMapDispose();
      }
   }
}
