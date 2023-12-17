package com.taomee.seer2.app.processor.quest.handler.main.quest95
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_95_30 extends QuestMapHandler
   {
       
      
      private var _cartoon:MovieClip;
      
      public function QuestMapHandler_95_30(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(questID))
         {
            RightToolbarConter.instance.hide();
            this.initAccept();
         }
         if(QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false)
         {
            RightToolbarConter.instance.hide();
            if(QuestManager.isStepComplete(questID,1) == false)
            {
               this.initStep1();
            }
            else if(QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
            {
               this.onStep(null);
            }
         }
         if(QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initAccept() : void
      {
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 95)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("cindysMemory/yingzhilin"),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            _cartoon = mc;
            _cartoon.x = 0;
            _cartoon.y = 0;
            LayerManager.topLayer.addChild(_cartoon);
            NpcDialog.show(400,"赛尔",[[0,"影之誓言？这是什么意思？它没有告诉我要干什么呀。"]],["聪明的娜威拉帮我看看吧~"],[function():void
            {
               NpcDialog.show(7,"娜威拉",[[0,"看起来这是一份加入某个组织的誓言呢，我还真没听说过这样的组织。"]],["我还是去问问伊万吧。"],[function():void
               {
                  DisplayObjectUtil.removeFromParent(_cartoon);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
                  QuestManager.completeStep(questID,1);
               }]);
            }]);
         });
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         SceneManager.changeScene(SceneType.LOBBY,3847);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         super.processMapDispose();
      }
   }
}
