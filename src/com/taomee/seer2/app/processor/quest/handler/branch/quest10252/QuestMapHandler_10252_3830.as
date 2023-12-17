package com.taomee.seer2.app.processor.quest.handler.branch.quest10252
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class QuestMapHandler_10252_3830 extends QuestMapHandler
   {
       
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_10252_3830(param1:QuestProcessor)
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
         if(!QuestManager.isAccepted(10252))
         {
            this.initAccept();
         }
         if(QuestManager.isAccepted(10252) && !QuestManager.isComplete(10252) && QuestManager.isStepComplete(10252,1) == false)
         {
            this.initStep1();
         }
         else if(QuestManager.isStepComplete(10252,1) == true && QuestManager.isStepComplete(10252,2) == false)
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
         if(param1.questId == 10252)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(1032,"梵拉",[[0,"是的，经过如此漫长的恢复，我已经有足够的力量再次召唤我族守护兽——原魂兽，但是原魂兽的力量与无尽能源水晶的能量相互依存。"]],["可是不少能源已经被萨伦帝国抢走了呢！"],[function():void
         {
            NpcDialog.show(1032,"梵拉",[[0,"因此，我希望你能再次帮助我族人一起去夺回帝国军占有的水晶残片。  "]],["义不容辞！我一定帮忙。"],[function():void
            {
               NpcDialog.show(1032,"梵拉",[[0,"灵能通径去找里格队长吧，他一直在追查水晶残片的下落。我会在这段时间准备召唤仪式"]],["马上就去。"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                  QuestManager.completeStep(questID,1);
               }]);
            }]);
         }]);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1 == null || param1.questId == 10252 && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 1070;
            this._mouseHint.y = 470;
            _map.front.addChild(this._mouseHint);
         }
      }
   }
}
