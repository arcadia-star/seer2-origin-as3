package com.taomee.seer2.app.processor.quest.handler.main.quest3
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_3_100 extends QuestMapHandler
   {
       
      
      private var _sleepCount:int = 0;
      
      private var _sleepNpc:Mobile;
      
      private var mark:InProgressMark;
      
      public function QuestMapHandler_3_100(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompete(6))
         {
            if(!_quest.isStepCompete(7))
            {
               this.processStep7();
            }
            else if(!_quest.isStepCompete(8))
            {
               this.processStep8();
            }
         }
      }
      
      private function processStep7() : void
      {
         this._sleepCount = 0;
         this._sleepNpc = MobileManager.getMobile(18,MobileType.NPC);
         this.mark = new InProgressMark();
         this.mark.y -= 80;
         this._sleepNpc.addChild(this.mark);
         this._sleepNpc.addEventListener(MouseEvent.CLICK,this.onNpcSleepClick,false,int.MAX_VALUE);
      }
      
      private function onNpcSleepClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         evt.stopImmediatePropagation();
         DisplayObjectUtil.removeFromParent(this.mark);
         this._sleepNpc.removeEventListener(MouseEvent.CLICK,this.onNpcSleepClick,false);
         NpcDialog.show(18,"斯力普",[[0,"啊哟喂！有没有搞错啊！伦家在比赛啊！睡神大赛就被你个家伙这么掺和了！说说说……找我什么事……"]],["实在是不好意思……就是……就是关于目灵兽的事情"],[function():void
         {
            NpcDialog.show(18,"斯力普",[[0,"回答：舒尔！回答完毕，你可以走了我要继续睡觉！Zzzzzz……"]],["实在是不好意思"],[function():void
            {
               _sleepNpc.action = "睡觉";
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestAnimation("3/quest3Animation3"),1,[[1,0]],function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"又是舒尔……咦？巴蒂和多罗怎么还没回来！快去维拉这里看看，难道他们遇到麻烦了？"]],["（维拉在水仙草界）"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep7);
                     QuestManager.completeStep(_quest.id,7);
                  }]);
               });
            }]);
         }]);
      }
      
      private function onCompleteStep7(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep7);
            this.processStep8();
         }
      }
      
      private function processStep8() : void
      {
         _processor.showMouseHintAt(-50,322);
      }
      
      override public function processMapDispose() : void
      {
         if(this._sleepNpc != null)
         {
            this._sleepNpc.removeEventListener(MouseEvent.CLICK,this.onNpcSleepClick,false);
            DisplayObjectUtil.removeAllChildren(this._sleepNpc);
            this._sleepNpc = null;
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep7);
         super.processMapDispose();
      }
   }
}
