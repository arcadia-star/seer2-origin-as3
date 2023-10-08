package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class MapProcessor_5712 extends CopyMapProcessor
   {
       
      
      public function MapProcessor_5712(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         if(QuestManager.isAccepted(10181) && QuestManager.isStepComplete(10181,2) && !QuestManager.isComplete(10181))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
            QuestManager.completeStep(10181,3);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10181_01"),this.showSaveMovie,false);
         }
      }
      
      private function showSaveMovie() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10181_1"),this.endMission,true,true);
      }
      
      private function endMission() : void
      {
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
