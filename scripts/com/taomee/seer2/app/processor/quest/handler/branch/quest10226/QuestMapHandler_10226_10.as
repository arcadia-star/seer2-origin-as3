package com.taomee.seer2.app.processor.quest.handler.branch.quest10226
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10226_10 extends QuestMapHandler
   {
      
      public static var haveBattle:Boolean = true;
       
      
      private var _mc1:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10226_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(!haveBattle)
         {
            return;
         }
         super.processMapComplete();
         if(QuestManager.isAccepted(10226) && QuestManager.isStepComplete(10226,1) == false)
         {
            _map.content.visible = false;
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.front.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,2,this._mc1.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mack);
            DisplayUtil.removeForParent(_mc1);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(10226,1);
         },true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,304);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
