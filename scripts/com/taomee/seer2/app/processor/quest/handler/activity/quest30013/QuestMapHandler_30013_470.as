package com.taomee.seer2.app.processor.quest.handler.activity.quest30013
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30013_470 extends QuestMapHandler
   {
       
      
      private var fightEet:MovieClip;
      
      public function QuestMapHandler_30013_470(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.initNpc();
         }
      }
      
      private function initNpc() : void
      {
         this.fightEet = _processor.resLib.getMovieClip("FightEetMC");
         _map.front.addChild(this.fightEet);
         this.fightEet.buttonMode = true;
         this.fightEet.addEventListener(MouseEvent.CLICK,this.showDia);
      }
      
      private function showDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(492,"战斗伊特",[[0,"喂！怎么会有机器保姆？给我去弄点吃的来！不然我扁你！"]],["我？机械保姆？"],[function():void
         {
            NpcDialog.show(492,"战斗伊特",[[0,"你！你给我少废话！想挑战找我啊！"]],["准备挑战","我一会再来"],[function():void
            {
               playFullMC();
            }]);
         }]);
      }
      
      private function playFullMC() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30013_0"),function():void
         {
            NpcDialog.show(400,"我",[[0,"可……恶！！！！！咦……有事？会是什么事呢？难道……伊特家族将要面临内讧？"]],["走着瞧吧……我绝不会让它发生！"],[function():void
            {
               DisplayUtil.removeForParent(fightEet);
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(30013,2);
            }]);
         });
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 30013)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
   }
}
