package com.taomee.seer2.app.processor.quest.handler.branch.quest10211
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10211_80077 extends QuestMapHandler
   {
       
      
      private var mc1:MovieClip;
      
      private var accept:AcceptableMark;
      
      private var mc2:MovieClip;
      
      private var game:com.taomee.seer2.app.processor.quest.handler.branch.quest10211.QuestMap_10211_80077_game;
      
      public function QuestMapHandler_10211_80077(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10211) && QuestManager.isStepComplete(10211,1) == false)
         {
            this.initStep1();
         }
         else if(QuestManager.isStepComplete(10211,1) == true && QuestManager.isStepComplete(10211,2) == false)
         {
            this.initStep2();
         }
         else if(QuestManager.isStepComplete(10211,2) == true && QuestManager.isStepComplete(10211,3) == false)
         {
            this.initStep3();
         }
      }
      
      private function initStep1() : void
      {
         this.mc1 = _processor.resLib.getMovieClip("mc1");
         _map.content.addChild(this.mc1);
         if(this.accept == null)
         {
            this.accept = new AcceptableMark();
         }
         _map.content.addChild(this.accept);
         this.accept.x = 606;
         this.accept.y = 298;
         this.mc1.buttonMode = true;
         this.mc1.addEventListener(MouseEvent.CLICK,this.onMc1);
      }
      
      private function onMc1(param1:MouseEvent = null) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(10,"巴蒂",[[0,"我前面明明已经抓到路奇了，可是多罗怎么会消失了？"]],["你是不是产生幻觉了？"],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"难道我们产生幻觉了？之前倒是真的闻到一股奇怪的味道。"]],["奇怪的味道？可能又是魔域四将布下的陷阱"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"太可恶了，我们要怎么才能找到多罗呢？"]],["多罗，你到底在哪里呀？"],[function():void
               {
                  NpcDialog.show(10,"巴蒂",[[0,"别急，先看看多罗消失的地方有没有什么线索吧！"]],[" 好的！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1);
                     QuestManager.completeStep(10211,1);
                     DisplayObjectUtil.removeFromParent(accept);
                     if(mc1)
                     {
                        mc1.removeEventListener(MouseEvent.CLICK,onMc1);
                        DisplayObjectUtil.removeFromParent(mc1);
                     }
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStep1(param1:QuestEvent) : void
      {
         if(param1.questId == 10211 && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1);
            this.initStep2();
         }
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10211_1"),function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"我们去看看这两块石头有什么问题吧。"]],[" 好的!"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2);
               QuestManager.completeStep(10211,2);
            }]);
         },true,true);
      }
      
      private function onStep2(param1:QuestEvent) : void
      {
         if(param1.questId == 10211 && param1.stepId == 2)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2);
            this.initStep3();
         }
      }
      
      private function initStep3() : void
      {
         if(this.accept == null)
         {
            this.accept = new AcceptableMark();
         }
         _map.content.addChild(this.accept);
         this.accept.x = 372 + 200 + 90;
         this.accept.y = 325 - 20;
         this.mc2 = _processor.resLib.getMovieClip("mc2");
         _map.content.addChild(this.mc2);
         this.mc2.buttonMode = true;
         this.mc2.addEventListener(MouseEvent.CLICK,this.onMc2);
      }
      
      private function onMc2(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10211_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3);
            game = new com.taomee.seer2.app.processor.quest.handler.branch.quest10211.QuestMap_10211_80077_game(_processor.resLib.getMovieClip("game"));
            _map.front.addChild(game);
         },true,true);
      }
      
      private function onStep3(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3);
         if(this.game)
         {
            DisplayObjectUtil.removeFromParent(this.game);
            this.game = null;
         }
         SceneManager.changeScene(SceneType.LOBBY,80087);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this.mc1)
         {
            this.mc1.removeEventListener(MouseEvent.CLICK,this.onMc1);
            DisplayObjectUtil.removeFromParent(this.mc1);
         }
         if(this.mc2)
         {
            this.mc2.removeEventListener(MouseEvent.CLICK,this.onMc2);
            DisplayObjectUtil.removeFromParent(this.mc2);
         }
         if(this.accept)
         {
            DisplayObjectUtil.removeFromParent(this.accept);
         }
         if(this.game)
         {
            DisplayObjectUtil.removeFromParent(this.game);
            this.game = null;
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3);
      }
   }
}
