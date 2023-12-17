package com.taomee.seer2.app.processor.quest.handler.main.quest3
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightEndReason;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import org.taomee.utils.InvalidateCallback;
   
   public class QuestMapHandler_3_121 extends QuestMapHandler
   {
      
      private static const MAX_NUM:int = 1;
      
      private static const STEP_ID:int = 5;
      
      private static const STEP_DATA_INDEX:int = 0;
       
      
      private var _hasPet:Boolean;
      
      private var _hasFlag:Boolean;
      
      public function QuestMapHandler_3_121(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompete(1))
         {
            this._hasPet = false;
            this._hasFlag = false;
            Connection.addCommandListener(CommandSet.PET_SPAWN_1103,this.onPetSpawn);
            if(!_quest.isStepCompete(2))
            {
               this.processStep2();
            }
            else if(!_quest.isStepCompete(3))
            {
               this.processStep3();
            }
            else if(!_quest.isStepCompete(4))
            {
               this.processStep4();
            }
            else if(!_quest.isStepCompete(5))
            {
               this.processStep5();
            }
            else if(!_quest.isStepCompete(6))
            {
               this.processStep6();
            }
         }
      }
      
      private function processStep2() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
      }
      
      private function onCompleteStep2(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
            this.processStep3();
         }
      }
      
      private function processStep3() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.endReason == FightEndReason.CATCH_END)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep3);
            QuestManager.completeStep(_quest.id,3);
         }
         else
         {
            this.setFlag();
         }
      }
      
      private function onCompleteStep3(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep3);
            this.processStep4();
         }
      }
      
      private function processStep4() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep4);
      }
      
      private function onCompleteStep4(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep4);
            this.processStep5();
         }
      }
      
      private function processStep5() : void
      {
         var _loc1_:int = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.endReason == FightEndReason.NORMAL_END)
         {
            _loc1_ = int(_quest.getStepData(STEP_ID,STEP_DATA_INDEX));
            _loc1_++;
            _quest.setStepData(STEP_ID,STEP_DATA_INDEX,_loc1_);
            if(_loc1_ >= MAX_NUM)
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep5);
               QuestManager.completeStep(_quest.id,5);
            }
            else
            {
               QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER,this.onUpdateStepBuffer);
               QuestManager.setStepBufferServer(_quest.id,STEP_ID);
            }
         }
         else
         {
            this.setFlag();
         }
      }
      
      private function onUpdateStepBuffer(param1:QuestEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER,this.onUpdateStepBuffer);
            _loc2_ = MAX_NUM - _quest.getStepData(STEP_ID,STEP_DATA_INDEX);
            if(_loc2_ > 0)
            {
               ServerMessager.addMessage("还差" + "<font color=\'#ff0000\'>" + _loc2_ + "</font>" + "只法拉没有打完");
            }
            else
            {
               ServerMessager.addMessage("完成当前步骤！");
            }
            this.setFlag();
         }
      }
      
      private function onPetSpawn(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.PET_SPAWN_1103,this.onPetSpawn);
         this._hasPet = true;
         InvalidateCallback.addFunc(this.checkFightFlag);
      }
      
      private function setFlag() : void
      {
         this._hasFlag = true;
         this.checkFightFlag();
      }
      
      private function checkFightFlag() : void
      {
         var _loc1_:Mobile = null;
         if(this._hasFlag && this._hasPet)
         {
            _loc1_ = MobileManager.getMobileVec(MobileType.SPAWNED_PET)[0] as SpawnedPet;
            _processor.mouseHint.x = 0;
            _processor.mouseHint.y = -40;
            _loc1_.addChild(_processor.mouseHint);
         }
      }
      
      private function onCompleteStep5(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep5);
            this.processStep6();
         }
      }
      
      private function processStep6() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
      }
      
      private function onCustomReply(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(DialogPanelEventData(evt.content).params == "3_6")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestAnimation("3/quest3Animation2"),1,[[1,0]],function():void
            {
               _processor.showMouseHintAt(750,490);
               QuestManager.completeStep(_quest.id,6);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         Connection.removeCommandListener(CommandSet.PET_SPAWN_1103,this.onPetSpawn);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
         QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER,this.onUpdateStepBuffer);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep3);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep4);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep5);
         super.processMapDispose();
      }
   }
}
