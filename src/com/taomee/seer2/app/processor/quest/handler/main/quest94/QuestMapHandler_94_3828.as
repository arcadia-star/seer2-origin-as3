package com.taomee.seer2.app.processor.quest.handler.main.quest94
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_94_3828 extends QuestMapHandler
   {
       
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_94_3828(param1:QuestProcessor)
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
         if(param1.questId == 94)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(1016,"里格",[[0,"有一句忠告要给你：现在的你已经成了萨伦的眼中钉，凡是还是小心为好，近期不要在超能氏族多逗留。"]],["怎么？又有萨伦的手下来骚扰你们？"],[function():void
         {
            NpcDialog.show(1016,"里格",[[0,"不，只是我听氏族的其他人提到，总有一个身穿斗篷的神秘人出现在这里打听关于你的消息。"]],["咳咳……也许是崇拜我吧？"],[function():void
            {
               NpcDialog.show(1016,"里格",[[0,"即使恢复平静了也不能掉以轻心！在不知道他的来意之前还是小心为上，回你的飞船上去吧。"]],["没关系，我早已经见识过萨伦的狡诈了。"],[function():void
               {
                  NpcDialog.show(1016,"里格",[[0,"神秘人不愿透露自己的身份必有蹊跷，你不怕这是阴谋吗？"]],["那我就先相信你一次。"],[function():void
                  {
                     NpcDialog.show(1016,"里格",[[0,"既然你坚持的话，我愿支持你。去问问其他人有没有关于神秘人的消息吧."]],["（去找瓦力大叔问问）"],[function():void
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
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 800;
         this._mouseHint.y = 250;
         _map.front.addChild(this._mouseHint);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         super.processMapDispose();
      }
   }
}
