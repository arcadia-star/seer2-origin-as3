package com.taomee.seer2.app.processor.quest.handler.main.quest10
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_10;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10_173 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10_173(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         LobbyScene(SceneManager.active).hideToolbar();
         if(!_quest.isStepCompete(1))
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10_1"),function():void
            {
               QuestProcessor_10(_processor).hasEnterDream = true;
               SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         LobbyScene(SceneManager.active).showToolbar();
         super.processMapDispose();
      }
   }
}
