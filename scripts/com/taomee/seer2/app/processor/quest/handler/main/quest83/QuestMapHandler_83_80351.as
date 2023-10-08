package com.taomee.seer2.app.processor.quest.handler.main.quest83
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.pet.PetIsHaveNumberManager;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.Quest1InitNono;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResContentLibrary;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_83_80351 extends QuestMapHandler
   {
      
      public static var quest8IsOk:Boolean = false;
      
      public static var isClickQuest83:Boolean = false;
       
      
      private var _npc:MovieClip;
      
      private var _mc1:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _mc6:MovieClip;
      
      private var _mc7:MovieClip;
      
      private var _mc8:MovieClip;
      
      public function QuestMapHandler_83_80351(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:Object = null;
         super.processMapComplete();
         ActorManager.getActor().blockNoNo = true;
         if(QuestManager.isComplete(83))
         {
            SceneManager.changeScene(SceneType.LOBBY,70);
            return;
         }
         if(QuestManager.isCanAccepted(questID))
         {
            _loc1_ = new Object();
            _loc1_.questBack = this.questBack;
            NewGuidStatisManager.statisHandle(11);
            if(NewPlayerGuideTimeManager.curTimeCheck())
            {
               ModuleManager.showAppModule("NewerSignFivePanel",_loc1_);
            }
            else
            {
               ModuleManager.showAppModule("NewerSignPanel",_loc1_);
            }
         }
         else if(QuestManager.isAccepted(questID))
         {
            this.nextQuestProcessor();
         }
      }
      
      private function questBack() : void
      {
         if(QuestManager.isCanAccepted(questID))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.accept(questID);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         this.nextQuestProcessor();
      }
      
      private function play7Fun(param1:Boolean) : void
      {
         if(param1)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(_quest.id,7);
         }
         else
         {
            this._npc = this.getMC();
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc7);
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入捕捉试炼3");
         }
      }
      
      private function nextQuestProcessor() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:PetInfo = null;
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,3))
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
               QuestManager.completeStep(_quest.id,3);
            }
            else
            {
               this._npc = this.getMC();
               this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入战斗试炼3");
            }
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,4))
         {
            this.quest4();
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,6))
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
               QuestManager.completeStep(_quest.id,6);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","完成捕捉试炼2");
            }
            else if(SceneManager.prevSceneType != SceneType.ARENA || FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               this._npc = this.getMC();
               this._npc.addEventListener(MouseEvent.CLICK,this.onNpc5);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入捕捉试炼2");
            }
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,7))
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.isPet(this.play7Fun);
            }
            else if(SceneManager.prevSceneType != SceneType.ARENA || FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               this._npc = this.getMC();
               this._npc.addEventListener(MouseEvent.CLICK,this.onNpc7);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入捕捉试炼3");
            }
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,8))
         {
            this.quest8();
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入成长试炼1");
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,9))
         {
            this.quest9();
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入成长试炼2");
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,10))
         {
            _loc1_ = false;
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
            {
               if((_loc2_.resourceId == 824 || _loc2_.resourceId == 825 || _loc2_.resourceId == 855) && _loc2_.level >= 60)
               {
                  _loc1_ = true;
               }
            }
            if(_loc1_)
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,this.onStepComplete);
               QuestManager.completeStep(83,10);
               return;
            }
            this._npc = this.getMC();
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入成长试炼3");
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("NewQuestActivity"),function():void
         {
            var _loc1_:Object = new Object();
            _loc1_.index = 8;
            ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"),"",_loc1_);
         });
      }
      
      private function isPet(param1:Function) : void
      {
         var backBack:Function = param1;
         PetIsHaveNumberManager.requestIsHavePet(Vector.<uint>([1]),function():void
         {
            if(PetIsHaveNumberManager.petIsHave(1))
            {
               backBack(true);
            }
            else
            {
               backBack(false);
            }
         });
      }
      
      private function onNpc8(param1:MouseEvent) : void
      {
         ModuleManager.addEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule7);
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function getMC() : MovieClip
      {
         var _loc1_:MovieClip = _map.content["npc"].actor;
         switch(_quest.getCurrentOrNextStep().id)
         {
            case 1:
               _loc1_.gotoAndStop(1);
               break;
            case 2:
               _loc1_.gotoAndStop(1);
               break;
            case 3:
               _loc1_.gotoAndStop(1);
               break;
            case 4:
               _loc1_.gotoAndStop(1);
               break;
            case 5:
               _loc1_.gotoAndStop(2);
               break;
            case 6:
               _loc1_.gotoAndStop(2);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入捕捉试炼2");
               break;
            case 7:
               _loc1_.gotoAndStop(2);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入捕捉试炼3");
               break;
            case 8:
               _loc1_.gotoAndStop(3);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入成长试炼1");
               break;
            case 9:
               _loc1_.gotoAndStop(3);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入成长试炼2");
               break;
            case 10:
               _loc1_.gotoAndStop(3);
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入成长试炼3");
         }
         _map.content["npc"].buttonMode = true;
         return _map.content["npc"];
      }
      
      private function onMC6(param1:MouseEvent) : void
      {
         FightManager.startFightWithGudiePet(100000,null,null,null,1,3);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.stepId == 3)
         {
            this.quest4();
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","完成战斗试炼3");
         }
         else if(param1.stepId == 7)
         {
            _loc2_ = new Object();
            _loc2_.index = 5;
            ModuleManager.addEventListener("GudieFightCompletePanel",ModuleEvent.HIDE,this.onHide);
            ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"),"",_loc2_);
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","完成捕捉试炼3");
         }
         else if(param1.stepId == 9)
         {
            _loc3_ = new Object();
            _loc3_.index = 7;
            ModuleManager.addEventListener("GudieFightCompletePanel",ModuleEvent.HIDE,this.onHide9);
            ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"),"",_loc3_);
            Quest1InitNono.setup();
            StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","完成成长试炼2");
         }
      }
      
      private function onHide9(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("GudieFightCompletePanel",ModuleEvent.HIDE,this.onHide9);
      }
      
      private function quest10() : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function onHide(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("GudieFightCompletePanel",ModuleEvent.HIDE,this.onHide);
         this.quest8();
      }
      
      private function quest9() : void
      {
         this._npc = this.getMC();
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc9);
      }
      
      private function quest8() : void
      {
         this._npc = this.getMC();
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc8);
      }
      
      private function quest4() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.front.addChild(this._mc1);
         this._mc1.addEventListener(MouseEvent.CLICK,this.onMc1);
         NewGuidStatisManager.statisHandle(21);
         StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","进入捕捉试炼1");
      }
      
      private function onNpc9(param1:MouseEvent) : void
      {
         ModuleManager.addEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule8);
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function onNpc7(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function onModule8(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule8);
         if(isClickQuest83)
         {
            this._mc8 = _processor.resLib.getMovieClip("mc8");
            LayerManager.topLayer.addChild(this._mc8);
            this._mc8.addEventListener(MouseEvent.CLICK,this.onMC8);
         }
      }
      
      private function onMC8(param1:MouseEvent) : void
      {
         var data:Object;
         var event:MouseEvent = param1;
         DisplayUtil.removeForParent(this._mc8);
         data = new Object();
         data.type = 0;
         data.subType = 0;
         if(!this.checkMaxLevel())
         {
            AlertManager.showAlert("已有满级精灵，步骤直接完成",function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
               QuestManager.completeStep(_quest.id,9);
            });
            return;
         }
         ModuleManager.addEventListener("PetBagPanel",ModuleEvent.HIDE,this.onModuleBagHide);
         NewGuidStatisManager.statisHandle(41);
         ModuleManager.showModule(URLUtil.getAppModule("PetBagPanel"),"",data);
      }
      
      private function checkMaxLevel() : Boolean
      {
         var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(_loc1_.level < 100)
         {
            return true;
         }
         return false;
      }
      
      private function onModuleBagHide(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("PetBagPanel",ModuleEvent.HIDE,this.onModuleBagHide);
         if(quest8IsOk)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(_quest.id,9);
         }
         else
         {
            this.onModule8(null);
         }
      }
      
      private function onModule7(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule7);
         if(isClickQuest83)
         {
            this._mc3 = _processor.resLib.getMovieClip("mc3");
            LayerManager.topLayer.addChild(this._mc3);
            this._mc3.addEventListener(MouseEvent.CLICK,this.onMC3);
            ResContentLibrary.setInitValue(this._mc3);
            ResContentLibrary.updateRes();
         }
      }
      
      private function onMC3(param1:MouseEvent) : void
      {
         ModuleManager.addEventListener("MapPanel",ModuleEvent.HIDE,this.onShowMapHide7);
         ModuleManager.showModule(URLUtil.getAppModule("MapPanel"),"");
         DisplayUtil.removeForParent(this._mc3);
         this._mc7 = _processor.resLib.getMovieClip("mc7");
         LayerManager.topLayer.addChild(this._mc7);
         ResContentLibrary.setInitValue(this._mc7);
         ResContentLibrary.updateRes();
      }
      
      private function onShowMapHide7(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("MapPanel",ModuleEvent.HIDE,this.onShowMapHide7);
         DisplayUtil.removeForParent(this._mc7);
      }
      
      private function onMc1(param1:MouseEvent) : void
      {
         NewGuidStatisManager.statisHandle(22);
         DisplayUtil.removeForParent(this._mc1);
         SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function onNpc5(param1:MouseEvent) : void
      {
         ModuleManager.addEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule);
         ModuleManager.showModule(URLUtil.getAppModule("NewGudiePanel"),"");
      }
      
      private function onModule(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule);
         if(isClickQuest83)
         {
            this._mc3 = _processor.resLib.getMovieClip("mc3");
            LayerManager.topLayer.addChild(this._mc3);
            ResContentLibrary.setInitValue(this._mc3);
            ResContentLibrary.updateRes();
            this._mc3.addEventListener(MouseEvent.CLICK,this.onMC7);
         }
      }
      
      private function onMC7(param1:MouseEvent) : void
      {
         NewGuidStatisManager.statisHandle(25);
         ModuleManager.showModule(URLUtil.getAppModule("MapPanel"),"");
         DisplayUtil.removeForParent(this._mc3);
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         LayerManager.topLayer.addChild(this._mc4);
         ResContentLibrary.setInitValue(this._mc4);
         ResContentLibrary.updateRes();
         this._mc4.addEventListener(MouseEvent.CLICK,this.onMc4);
      }
      
      private function onMc4(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,80353);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         ActorManager.getActor().blockNoNo = false;
         ModuleManager.removeEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule);
         ModuleManager.removeEventListener("NewGudiePanel",ModuleEvent.HIDE,this.onModule8);
         ModuleManager.removeEventListener("GudieFightCompletePanel",ModuleEvent.HIDE,this.onHide);
         ModuleManager.removeEventListener("MapPanel",ModuleEvent.HIDE,this.onShowMapHide7);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc3);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mc6);
         DisplayUtil.removeForParent(this._mc7);
         DisplayUtil.removeForParent(this._mc8);
         ResContentLibrary.clearInitValue(this._mc3);
         ResContentLibrary.clearInitValue(this._mc4);
         ResContentLibrary.clearInitValue(this._mc7);
      }
   }
}
