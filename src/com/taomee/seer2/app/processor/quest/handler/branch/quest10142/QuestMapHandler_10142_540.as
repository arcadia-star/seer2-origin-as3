package com.taomee.seer2.app.processor.quest.handler.branch.quest10142
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10142_540 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10142_540(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 5;
         _y = 150;
         _x = 668;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(760,177);
      }
      
      override protected function getAward() : void
      {
         this.playFullMovie();
      }
      
      private function playFullMovie() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10142_1.swf"),function():void
         {
            DisplayUtil.removeForParent(_candleMc);
            if(Boolean(_map) && Boolean(_map.content["mikaNpc"]))
            {
               (_map.content["mikaNpc"] as MovieClip).visible = true;
            }
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(_quest.id,1);
         });
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(Boolean(_map) && Boolean(_map.content["mikaNpc"]))
         {
            (_map.content["mikaNpc"] as MovieClip).visible = true;
            (_map.content["mikaNpc"] as MovieClip).buttonMode = true;
            (_map.content["mikaNpc"] as MovieClip).filters = [];
            (_map.content["mikaNpc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.mikaFight);
         }
      }
      
      private function mikaFight(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(236);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
