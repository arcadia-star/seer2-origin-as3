package com.taomee.seer2.app.processor.quest.handler.branch.quest10137
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class QuestMapHandler_10137_211 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10137_211(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.missOrSuccess();
         }
      }
      
      private function missOrSuccess() : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         Connection.send(CommandSet.RANDOM_EVENT_1140,34,0);
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         var data:IDataInput;
         var index:uint;
         var id:uint;
         var evt:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         data = evt.message.getRawDataCopy();
         index = uint(data.readUnsignedInt());
         id = uint(data.readUnsignedInt());
         if(id == 0)
         {
            NpcDialog.show(418,"乌达",[[0,"抱歉！我想我不能成为占卜婆婆的精灵伙伴！你再问问其他伙伴吧……"]],["继续寻觅……"]);
         }
         else if(id == 1)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10137_0"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep4Handler);
               QuestManager.completeStep(_quest.id,4);
            },true,false,2);
         }
      }
      
      private function onStep4Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Handler);
         SceneManager.changeScene(SceneType.LOBBY,213);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Handler);
      }
   }
}
