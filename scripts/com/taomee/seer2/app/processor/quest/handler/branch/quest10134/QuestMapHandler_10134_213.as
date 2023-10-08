package com.taomee.seer2.app.processor.quest.handler.branch.quest10134
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10134_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10134_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:Mobile = null;
         super.processMapComplete();
         if(QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID) && QuestManager.isComplete(10132) && QuestManager.isComplete(10133))
         {
            _loc1_ = MobileManager.getMobile(27,MobileType.NPC);
            _loc1_.removeOverHeadMark();
            _loc1_.addOverHeadMark(new AcceptableMark());
            _loc1_.addEventListener(MouseEvent.CLICK,this.showEndDia,false,1000);
         }
      }
      
      private function showEndDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var target:Mobile = event.target as Mobile;
         target.removeEventListener(MouseEvent.CLICK,this.showEndDia);
         target.removeOverHeadMark();
         NpcDialog.show(27,"占卜婆婆",[[1,"呵呵呵，小赛尔怎么又有空来看我这个老太婆了~"]],["这个…还是很难接受他就是玛雅公主的事实…"],[function():void
         {
            NpcDialog.show(27,"占卜婆婆",[[1,"是有什么事情吧？"]],["你就是伊莉莎！"],[function():void
            {
               NpcDialog.show(27,"占卜婆婆",[[1,"呵呵，有缘人终于诞生了！等时机成熟时，我自然会告诉你下一步该怎么做~"]],["目灵兽现在在哪？"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[1,"这个得让你自己去找寻，如果你有足够的勇气和耐心，预言中他会与你们并肩作战的!"]],["好期待啊！ "],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                     QuestManager.completeStep(questID,3);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10134)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
   }
}
