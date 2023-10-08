package com.taomee.seer2.app.firstTeach.guide.controller
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationType;
   import com.taomee.seer2.app.arena.cmd.ResourceReadyCMD;
   import com.taomee.seer2.app.arena.controller.FightChangeController;
   import com.taomee.seer2.app.arena.controller.IArenaUIController;
   import com.taomee.seer2.app.arena.controller.IFightController;
   import com.taomee.seer2.app.arena.data.*;
   import com.taomee.seer2.app.arena.parser.FightTurnResultParser;
   import com.taomee.seer2.app.arena.processor.*;
   import com.taomee.seer2.app.arena.ui.status.panel.*;
   import com.taomee.seer2.app.arena.util.*;
   import com.taomee.seer2.app.guide.manager.GuideManager;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GudieFightController implements IFightController
   {
       
      
      private var _scene:ArenaScene;
      
      private var _turnResultParser:FightTurnResultParser;
      
      private var _revenueInfo:RevenueInfo;
      
      private var _resultInfo:FightResultInfo;
      
      private var _fightChangeController:FightChangeController;
      
      private var _par:Sprite;
      
      private var _fightState:String;
      
      private var _buffResultInfoVec:Vector.<BuffResultInfo>;
      
      private var _turnResultInfoVec:Vector.<TurnResultInfo>;
      
      private var _pvpFightChangeInfos:Vector.<PvpFightChangeInfo>;
      
      public function GudieFightController(param1:ArenaScene)
      {
         this._pvpFightChangeInfos = new Vector.<PvpFightChangeInfo>();
         super();
         this._scene = param1;
         this._fightChangeController = new FightChangeController(this._scene);
         this.changeFighterState(FightState.PRESENTATION);
         if(this._turnResultParser == null)
         {
            this._turnResultParser = new FightTurnResultParser(this._scene);
            this._turnResultParser.addEventListener(FightTurnResultParser.PARSE_END,this.turnParseEnd);
         }
         this._turnResultInfoVec = new Vector.<TurnResultInfo>();
         this._buffResultInfoVec = new Vector.<BuffResultInfo>();
      }
      
      public function addPar(param1:Sprite) : void
      {
         this._par = param1;
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
         var _loc2_:FighterTurnResultInfo = this.rightMainFighter.fighterTurnResultInfo;
         var _loc3_:BuffResultInfo = this.rightMainFighter.fighterBuffResultInfo;
         if(_loc2_ != null && _loc2_.isDying == true || _loc3_ != null && _loc3_.isDying == true)
         {
            ArenaAnimationManager.createAnimation(ArenaAnimationType.CATCHHIT);
         }
         this.parseTurn();
         this.excutePvpFightInfo();
         this.checkFightEnd();
      }
      
      private function parseTurn() : void
      {
         var _loc1_:TurnResultInfo = this._turnResultParser.parsingTurnResultInfo;
         if(_loc1_)
         {
            if(_loc1_.notifyIndex == 1)
            {
               GudieFightTipContent.startTip("UI_TIP2",1,this._par);
            }
            else if(_loc1_.notifyIndex == 2)
            {
            }
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
               if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA)
               {
                  _scene.arenaUIController.startSelectOperate();
                  GudieFightTipContent.startTip("UI_TIP0",0,_par);
               }
               else
               {
                  new ResourceReadyCMD(_scene.arenaData.fightMode).send();
               }
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
         this.leftMainFighter.updateAnger(this.leftMainFighter.fighterInfo.fightAnger + 15);
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
         GuideManager.instance.close();
         this._scene.exitFight();
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
