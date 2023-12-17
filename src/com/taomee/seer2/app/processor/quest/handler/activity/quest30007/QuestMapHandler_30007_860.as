package com.taomee.seer2.app.processor.quest.handler.activity.quest30007
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30007_860 extends QuestMapHandler
   {
       
      
      private var npcStep2:MovieClip;
      
      private var npc2Id:int = 479;
      
      private var stanYin:MovieClip;
      
      private var stanId:int = 106;
      
      private var crowMc:MovieClip;
      
      public function QuestMapHandler_30007_860(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
            {
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.battleWin();
               }
               else
               {
                  this.battleFail();
               }
            }
            if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
            {
               if(!this.stanYin)
               {
                  this.initStep3();
               }
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.stanyinFail();
               }
               else
               {
                  this.stanyinWin();
               }
            }
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.initStep2();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this.initStep3();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isStepComplete(_quest.id,4))
         {
            this.initStep4();
         }
      }
      
      private function stanyinFail() : void
      {
         NpcDialog.show(this.stanId,"斯坦因",[[1,"呵呵……后会有期！雷神！（记得要用雷电射击湖畔，召唤出真正的雷神！）"]],["……烟消云不散的家伙！"],[function():void
         {
            DisplayObjectUtil.removeFromParent(stanYin);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,completeStep3);
            QuestManager.completeStep(_quest.id,3);
         }]);
      }
      
      private function stanyinWin() : void
      {
         NpcDialog.show(this.stanId,"斯坦因",[[1,"没人能阻止我对精灵的热爱！没有！没有！啊哈哈哈哈！"]],["好恐怖……他怎么时好时坏啊？（继续对战）"],[function():void
         {
            FightManager.startFightWithWild(89);
         }]);
      }
      
      private function initStep2() : void
      {
         this.npcStep2 = _processor.resLib.getMovieClip("NpcStep2");
         _map.content.addChild(this.npcStep2);
         this.npcStep2.buttonMode = true;
         this.npcStep2.addEventListener(MouseEvent.CLICK,this.showNpcDia2);
      }
      
      protected function showNpcDia2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(479,"佐格和艾里逊",[[0,"我们最英俊！我们最潇洒！我们可是赛尔号的……明星……坏蛋！"]],["傻爆了……"],[function():void
         {
            NpcDialog.show(479,"佐格和艾里逊",[[0,"谁！谁在说话！阻拦我们的只有一个下场，那就是………"]],["话不投机半句多！开战吧！"],[function():void
            {
               FightManager.startFightBinaryWild(88);
            }]);
         }]);
      }
      
      private function battleFail() : void
      {
         NpcDialog.show(this.npc2Id,"佐格和艾里逊",[[0,"我们好威武！我们好壮观！我们好……"]],["（你们好恶心……）继续对战！"],[function():void
         {
            FightManager.startFightBinaryWild(88);
         }]);
      }
      
      private function battleWin() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30007_3"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,completeStep2);
            QuestManager.completeStep(_quest.id,2);
         });
      }
      
      private function completeStep2(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 2)
         {
            this.npcStep2.removeEventListener(MouseEvent.CLICK,this.showNpcDia2);
            _map.content.removeChild(this.npcStep2);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep2);
            this.initStep3();
         }
      }
      
      private function initStep3() : void
      {
         this.stanYin = _processor.resLib.getMovieClip("StanYin");
         this.stanYin.buttonMode = true;
         _map.front.addChild(this.stanYin);
         this.stanYin.addEventListener(MouseEvent.CLICK,this.stanYinBattle);
      }
      
      private function stanYinBattle(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(89);
      }
      
      private function completeStep3(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 3)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep3);
            this.initStep4();
         }
      }
      
      private function initStep4() : void
      {
         this.crowMc = _processor.resLib.getMovieClip("Crow");
         this.crowMc.addEventListener(MouseEvent.CLICK,this.clickCrow);
         this.crowMc.buttonMode = true;
         _map.content.addChild(this.crowMc);
      }
      
      private function clickCrow(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(480,"乌鸦",[[0,"雷神守护着赫尔卡星的一寸一土……雷神你何时才会降临……"]],["这是赛尔号的世界……"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,completeQuest);
            QuestManager.completeStep(_quest.id,4);
         }]);
      }
      
      private function completeQuest(param1:QuestEvent) : void
      {
         if(param1.questId == 30007)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.completeQuest);
            this.crowMc.removeEventListener(MouseEvent.CLICK,this.clickCrow);
            _map.content.removeChild(this.crowMc);
            SceneManager.changeScene(SceneType.LOBBY,133);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.npcStep2)
         {
            this.npcStep2.removeEventListener(MouseEvent.CLICK,this.showNpcDia2);
            if(_map.content.contains(this.npcStep2))
            {
               _map.content.removeChild(this.npcStep2);
            }
         }
         if(this.stanYin)
         {
            this.stanYin.removeEventListener(MouseEvent.CLICK,this.stanYinBattle);
            if(_map.front.contains(this.stanYin))
            {
               _map.front.removeChild(this.stanYin);
            }
         }
         if(this.crowMc)
         {
            this.crowMc.removeEventListener(MouseEvent.CLICK,this.clickCrow);
            if(_map.content.contains(this.crowMc))
            {
               _map.content.removeChild(this.crowMc);
            }
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep2);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep3);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.completeQuest);
         super.processMapDispose();
      }
   }
}
