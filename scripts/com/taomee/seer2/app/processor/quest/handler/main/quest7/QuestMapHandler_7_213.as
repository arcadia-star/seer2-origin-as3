package com.taomee.seer2.app.processor.quest.handler.main.quest7
{
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_7_213 extends QuestMapHandler
   {
       
      
      private var _hemaMc:MovieClip;
      
      private var _hemaPet:MovieClip;
      
      private var _resultInfo:FightResultInfo;
      
      public function QuestMapHandler_7_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,5) && !QuestManager.isStepComplete(_quest.id,6))
         {
            this._hemaMc = _map.libManager.getMovieClip("hema");
            this._hemaMc.x = 548;
            this._hemaMc.y = 472;
            _map.content.addChild(this._hemaMc);
            this._hemaPet = this._hemaMc["pet"];
            _processor.showMouseHintOver(this._hemaPet);
            this._hemaPet.buttonMode = true;
            this._hemaPet.addEventListener(MouseEvent.CLICK,this.onHemaPetClick);
            PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP,this.onPetLevelUp);
         }
      }
      
      private function onHemaPetClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._hemaPet.buttonMode = false;
         this._hemaPet.removeEventListener(MouseEvent.CLICK,this.onHemaPetClick);
         _processor.hideMouseClickHint();
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("7_1"),function():void
         {
            DialogPanel.showForSimple(11,"多罗",[[2,"队长……我感觉眼睛湿湿的……我……我没哭！"]],"傻瓜！你应该高兴不是吗？",function():void
            {
               DialogPanel.showForSimple(11,"多罗",[[1,"我不哭！小海马再见了……我想我们会再见面的！"]],"这家伙难得这么认真！",function():void
               {
                  DisplayObjectUtil.removeFromParent(_hemaMc);
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                  QuestManager.completeStep(_quest.id,6);
               });
            });
         });
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.questId == 7)
         {
            ModuleManager.addEventListener("FightResultPanel",ModuleEvent.HIDE,this.teacherPlayerHandler);
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
            _loc2_ = new Object();
            _loc2_.index = 1;
            ModuleManager.toggleModule(URLUtil.getAppModule("QuestSelectRewardPanel"),"正在打开主线任务奖励面板...",_loc2_);
         }
      }
      
      private function onPetLevelUp(param1:PetInfoEvent) : void
      {
         this._resultInfo = param1.content.resultInfo;
      }
      
      private function teacherPlayerHandler(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("FightResultPanel",ModuleEvent.HIDE,this.teacherPlayerHandler);
      }
      
      override public function processMapDispose() : void
      {
         PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP,this.onPetLevelUp);
         ModuleManager.removeEventListener("FightResultPanel",ModuleEvent.HIDE,this.teacherPlayerHandler);
      }
   }
}
