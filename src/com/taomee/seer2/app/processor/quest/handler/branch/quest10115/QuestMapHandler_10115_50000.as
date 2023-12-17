package com.taomee.seer2.app.processor.quest.handler.branch.quest10115
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10115_50000 extends DreamQuest50000
   {
       
      
      private var devil:MovieClip;
      
      public function QuestMapHandler_10115_50000(param1:QuestProcessor)
      {
         super(param1);
         this.toSceneId = 126;
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isInTime)
         {
            return;
         }
         if(!QuestManager.isAccepted(_quest.id))
         {
            if(seer)
            {
               seer.visible = false;
            }
            this.playFull();
         }
         else if(seer)
         {
            seer.visible = true;
         }
      }
      
      private function playFull() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10115_0"),function():void
         {
            devil = _processor.resLib.getMovieClip("Devil");
            devil.buttonMode = true;
            _map.content.addChild(devil);
            devil.addEventListener(MouseEvent.CLICK,playSleep);
         });
      }
      
      private function playSleep(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         _map.content.removeChild(this.devil);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10115_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
            QuestManager.accept(_quest.id);
         });
      }
      
      override public function processMapDispose() : void
      {
         if(this.devil)
         {
            this.devil.removeEventListener(MouseEvent.CLICK,this.playSleep);
         }
         super.processMapDispose();
      }
   }
}
