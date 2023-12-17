package com.taomee.seer2.app.processor.quest.handler.main.quest11
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_11_20 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_11_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
         if(!QuestManager.isComplete(11))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         }
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.questId == 11)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
            _loc2_ = new Object();
            _loc2_.index = 2;
            ModuleManager.toggleModule(URLUtil.getAppModule("QuestSelectRewardPanel"),"正在打开主线任务奖励面板...",_loc2_);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var evt:DialogCloseEvent = param1;
         var params:String = evt.params;
         if(params == "playAnimation_11")
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("11_0"),4,[[1,0]],function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[2,"可恶！决不能让他们的奸计得逞！我这就带着第七小分队去水脉氏族巡逻！"]],["第七小队一定不负所望！"],[function():void
               {
                  QuestManager.accept(_quest.id);
               }]);
            });
         }
      }
   }
}
