package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationType;
   import com.taomee.seer2.app.arena.cmd.ResourceReadyCMD;
   import com.taomee.seer2.app.arena.cmd.UseChangeCMD;
   import com.taomee.seer2.app.arena.data.*;
   import com.taomee.seer2.app.arena.decoration.DecorationControl;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.parser.FightTurnResultParser;
   import com.taomee.seer2.app.arena.processor.*;
   import com.taomee.seer2.app.arena.ui.status.panel.*;
   import com.taomee.seer2.app.arena.util.*;
   import com.taomee.seer2.app.config.FitConfig;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.item.EmblemItemDefinition;
   import com.taomee.seer2.app.config.pet.PetFitDefinition;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class FightController implements IFightController
   {
      
      private static var _isFightAngle:Boolean;
       
      
      private var _processores:Vector.<ArenaProcessor>;
      
      private var _scene:ArenaScene;
      
      private var _turnResultParser:FightTurnResultParser;
      
      private var _revenueInfo:RevenueInfo;
      
      private var _resultInfo:FightResultInfo;
      
      private var _fightChangeController:com.taomee.seer2.app.arena.controller.FightChangeController;
      
      private var _fightState:String;
      
      private var _buffResultInfoVec:Vector.<BuffResultInfo>;
      
      private var _turnResultInfoVec:Vector.<TurnResultInfo>;
      
      private var _pvpFightChangeInfos:Vector.<PvpFightChangeInfo>;
      
      public function FightController(param1:ArenaScene)
      {
         this._pvpFightChangeInfos = new Vector.<PvpFightChangeInfo>();
         super();
         this._scene = param1;
         this._fightChangeController = new com.taomee.seer2.app.arena.controller.FightChangeController(this._scene);
         this.changeFighterState(FightState.PRESENTATION);
         if(this._turnResultParser == null)
         {
            this._turnResultParser = new FightTurnResultParser(this._scene);
            this._turnResultParser.addEventListener(FightTurnResultParser.PARSE_END,this.turnParseEnd);
         }
         this._turnResultInfoVec = new Vector.<TurnResultInfo>();
         this._buffResultInfoVec = new Vector.<BuffResultInfo>();
         this._processores = new Vector.<ArenaProcessor>();
         this._processores.push(new Processor_1501(this._scene));
         this._processores.push(new Processor_1502(this._scene));
         this._processores.push(new Processor_2(this._scene));
         this._processores.push(new Processor_3(this._scene));
         this._processores.push(new Processor_7(this._scene));
         this._processores.push(new Processor_5(this._scene));
         this._processores.push(new Processor_1507(this._scene));
         this._processores.push(new Processor_9(this._scene));
         this._processores.push(new Processor_8(this._scene));
         this._processores.push(new Processor_1031(this._scene));
         this._processores.push(new Processor_10(this._scene));
         this._processores.push(new Processor_11(this._scene));
         this._processores.push(new Processor_12(this._scene));
         this._processores.push(new Processor_15(this._scene));
         this._processores.push(new Processor_16(this._scene));
         this._processores.push(new Processor_17(this._scene));
         this._processores.push(new Processor_18(this._scene));
         this._processores.push(new Processor_19(this._scene));
      }
      
      public function addPar(param1:Sprite) : void
      {
      }
      
      public function parseTurnResult() : void
      {
         var turnResultInfoSort:Function = null;
         turnResultInfoSort = function(param1:TurnResultInfo, param2:TurnResultInfo):int
         {
            if(param1.notifyIndex > param2.notifyIndex)
            {
               return -1;
            }
            return 1;
         };
         this.changeFighterState(FightState.FIGHTING);
         this._turnResultInfoVec = this._turnResultInfoVec.sort(turnResultInfoSort);
         this._turnResultParser.parseTurnResult(this._turnResultInfoVec,this._buffResultInfoVec);
      }
      
      private function turnParseEnd(param1:Event = null) : void
      {
         Connection.releaseCommand(CommandSet.FIGHT_CHANGE_PET_19);
         Connection.blockCommand(CommandSet.FIGHT_CHANGE_PET_19);
         this.checkPetFit();
         this.checkPlayCatchMovie();
         this.excutePvpFightInfo();
         DecorationControl._trunCount += 1;
         if(DecorationControl._isShowDecoration)
         {
            DecorationControl.update();
         }
         this.checkFightEnd();
         this._turnResultParser.parsingTurnResultInfo = null;
      }
      
      private function checkPetFit() : void
      {
         var _loc3_:FighterTurnResultInfo = null;
         var _loc4_:Fighter = null;
         var _loc5_:PetFitDefinition = null;
         var _loc1_:TurnResultInfo = this._turnResultParser.parsingTurnResultInfo;
         var _loc2_:Boolean = this._scene.arenaData.isFightEnd;
         if(Boolean(_loc1_) && _loc2_ == false)
         {
            for each(_loc3_ in _loc1_.fighterTurnResultInfoVec)
            {
               _loc4_ = this._scene.arenaData.getFighter(_loc3_.userId,_loc3_.catchTime);
               if(_loc3_.isAtker)
               {
                  if((Boolean(_loc5_ = FitConfig.formSkillIdGetPetFitDefinition(_loc3_.skillId))) && (FitConfig.checkPetType(_loc5_) || _loc3_.userId != ActorManager.actorInfo.id))
                  {
                     DisplayObjectUtil.removeFromParent(_loc4_);
                     ArenaAnimationManager.abortCountDown();
                     Connection.releaseCommand(CommandSet.FIT_CHANGE_HP_POS_18);
                     Connection.blockCommand(CommandSet.FIT_CHANGE_HP_POS_18);
                     if(_loc3_.userId == ActorManager.actorInfo.id)
                     {
                        this.updateFitPet(this.leftTeam,_loc5_);
                        _isFightAngle = true;
                        new UseChangeCMD(this.leftTeam.getFighterToBounchId(_loc5_.id).fighterInfo.catchTime).send();
                        if(_loc5_.type != "void")
                        {
                           switch(_loc5_.type)
                           {
                              case "item":
                                 ItemManager.reduceItemQuantity(_loc5_.content,1);
                           }
                        }
                     }
                     else
                     {
                        this.updateFitPet(this.rightTeam,_loc5_);
                     }
                  }
               }
            }
         }
      }
      
      private function updateFitPet(param1:FighterTeam, param2:PetFitDefinition) : void
      {
         if(param1.getFighterToBounchId(param2.id) == null)
         {
            return;
         }
         param1.replaceFighterPositionWithActive(FightPostion.MAIN,param1.getFighterToBounchId(param2.id));
         param1.getFighterToBounchId(param2.id).updatePosition();
         param1.getFighterToBounchId(param2.id).fighterInfo.fightAnger = param1.getFighterToBounchId(param2.id).fighterInfo.fightAnger + param2.anger;
         this._scene.mapModel.content.addChild(param1.getFighterToBounchId(param2.id));
      }
      
      private function checkPlayCatchMovie() : void
      {
         var _loc1_:FighterTurnResultInfo = this.rightMainFighter.fighterTurnResultInfo;
         var _loc2_:BuffResultInfo = this.rightMainFighter.fighterBuffResultInfo;
         if(_loc1_ != null && _loc1_.isDying == true || _loc2_ != null && _loc2_.isDying == true)
         {
            if(this._scene.arenaData.fightMode == 3 && this._scene.arenaData.canCatchAfterSptDead)
            {
               this._scene.arenaData.canCatchAfterSptDeadNow = true;
            }
            ArenaAnimationManager.createAnimation(ArenaAnimationType.CATCHHIT);
         }
      }
      
      private function checkFightEnd() : void
      {
         var showFightResultPanel:Function = null;
         var fightMode:uint = 0;
         var delayTime:int = 0;
         var showTeamWin:Function = function(param1:FighterTeam):void
         {
            var _loc2_:Fighter = param1.mainFighter;
            var _loc3_:Fighter = param1.subFighter;
            _loc2_.action = FighterActionType.WIN;
            if(_loc3_ != null)
            {
               _loc3_.action = FighterActionType.WIN;
            }
         };
         var showTeamFailure:Function = function(param1:FighterTeam):void
         {
            var _loc2_:Fighter = param1.mainFighter;
            var _loc3_:Fighter = param1.subFighter;
            if(_loc2_.action != FighterActionType.DEAD)
            {
               _loc2_.action = FighterActionType.DEAD;
            }
            if(_loc3_ != null && _loc3_.action != FighterActionType.DEAD)
            {
               _loc3_.action = FighterActionType.DEAD;
            }
         };
         showFightResultPanel = function(param1:Object):void
         {
            var _loc2_:int = int(param1["delayTime"]);
            if(_resultInfo.showWinnerSider == FightSide.RIGHT)
            {
               SoundManager.backgroundSoundEnabled = true;
            }
            var _loc3_:Object = {
               "petInfoVec":PetInfoManager.getAllBagPetInfo(),
               "revenueInfo":_revenueInfo,
               "resultInfo":_resultInfo,
               "fightMode":fightMode,
               "closeHandler":exitFight,
               "delayTime":_loc2_
            };
            ModuleManager.toggleModule(URLUtil.getAppModule("FightResultPanel"),"正在打开战斗结算面板...",_loc3_);
         };
         var isFightEnd:Boolean = this._scene.arenaData.isFightEnd;
         if(isFightEnd == true)
         {
            ArenaUIIsNew.enableClick = false;
            ArenaAnimationManager.abortCountDown();
            if(this._resultInfo.showWinnerSider == FightSide.LEFT)
            {
               showTeamWin(this.leftTeam);
               showTeamFailure(this.rightTeam);
            }
            else
            {
               showTeamWin(this.rightTeam);
               showTeamFailure(this.leftTeam);
            }
            fightMode = this._scene.fightMode;
            delayTime = 0;
            if(fightMode == FightMode.FIGHT_RING)
            {
               delayTime = -1;
            }
            ArenaAnimationManager.createAnimation(ArenaAnimationType.KOANIMATION,null,showFightResultPanel,{"delayTime":delayTime});
         }
         else
         {
            this.startNextTurn();
         }
      }
      
      public function changeFighter(param1:uint, param2:uint, param3:uint, param4:uint = 1) : void
      {
         this._fightChangeController.changeFighter(param1,param2,param3,param4);
      }
      
      public function checkRightFighterChanged() : void
      {
         this._fightChangeController.checkRightFighterChanged();
      }
      
      public function changeFighterState(param1:String) : void
      {
         this._fightState = param1;
      }
      
      public function get state() : String
      {
         return this._fightState;
      }
      
      public function addBuffResultInfo(param1:BuffResultInfo) : void
      {
         this._buffResultInfoVec.push(param1);
      }
      
      public function addTurnResultInfo(param1:TurnResultInfo) : void
      {
         this._turnResultInfoVec.push(param1);
      }
      
      public function addPvpFightInfo(param1:PvpFightChangeInfo) : void
      {
         this._pvpFightChangeInfos.push(param1);
      }
      
      private function excutePvpFightInfo() : void
      {
         var _loc1_:PvpFightChangeInfo = null;
         while(this._pvpFightChangeInfos.length > 0)
         {
            _loc1_ = this._pvpFightChangeInfos.pop();
            if(_loc1_.catch_time != 0)
            {
               this.changeFighter(_loc1_.user_id,_loc1_.catch_time,_loc1_.anger,_loc1_.position);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:uint = this._processores.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this._processores[_loc2_].dispose();
            _loc2_++;
         }
         this._processores = null;
         if(this._turnResultParser != null)
         {
            this._turnResultParser.removeEventListener(FightTurnResultParser.PARSE_END,this.turnParseEnd);
            this._turnResultParser.dispose();
            this._turnResultParser = null;
         }
         this.leftTeam.dispose();
         this.rightTeam.dispose();
         this._scene = null;
         this._buffResultInfoVec = null;
         this._turnResultInfoVec = null;
         this._revenueInfo = null;
         this._resultInfo = null;
         this._fightChangeController.dispose();
         this._fightChangeController = null;
      }
      
      public function startFighter() : void
      {
         var count:uint = 0;
         var onAnimationEnd:Function = null;
         onAnimationEnd = function():void
         {
            --count;
            if(count <= 0)
            {
               new ResourceReadyCMD(_scene.arenaData.fightMode).send();
            }
         };
         count = 1;
         ArenaAnimationManager.fighterPresentAnimation(this.leftMainFighter,this._scene.arenaData,onAnimationEnd);
         if(this.leftSubFighter != null)
         {
            ArenaAnimationManager.fighterPresentAnimation(this.leftSubFighter,this._scene.arenaData,onAnimationEnd);
            count = 2;
         }
      }
      
      private function startNextTurn() : void
      {
         ArenaAnimationManager.hideWaiting();
         this._fightChangeController.checkRightFighterChanged();
         this.rightMainFighter.updateAnger(this.rightMainFighter.fighterInfo.fightAnger + 15);
         if(_isFightAngle == false)
         {
            this.leftMainFighter.updateAnger(this.leftMainFighter.fighterInfo.fightAnger + 15);
         }
         else
         {
            this.leftMainFighter.updateAnger(this.leftMainFighter.fighterInfo.fightAnger);
         }
         _isFightAngle = false;
         if(this.rightSubFighter != null)
         {
            this.rightSubFighter.updateAnger(this.rightSubFighter.fighterInfo.fightAnger + 15);
         }
         if(this.leftSubFighter != null)
         {
            this.leftSubFighter.updateAnger(this.leftSubFighter.fighterInfo.fightAnger + 15);
         }
         this.arenaUIController.updateAngerBar();
         this.arenaUIController.startSelectOperate();
         if(this.leftMainFighter.fighterInfo.hp <= 0 && !this._scene.arenaData.isDoubleMode)
         {
            this.arenaUIController.activeControlPetPanel(this.leftMainFighter);
         }
      }
      
      public function exitFight() : void
      {
         var petInfo:PetInfo = null;
         var j:int = 0;
         var changedPetInfo:PetInfo = null;
         var showPetGainEmblemMessage:Function = function(param1:uint, param2:uint):void
         {
            var _loc3_:PetInfo = PetInfoManager.getPetInfoFromBag(param1);
            var _loc4_:String = "";
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.name;
               _loc3_.emblemId = param2;
            }
            var _loc5_:EmblemItemDefinition = ItemConfig.getEmblemDefinition(param2);
            var _loc6_:String = "";
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.name;
               ServerMessager.addMessage(_loc4_ + "获得" + _loc6_ + "之力");
            }
         };
         var petInfoVec:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         var petInfoLen:int = int(petInfoVec.length);
         var changedPetInfoLen:int = int(this._resultInfo.changedPetInfoVec.length);
         var i:int = 0;
         while(i < petInfoLen)
         {
            petInfo = petInfoVec[i];
            j = 0;
            while(j < changedPetInfoLen)
            {
               changedPetInfo = this._resultInfo.changedPetInfoVec[j];
               if(changedPetInfo.level > ActorManager.actorInfo.highestPetLevel)
               {
                  ActorManager.actorInfo.highestPetLevel = changedPetInfo.level;
               }
               if(petInfo.catchTime == changedPetInfo.catchTime)
               {
                  PetInfo.updateBaseInfo(petInfo,changedPetInfo);
                  petInfo.learningInfo.pointUnused = changedPetInfo.learningInfo.pointUnused;
                  petInfo.resourceId = changedPetInfo.resourceId;
                  petInfo.skillInfo.updateSkillInfoVec(changedPetInfo.skillInfo.skillInfoVec);
                  petInfo.skillInfo.addGainedSkillInfoVec(changedPetInfo.skillInfo.gainedSkillInfoVec);
                  PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,petInfo);
               }
               j++;
            }
            i++;
         }
         if(this._resultInfo.gainedEmblemPetId != 0)
         {
            showPetGainEmblemMessage(this._resultInfo.gainedEmblemPetId,this._resultInfo.gainedEmblemId);
         }
         this._scene.exitFight();
         if(FightManager.hasEventListener(FightStartEvent.FIGHT_OVER))
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchEvent);
         }
         if(DecorationControl._isShowDecoration)
         {
            DecorationControl.dispose();
         }
      }
      
      private function onSwitchEvent(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchEvent);
         FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.FIGHT_OVER));
      }
      
      public function set resultInfo(param1:FightResultInfo) : void
      {
         this._resultInfo = param1;
      }
      
      public function set revenueInfo(param1:RevenueInfo) : void
      {
         this._revenueInfo = param1;
      }
      
      public function get leftTeam() : FighterTeam
      {
         return this._scene.leftTeam;
      }
      
      public function get rightTeam() : FighterTeam
      {
         return this._scene.rightTeam;
      }
      
      public function get arenaUIController() : IArenaUIController
      {
         return this._scene.arenaUIController;
      }
      
      public function get rightMainFighter() : Fighter
      {
         return this.rightTeam.mainFighter;
      }
      
      public function get leftMainFighter() : Fighter
      {
         return this.leftTeam.mainFighter;
      }
      
      public function get rightSubFighter() : Fighter
      {
         return this.rightTeam.subFighter;
      }
      
      public function get leftSubFighter() : Fighter
      {
         return this.leftTeam.subFighter;
      }
   }
}
