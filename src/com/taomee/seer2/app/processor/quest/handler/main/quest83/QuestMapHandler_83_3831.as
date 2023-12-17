package com.taomee.seer2.app.processor.quest.handler.main.quest83
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class QuestMapHandler_83_3831 extends QuestMapHandler
   {
       
      
      private var _door:MovieClip;
      
      public function QuestMapHandler_83_3831(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,7) && !QuestManager.isStepComplete(questID,8))
         {
            this.quest7();
         }
      }
      
      private function quest7() : void
      {
         (_map.front["quest83"] as MovieClip).visible = true;
         this._door = _map.content["door"];
         this._door.addEventListener(MouseEvent.CLICK,this.onDoor);
      }
      
      private function onDoor(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         SwapManager.swapItem(3422,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            StatisticsManager.newSendNovice("2014系统","经验之门","正常进入经验之门");
            SceneManager.changeScene(SceneType.COPY,80342);
         });
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
   }
}
