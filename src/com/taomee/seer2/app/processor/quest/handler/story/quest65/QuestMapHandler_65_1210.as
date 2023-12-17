package com.taomee.seer2.app.processor.quest.handler.story.quest65
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_65_1210 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_65_1210(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "65_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("65_0"),function():void
            {
               NpcDialog.show(11,"多罗",[[0,"匹喏曹说的话到底可不可信呢？"]],["你们觉得呢？"],[function():void
               {
                  NpcDialog.show(10,"巴蒂",[[0,"不要相信他的话，他一直都是一个说谎的人。"]],["有道理"],[function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"我想，我们还是应该找到匹喏曹问问具体的情况。"]],["嗯，不错"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                        QuestManager.accept(_quest.id);
                     }]);
                  }]);
               }]);
            },true,false,2);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         SceneManager.changeScene(SceneType.LOBBY,1220);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
      }
   }
}
