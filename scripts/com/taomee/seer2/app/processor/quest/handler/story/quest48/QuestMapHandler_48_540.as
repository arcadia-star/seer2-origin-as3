package com.taomee.seer2.app.processor.quest.handler.story.quest48
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_48_540 extends QuestMapHandler
   {
       
      
      private var allMc:MovieClip;
      
      private var JamesMC:MovieClip;
      
      public function QuestMapHandler_48_540(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            MonsterManager.hideAllMonster();
            this.allMc = _processor.resLib.getMovieClip("allMc");
            this.allMc.gotoAndStop(1);
            _map.content.addChild(this.allMc);
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               this.battleResult();
            }
            else
            {
               this.JamesMC = this.allMc["james"];
               this.JamesMC.buttonMode = true;
               this.JamesMC.addEventListener(MouseEvent.CLICK,this.npcClick);
            }
         }
      }
      
      private function battleResult() : void
      {
         NpcDialog.show(32,"萨伦帝国小兵",[["0","这地方真晦气！算了，我可不想莫名奇妙被冰冻住——今天就饶了你们了！！再见！！"]],["=。=……"],[function():void
         {
            MovieClipUtil.playMc(allMc,"armStart","armEnd",function():void
            {
               NpcDialog.show(114,"蒂芙伦",[["0","它叫詹姆斯，是当年冰后的得力助手派瑞的精灵……看来，它也没有放弃努力。"]],["那些得力助手都在哪儿？能不能救出来呢？"],[function():void
               {
                  NpcDialog.show(486,"詹姆斯",[["0","唔——~~~~(-_-)~~~~ ！！"]],["你没办法开口说话啊，那可怎么办……"],[function():void
                  {
                     MovieClipUtil.playMc(allMc,"armEnd","JamesEnd",function():void
                     {
                        NpcDialog.show(114,"蒂芙伦",[["0","看来它想让我们去冰之监狱啊……"]],["那就去冰之监狱看看！"],[function():void
                        {
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep1);
                           QuestManager.completeStep(_quest.id,1);
                        }]);
                     });
                  }]);
               }]);
            });
         }]);
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 1)
         {
            DisplayUtil.removeForParent(this.allMc);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            SceneManager.changeScene(SceneType.LOBBY,570,290,439);
         }
      }
      
      private function npcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.JamesMC.removeEventListener(MouseEvent.CLICK,this.npcClick);
         NpcDialog.show(486,"詹姆斯",[["2","嗷嗷嗷嗷嗷嗷——！"]],["又是萨伦帝国！连一只小精灵都不放过！"],[function():void
         {
            NpcDialog.show(32,"萨伦帝国小兵",[["0","是这家伙先冲上来拿头撞我！！我还手还不行么！"]],["=。=……我看不行……"],[function():void
            {
               FightManager.startFightWithWild(109);
            }]);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         if(this.allMc)
         {
            this.allMc.removeEventListener(MouseEvent.CLICK,this.npcClick);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
         super.processMapDispose();
      }
   }
}
