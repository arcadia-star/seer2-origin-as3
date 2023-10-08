package com.taomee.seer2.app.processor.quest.handler.main.quest35
{
   import com.taomee.seer2.app.actor.ActorManager;
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
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_35_192 extends QuestMapHandler
   {
       
      
      private var _mc_2:MovieClip;
      
      public function QuestMapHandler_35_192(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "35_1")
         {
            this._mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.front.addChild(this._mc_2);
            MovieClipUtil.playMc(this._mc_2,1,this._mc_2.totalFrames,function():void
            {
               NpcDialog.show(31,"巴尔卡",[[2,"这场战争本与你无关！" + ActorManager.actorInfo.nick + "谢谢你，你快走吧！"]],["这根本是陷阱！不能去啊！"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("35_1"),function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"什么嘛！一天晕两次！！！我……可恼！！！灰烬战场那是什么地方？怎么从来没听过？奥拉！奥拉一定知道！"]],["去灰烬之地寻找奥拉"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                        QuestManager.completeStep(_quest.id,1);
                     }]);
                  });
               }]);
            },true);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            SceneManager.changeScene(SceneType.LOBBY,301);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         DisplayUtil.removeForParent(this._mc_2);
         this._mc_2 = null;
      }
   }
}
