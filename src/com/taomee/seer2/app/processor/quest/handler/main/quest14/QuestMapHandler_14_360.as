package com.taomee.seer2.app.processor.quest.handler.main.quest14
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_14_360 extends QuestMapHandler
   {
       
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_14_360(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this._mc = _map.content["teapot"];
            this._mc.gotoAndStop(2);
            this._mc.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("14_1"),function():void
         {
            QuestManager.completeStep(_quest.id,4);
            if(_mc)
            {
               _mc.removeEventListener(MouseEvent.CLICK,onClick);
            }
         });
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc)
         {
            this._mc.removeEventListener(MouseEvent.CLICK,this.onClick);
            this._mc = null;
         }
      }
   }
}
