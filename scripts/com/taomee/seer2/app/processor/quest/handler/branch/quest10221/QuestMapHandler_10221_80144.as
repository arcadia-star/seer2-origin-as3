package com.taomee.seer2.app.processor.quest.handler.branch.quest10221
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10221_80144 extends QuestMapHandler
   {
       
      
      private var _captain:Mobile;
      
      private var _mark:InProgressMark;
      
      public function QuestMapHandler_10221_80144(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10221) && QuestManager.isStepComplete(10221,2) == false)
         {
            this.initStep2();
         }
      }
      
      private function initStep2() : void
      {
         this._mark = new InProgressMark();
         _map.content.addChild(this._mark);
         this._mark.x = 326;
         this._mark.y = 179;
         DialogPanel.addCloseEventListener(this.onClose);
      }
      
      private function onClose(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         var params:String = event.params;
         if(params == "questEnd")
         {
            DialogPanel.removeCloseEventListener(this.onClose);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10221_1"),function():void
            {
               NpcDialog.show(6,"克拉克",[[0,"我有预感，事情不妙，我陪你去信奉广场看下吧！"]],["恩，这就去吧！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(10221,2);
               }]);
            },true,true);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80143);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DisplayUtil.removeForParent(this._mark);
         DialogPanel.removeCloseEventListener(this.onClose);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
