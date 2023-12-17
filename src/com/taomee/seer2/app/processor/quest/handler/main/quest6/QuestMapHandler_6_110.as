package com.taomee.seer2.app.processor.quest.handler.main.quest6
{
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DomainUtil;
   
   public class QuestMapHandler_6_110 extends QuestMapHandler
   {
       
      
      private var _resultInfo:FightResultInfo;
      
      public function QuestMapHandler_6_110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.status == QuestStatus.ACCEPTABLE)
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         }
         else if(_quest.status == QuestStatus.IN_PROGRESS)
         {
            if(!_quest.isStepCompete(1))
            {
               this.processStep1();
            }
            else if(!_quest.isStepCompete(10))
            {
               DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
               PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP,this.onPetLevelUp);
            }
         }
      }
      
      private function onQuestAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete1);
         QuestManager.completeStep(_quest.id,1);
      }
      
      private function onStepComplete1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete1);
            _processor.showMouseHintAt(-30,470);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "6_10")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
            QuestManager.completeStep(_quest.id,10);
         }
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         ModuleManager.addEventListener("FightResultPanel",ModuleEvent.HIDE,this.teacherPlayerHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
      }
      
      private function onPetLevelUp(param1:PetInfoEvent) : void
      {
         this._resultInfo = param1.content.resultInfo;
      }
      
      private function teacherPlayerHandler(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("FightResultPanel",ModuleEvent.HIDE,this.teacherPlayerHandler);
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         var mc:MovieClip = null;
         var info:ContentInfo = param1;
         var domain:ApplicationDomain = info.content;
         mc = DomainUtil.getMovieClip("mc_0",domain);
         LayerManager.topLayer.addChild(mc);
         SoundManager.enabled = false;
         MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
         {
            SoundManager.enabled = true;
            DisplayObjectUtil.removeFromParent(mc);
         },true);
      }
      
      override public function processMapDispose() : void
      {
         PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP,this.onPetLevelUp);
         ModuleManager.removeEventListener("FightResultPanel",ModuleEvent.HIDE,this.teacherPlayerHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete1);
      }
   }
}
