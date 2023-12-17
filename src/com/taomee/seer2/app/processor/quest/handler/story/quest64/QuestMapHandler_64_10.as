package com.taomee.seer2.app.processor.quest.handler.story.quest64
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
   import flash.display.MovieClip;
   
   public class QuestMapHandler_64_10 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_64_10(param1:QuestProcessor)
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
         if((event.content as DialogPanelEventData).params == "64_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            NpcDialog.show(11,"多罗",[[0,"时刻准备着，船长大人，有何吩咐啊？"]],["听我慢慢道来"],[function():void
            {
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("64_0"),3,[[1,0]],function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"看来任务艰巨啊，我们不得不深入南半球，寻找奎尔斯的下落了。"]],["准备好出发吧"],[function():void
                  {
                     NpcDialog.show(10,"巴蒂",[[0,"嗯，不错，不过南半球据说险境重重，我们路上一定得小心。"]],["谨慎小心"],[function():void
                     {
                        NpcDialog.show(1,"辛迪",[[0,"是的，巴蒂说得对，路上你们要小心，遇到什么情况请及时与飞船联系，第七小分队准备出发吧！"]],["出发！出发！"],[function():void
                        {
                           QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                           QuestManager.accept(_quest.id);
                        }]);
                     }]);
                  }]);
               });
            }]);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         SceneManager.changeScene(SceneType.LOBBY,1200);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
      }
   }
}
