package com.taomee.seer2.app.processor.quest.handler.activity.quest30035
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_30035_142 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30035_142(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            _processor.showMouseHintAt(659,149);
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("xegg/xegg4"),function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("XeggPanel"),"正在打开面板...");
         },true,true,2);
      }
      
      override public function processMapDispose() : void
      {
         if(_processor)
         {
            _processor.hideMouseClickHint();
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
