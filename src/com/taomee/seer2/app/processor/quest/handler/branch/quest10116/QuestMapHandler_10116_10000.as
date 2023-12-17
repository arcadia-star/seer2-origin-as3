package com.taomee.seer2.app.processor.quest.handler.branch.quest10116
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.branch.quest10115.QuestMapHandlerDream;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10116_10000 extends QuestMapHandlerDream
   {
       
      
      private var tipsTxtMc:MovieClip;
      
      private var firePanel:FindFirePanel;
      
      private var stepNum:int;
      
      public function QuestMapHandler_10116_10000(param1:QuestProcessor)
      {
         super(param1);
         _questID = 10116;
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isComplete(_quest.id))
         {
            ActorManager.showRemoteActor = false;
         }
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.initStep2();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this.initStep3();
         }
      }
      
      private function initStep3() : void
      {
         NpcDialog.show(508,"我",[[0,"就在我麻木地四处征战时，我遇见了“他”……他究竟是敌人，还是伙伴……？我只知道，他很强大……"]],["脑海中渐渐有画面浮现出来了"],[function():void
         {
            playTipsTxt(3);
         }]);
      }
      
      private function initStep2() : void
      {
         NpcDialog.show(508,"我",[[0,"我记得，在漫长的孤独的岁月里，我听到了一些消息……这些消息改变了我的命运，但是，那究竟是什么呢……？"]],["脑海中渐渐有画面浮现出来了"],[function():void
         {
            playTipsTxt(2);
         }]);
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(508,"我",[[0,"我……是谁……这里是哪里……？"]],["睁开双眼看看吧"],[function():void
         {
            (SceneManager.active as LobbyScene).hideToolbar();
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10116_0"),function():void
            {
               (SceneManager.active as LobbyScene).hideToolbar();
               NpcDialog.show(508,"我",[[0,"火焰，对，火焰……但是，我是谁？"]],["脑海中渐渐有画面浮现出来了"],[function():void
               {
                  playTipsTxt(1);
               }]);
            });
         }]);
      }
      
      private function playTipsTxt(param1:int) : void
      {
         var step:int = param1;
         (SceneManager.active as LobbyScene).hideToolbar();
         this.stepNum = step;
         this.tipsTxtMc = _processor.resLib.getMovieClip("tipsTxtMc" + step);
         _map.front.addChild(this.tipsTxtMc);
         MovieClipUtil.playMc(this.tipsTxtMc,1,this.tipsTxtMc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(tipsTxtMc);
            startFindFire();
         });
      }
      
      private function startFindFire() : void
      {
         this.firePanel = new FindFirePanel(_processor.resLib.getMovieClip("firePanel" + this.stepNum),this.onCompleteFind);
         _map.front.addChild(this.firePanel);
      }
      
      private function onCompleteFind() : void
      {
         var burn:MovieClip = null;
         this.firePanel.dispose();
         burn = _processor.resLib.getMovieClip("burn" + this.stepNum);
         _map.front.addChild(burn);
         MovieClipUtil.playMc(burn,2,burn.totalFrames,function():void
         {
            burn.stop();
            DisplayObjectUtil.removeFromParent(burn);
            if(stepNum == 1)
            {
               NpcDialog.show(508,"我",[[0,"他们……是北半球最强的精灵……但是，却没有一个能够战胜我？对，在北半球，我已经没有对手……"]],["孤独却伴随着强大一起出现，没有对手，也没有朋友！"],[function():void
               {
                  (SceneManager.active as LobbyScene).hideToolbar();
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep1);
                  QuestManager.completeStep(_quest.id,1);
               }]);
            }
            if(stepNum == 2)
            {
               NpcDialog.show(508,"我",[[0,"南半球有一个强大的黑暗帝国崛起……他们到处抢夺资源，对北半球构成了极大的威胁……"]],["对，正是这个消息让我决定去南半球……"],[function():void
               {
                  (SceneManager.active as LobbyScene).hideToolbar();
                  NpcDialog.show(508,"我",[[0,"也许，那里有我想要的强大对手……也许，我可以独自将这势力完全毁灭……"]],["然而，我却遭遇了最可怕的对手……"],[function():void
                  {
                     (SceneManager.active as LobbyScene).hideToolbar();
                     NpcDialog.show(508,"我",[[0,"当我终于放弃战胜的信念时，有一个神秘的博士告诉我，他能够令我变强……是的变强……为了变强，我不惜付出一切……！"]],["但是，这还是我的初衷吗……？"],[function():void
                     {
                        (SceneManager.active as LobbyScene).hideToolbar();
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep2);
                        QuestManager.completeStep(_quest.id,2);
                     }]);
                  }]);
               }]);
            }
            if(stepNum == 3)
            {
               NpcDialog.show(508,"我",[[0,"那是谁？是我？还是……他？"]],["我和他，究竟有什么联系……？"],[function():void
               {
                  (SceneManager.active as LobbyScene).hideToolbar();
                  NpcDialog.show(508,"我",[[0,"我们会携手共战……？不……我不知道……脑海中又出现了一团黑暗……我，我是谁？"]],["黑暗席卷了一切画面"],[function():void
                  {
                     (SceneManager.active as LobbyScene).hideToolbar();
                     showStone();
                  }]);
               }]);
            }
         });
      }
      
      override protected function clickStone(param1:MouseEvent) : void
      {
         stoneMc.removeEventListener(MouseEvent.CLICK,this.clickStone);
         ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"),"打开中...",{
            "toHome":true,
            "completeQuestId":10116,
            "completeStep":3
         });
      }
      
      private function onCompleteStep2(param1:QuestEvent) : void
      {
         if(param1.questId == 10116 && param1.stepId == 2)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
            this.initStep3();
         }
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == 10116 && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            this.initStep2();
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
         super.processMapDispose();
      }
   }
}
