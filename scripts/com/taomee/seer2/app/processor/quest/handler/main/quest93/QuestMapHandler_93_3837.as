package com.taomee.seer2.app.processor.quest.handler.main.quest93
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_93_3837 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _npc1020:Mobile;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_93_3837(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._npc1020 = MobileManager.getMobile(1020,MobileType.NPC);
         if(QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
         else
         {
            RightToolbarConter.instance.hide();
            ActorManager.getActor().hide();
            ActorManager.getActor().blockFollowingPet = true;
            ActorManager.getActor().blockNoNo = true;
            if(QuestManager.isStepComplete(93,1) && !QuestManager.isStepComplete(93,2))
            {
               this._npc1020.visible = false;
               this._mc1 = _processor.resLib.getMovieClip("Mc93_0");
               _map.front.addChild(this._mc1);
               this._mc1.gotoAndStop(1);
               MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_mc1);
                  _npc1020.visible = true;
                  QuestManager.completeStep(questID,2);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,initStep2);
               },true);
            }
            else if(QuestManager.isStepComplete(93,1) && QuestManager.isStepComplete(93,2))
            {
               this.initStep2(null);
            }
         }
      }
      
      private function initStep2(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.initStep2);
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 224;
         this._mouseHint.y = 321;
         _map.front.addChild(this._mouseHint);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
         super.processMapDispose();
      }
   }
}
