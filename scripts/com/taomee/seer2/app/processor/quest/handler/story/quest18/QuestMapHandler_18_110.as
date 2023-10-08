package com.taomee.seer2.app.processor.quest.handler.story.quest18
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_18_110 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_18_110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) == false && QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         if(event.params == "18_0")
         {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("18_0"),3,[[1,0]],function():void
            {
               NpcDialog.show(16,"神目酋长",[[1,"（笑眯眯）"]],["酋长，其实你不说，我也会去的！"],[function():void
               {
                  NpcDialog.show(16,"神目酋长",[[1,"咳！那么，冰沁氏族的事情就拜托了！"]],["（也！终于有机会去新地图了！）"],[function():void
                  {
                     NpcDialog.show(10,"巴蒂",[[4,"贸然前去一定会碰到意想不到的问题，我们先去请示一下辛迪船长吧！"]],["（去船长室找辛迪船长！）"],[function():void
                     {
                        QuestManager.accept(_quest.id);
                     }]);
                  }]);
               }]);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
