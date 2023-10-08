package com.taomee.seer2.app.processor.quest.handler.branch.quest10254
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class QuestMapHandler_10254_3830 extends QuestMapHandler
   {
       
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_10254_3830(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DisplayObjectUtil.removeFromParent(this._mouseHint);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(10254))
         {
            this.initAccept();
         }
         if(QuestManager.isAccepted(10254) && !QuestManager.isComplete(10254) && QuestManager.isStepComplete(10254,1) == false)
         {
            this.initStep1();
         }
         else if(QuestManager.isStepComplete(10254,1) == true && QuestManager.isStepComplete(10254,2) == false)
         {
            this.onStep(null);
         }
      }
      
      private function initAccept() : void
      {
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 10254)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(3011,"原魂兽",[[0,ActorManager.actorInfo.nick + "，如果我无法控制住自己，请你一定要击败我。"]],["原魂兽？？"],[function():void
         {
            NpcDialog.show(3011,"原魂兽",[[0,"我能听到这个氏族发生的所有事，即使我不在这里。"]],["那我们说的你都能听到啦。"],[function():void
            {
               NpcDialog.show(1032,"梵拉",[[0,"对了，只要击败原魂兽就可以了！"]],["你说什么？超能氏族要击败自己的守护兽？"],[function():void
               {
                  NpcDialog.show(1032,"梵拉",[[0,"原魂兽，你可以帮助我们进入你的内心吗？让我们直面你的邪恶心志，只要直接战胜它就能够帮你恢复正常了！"]],["⊙﹏⊙b，原来是这么回事。好办法呀！"],[function():void
                  {
                     NpcDialog.show(3011,"原魂兽",[[0,"这一点我可以做到，请到能量之源来找我吧，我感到自己正在被邪恶心志所侵蚀，能保持清醒的时间不多了。"]],["马上就到。"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                        QuestManager.completeStep(questID,1);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1 == null || param1.questId == 10254 && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 157;
            this._mouseHint.y = 520;
            _map.front.addChild(this._mouseHint);
         }
      }
   }
}
