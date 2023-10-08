package com.taomee.seer2.app.processor.quest.handler.branch.quest10249
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class QuestMapHandler_10249_1240 extends QuestMapHandler
   {
      
      public static var haveStep:Boolean = false;
       
      
      private var _npc324:Mobile;
      
      private var _mark:AcceptableMark;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_10249_1240(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(10249))
         {
            this.initAccept();
         }
         if(QuestManager.isAccepted(10249) && !QuestManager.isComplete(10249) && QuestManager.isStepComplete(10249,1) == false)
         {
            this.initStep1();
         }
         else if(QuestManager.isStepComplete(10249,1) == true && QuestManager.isStepComplete(10249,2) == false)
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
         if(param1.questId == 10249)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         this._npc324 = MobileManager.getMobile(324,MobileType.NPC);
         this._mark = new AcceptableMark();
         this._npc324.addChild(this._mark);
         this._mark.y = -130;
         NpcDialog.show(324,"白雪公主",[[0,"没错，不过他什么也没有问，只顾低头看着什么，嘴里念念有词，随后就离开了。"]],["我似乎知道来的是谁了。"],[function():void
         {
            NpcDialog.show(400,"赛尔",[[0,"奇怪的机器人应该是斯坦因博士吧。  "]],["公主，他往哪里走了？"],[function():void
            {
               NpcDialog.show(324,"白雪公主",[[0,"他去了后花园的方向，去那里看看吧。" + ActorManager.actorInfo.nick + "，如果有蚀魂兽的消息，一定要告诉我哦！"]],["公主请放心！我这就去。"],[function():void
               {
                  if(_mark != null)
                  {
                     DisplayObjectUtil.removeFromParent(_mark);
                  }
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                  QuestManager.completeStep(questID,1);
               }]);
            }]);
         }]);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1 == null || param1.questId == 10249 && param1.stepId == 1)
         {
            haveStep = true;
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 251;
            this._mouseHint.y = 519;
            _map.front.addChild(this._mouseHint);
         }
      }
   }
}
