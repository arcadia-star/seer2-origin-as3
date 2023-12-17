package com.taomee.seer2.app.processor.quest.handler.activity.quest30050
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30050_142 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      public function QuestMapHandler_30050_142(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(30050) && QuestManager.isStepComplete(30050,1) == false)
         {
            this.startQuest1();
         }
      }
      
      private function startQuest1() : void
      {
         Quest30050Content.closeMapPro();
         ActorManager.getActor().x = 638;
         ActorManager.getActor().y = 312;
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.front.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,2,this._mc1.totalFrames,function():void
         {
            ActorManager.getActor().startTransform(16);
            _processor.showMouseHintAt(364,287);
            _mc1.addEventListener(MouseEvent.CLICK,onNpc);
         },true);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         _processor.hideMouseClickHint();
         NpcDialog.show(626,"晨璨",[[0,"哈哈哈，可爱的布尔，快来帮我锤锤腿，不然我用锥子扎你哟~"]],["吼吼吼~"],[function():void
         {
            NpcDialog.show(201,"布鲁托",[[2,"哦~"]],["…………"],[function():void
            {
               NpcDialog.show(626,"晨璨",[[0,"不错，真听话。走，我带你去找我的好朋友玩。跟着我别丢了~"]],["快走，不然用锥子扎你"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30050_2"),function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                     QuestManager.completeStep(30050,1);
                  },true,false,2);
               }]);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,141);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         Quest30050Content.openMapPro();
         DisplayUtil.removeForParent(this._mc1);
         ActorManager.getActor().stopTransform();
         if(_processor)
         {
            _processor.hideMouseClickHint();
         }
         super.processMapDispose();
      }
   }
}
