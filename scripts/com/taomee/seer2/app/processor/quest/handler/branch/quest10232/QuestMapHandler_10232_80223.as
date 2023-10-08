package com.taomee.seer2.app.processor.quest.handler.branch.quest10232
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10232_80223 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10232_80223(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      private function initAccept() : void
      {
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.accept(questID);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         var mc:MovieClip = null;
         mc = _processor.resLib.getMovieClip("Mc10232_0");
         _map.content.addChild(mc);
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            NpcDialog.show(406,"目灵兽",[[0,"小精灵，你没事吧？"]],["摔疼了吧？"],[function():void
            {
               NpcDialog.show(766,"小梦",[[0,"好大的长颈鹿啊！"]],["长颈鹿？"],[function():void
               {
                  NpcDialog.show(406,"目灵兽",[[0,"长颈鹿？那是什么？"]],["目灵兽一定没见过"],[function():void
                  {
                     NpcDialog.show(766,"小梦",[[0,"那是我们星球的一种生物，正式自我介绍一下，我叫小梦，来自地球。"]],["地球！！！！？？？？"],[function():void
                     {
                        NpcDialog.show(406,"目灵兽",[[0,"地球？好像在哪听过这颗星球。"]],["就是发明赛尔们的星球！"],[function():void
                        {
                           DisplayObjectUtil.removeFromParent(mc);
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                           QuestManager.completeStep(questID,1);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            if(param1.stepId == 1)
            {
               this.initStep2();
            }
            if(param1.stepId == 2)
            {
               this.initStep3();
            }
            if(param1.stepId == 3)
            {
               this.initStep4();
            }
            if(param1.stepId == 4)
            {
               this.initStep5();
            }
         }
      }
      
      private function initStep5() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10232_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(questID,5);
         });
      }
      
      private function initStep4() : void
      {
         var mc:MovieClip = null;
         mc = _processor.resLib.getMovieClip("Mc10232_3");
         _map.content.addChild(mc);
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(mc);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
            ModuleManager.showAppModule("XiaoMengLetterPanel");
         },true);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep3() : void
      {
         var mc:MovieClip = null;
         mc = _processor.resLib.getMovieClip("Mc10232_2");
         _map.content.addChild(mc);
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"伊娃博士，情况怎么样？"]],["睡的好香"],[function():void
            {
               NpcDialog.show(2,"伊娃博士",[[0,"这是种我们从未见过的病毒。"]],["病毒？！"],[function():void
               {
                  NpcDialog.show(2,"伊娃博士",[[0,"能使精灵昏睡并且病原体并不是来自我们星球。所以暂时没有太好的办法。"]],["那么严重！"],[function():void
                  {
                     NpcDialog.show(400,"小赛尔",[[0,"太卑鄙了！是谁干的！"]],["一定要抓住他！"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(mc);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                        QuestManager.completeStep(questID,3);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep2() : void
      {
         var mc:MovieClip = null;
         mc = _processor.resLib.getMovieClip("Mc10232_1");
         _map.content.addChild(mc);
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(mc);
            SceneManager.changeScene(SceneType.LOBBY,10);
         },true);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.hideActor();
         if(isNeedToAccept() == true)
         {
            this.initAccept();
         }
         if(isNeedCompleteStep(1))
         {
            this.initStep1();
         }
         if(isNeedCompleteStep(2))
         {
            this.initStep2();
         }
         if(isNeedCompleteStep(3))
         {
            this.initStep3();
         }
         if(isNeedCompleteStep(4))
         {
            this.initStep4();
         }
      }
   }
}
