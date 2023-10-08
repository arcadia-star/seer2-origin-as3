package com.taomee.seer2.app.processor.quest.handler.branch.quest10228
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10228_920 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10228_920(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(10228,1) && QuestManager.isStepComplete(10228,2) == false)
         {
            if(QuestMapHandler_10228_900.haveStep)
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            }
            else
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
               QuestManager.completeStep(10228,2);
            }
         }
         else if(QuestManager.isStepComplete(10228,1) && QuestManager.isStepComplete(10228,2) && QuestManager.isStepComplete(10228,3) == false)
         {
            this.initStep3();
         }
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == 10228 && param1.stepId == 2)
         {
            this.initStep3();
         }
      }
      
      private function onStep2(param1:QuestEvent) : void
      {
         if(param1.questId == 10228 && param1.stepId == 2)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10161_1"),this.initStep3);
         }
      }
      
      private function initStep3() : void
      {
         NpcDialog.show(400,"小赛尔",[[0,"斯坦因博士！果然是你！"]],["   你也在找瞳魂兽吗？ "],[function():void
         {
            NpcDialog.show(106,"斯坦因",[[1,"好久不见，听说你们也在寻找瞳魂兽吧？"]],["   是的！没错！ "],[function():void
            {
               NpcDialog.show(106,"斯坦因",[[1,"要不，我们合作吧？用我的最新发明。"]],["   合作？ "],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10228_1"),function():void
                  {
                     initStep4();
                  });
               }]);
            }]);
         }]);
      }
      
      private function initStep4() : void
      {
         NpcDialog.show(106,"斯坦因",[[1,"这是我发明的神兽罗盘，能找出瞳魂兽的位置哦！"]],["   那你自己为什么不找？ "],[function():void
         {
            NpcDialog.show(106,"斯坦因",[[1,"我已经老了，跑不动了，我提供你们罗盘，你们来找，如何？"]],["听起来不错……"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10228_2"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                  QuestManager.completeStep(10228,3);
               });
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10228)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            ModuleManager.toggleModule(URLUtil.getAppModule("TongHunBeastPanel"),"打开中...","1");
            MonsterManager.showAllMonster();
            SceneManager.changeScene(SceneType.LOBBY,900);
         }
      }
   }
}
