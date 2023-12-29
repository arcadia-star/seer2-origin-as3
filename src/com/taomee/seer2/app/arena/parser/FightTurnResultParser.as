package com.taomee.seer2.app.arena.parser
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationType;
   import com.taomee.seer2.app.arena.controller.IArenaUIController;
   import com.taomee.seer2.app.arena.controller.IFightController;
   import com.taomee.seer2.app.arena.data.BuffResultInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.data.FighterTurnResultInfo;
   import com.taomee.seer2.app.arena.data.TurnResultInfo;
   import com.taomee.seer2.app.arena.events.FighterEvent;
   import com.taomee.seer2.app.arena.util.SkillCategoryName;
   import com.taomee.seer2.app.arena.util.SkillCategoryValue;
   import com.taomee.seer2.app.config.skill.SkillTypeRelation;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.app.popup.ServerMessager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class FightTurnResultParser extends EventDispatcher
   {
      
      public static const PARSE_END:String = "parseEnd";
       
      
      private var _scene:ArenaScene;
      
      private var _turnResultInfoVec:Vector.<TurnResultInfo>;
      
      private var _buffResultInfoVec:Vector.<BuffResultInfo>;
      
      private var atker:Fighter;
      
      private var atkee:Fighter;
      
      public var parsingTurnResultInfo:TurnResultInfo;
      
      public function FightTurnResultParser(param1:ArenaScene)
      {
         super(this);
         this._scene = param1;
      }
      
      public function dispose() : void
      {
         this._scene = null;
         this._turnResultInfoVec = null;
         this._buffResultInfoVec = null;
      }
      
      public function parseTurnResult(param1:Vector.<TurnResultInfo>, param2:Vector.<BuffResultInfo>) : void
      {
         this._turnResultInfoVec = param1;
         this._buffResultInfoVec = param2;
         if(this._turnResultInfoVec.length > 0)
         {
            this.parseTurnResultInfo(this._turnResultInfoVec.pop());
         }
         else
         {
            this.parseBuffResult(false,SkillTypeRelation.YIBAN);
            this._scene.arenaData.effectHpPackage11();
            this.dispatchParseEvent(PARSE_END);
         }
      }
      
      private function parseTurnResultInfo(param1:TurnResultInfo) : void
      {
         var turnResultVec:Vector.<FighterTurnResultInfo>;
         var arenaUIController:IArenaUIController = null;
         var _turnActionCount:int = 0;
         var recordCount:uint = 0;
         var fighterTurnInfo:FighterTurnResultInfo = null;
         var adjustPositionComplete:Function = null;
         var onAtkerHit:Function = null;
         var onFighterActionEnd:Function = null;
         var fighter:Fighter = null;
         var resultInfo:TurnResultInfo = param1;
         adjustPositionComplete = function():void
         {
            _scene.sortAllFighters();
            _scene.mapModel.content.addChild(atker);
            atker.takeAction();
            var _loc1_:FighterTurnResultInfo = atker.fighterTurnResultInfo;
            showAtkerSkillInfo(_loc1_.skillId);
         };
         var showAtkerSkillInfo:Function = function(param1:uint):void
         {
            var _loc2_:SkillInfo = atker.fighterInfo.getSkillInfo(param1);
            if(_loc2_ != null)
            {
               arenaUIController.showSkillBubble(atker,_loc2_.name);
               arenaUIController.entryValue("<font color=\'#00ffff\'>" + atker.fighterInfo.name + ":" + "</font>" + "<font color=\'#ffffff\'>" + "使用技能" + "</font>" + "<font color=\'#ffff00\'>" + _loc2_.name + "</font>");
            }
            else
            {
               arenaUIController.showSkillBubble(atker,"技能不详");
            }
         };
         onAtkerHit = function(param1:FighterEvent):void
         {
            var atkerTurnResultInfo:FighterTurnResultInfo;
            var skillInfo:SkillInfo = null;
            var skillHitCount:int = 0;
            var timeout:uint = 0;
            var burstArr:Array = null;
            var skillHitTimeOut:Function = null;
            var evt:FighterEvent = param1;
            atker.removeEventListener(FighterEvent.HIT,onAtkerHit);
            atkerTurnResultInfo = atker.fighterTurnResultInfo;
            skillInfo = atker.fighterInfo.getSkillInfo(atkerTurnResultInfo.skillId);
            if(skillInfo != null && skillInfo.categoryId != SkillCategoryValue.BUF_VALUE)
            {
               if(parsingTurnResultInfo.atkTimes > 1)
               {
                  skillHitTimeOut = function():void
                  {
                     if(skillHitCount < parsingTurnResultInfo.atkTimes)
                     {
                        atkee.sectionSkill();
                        ArenaAnimationManager.showAtkeeHpReduceSplash(atkee,parsingTurnResultInfo,burstArr[skillHitCount - 1]);
                        ++skillHitCount;
                        clearTimeout(timeout);
                        timeout = setTimeout(skillHitTimeOut,100);
                     }
                     else
                     {
                        atkee.takeAction();
                        ArenaAnimationManager.showAtkeeHpReduceSplash(atkee,parsingTurnResultInfo,burstArr[skillHitCount - 1]);
                        if(skillInfo.category == SkillCategoryName.POW)
                        {
                           ArenaAnimationManager.createAnimation(ArenaAnimationType.POWSKILLHIT);
                        }
                     }
                  };
                  skillHitCount = 1;
                  timeout = 0;
                  burstArr = getBurstList(parsingTurnResultInfo.atkTimes);
                  skillHitTimeOut();
               }
               else
               {
                  atkee.takeAction();
                  ArenaAnimationManager.showAtkeeHpReduceSplash(atkee,parsingTurnResultInfo);
                  if(skillInfo.category == SkillCategoryName.POW)
                  {
                     ArenaAnimationManager.createAnimation(ArenaAnimationType.POWSKILLHIT);
                  }
               }
            }
            if(parsingTurnResultInfo.isCritical)
            {
               ArenaAnimationManager.createAnimation(ArenaAnimationType.BAOJI);
            }
            ArenaAnimationManager.environmentFeedback(atker,_scene.mapModel,_scene.arenaData.isDoubleMode);
            atkee.updateInfo();
            atker.updateInfo();
            arenaUIController.updateStatusPanel();
            ArenaAnimationManager.showBuffDisabledAnimation(atkee.fighterInfo.fightBuffInfoVec,atkee.fighterSide);
         };
         var getBurstList:Function = function(param1:uint):Array
         {
            var _loc2_:Array = [];
            ServerMessager.addMessage("连击次数为: " + param1 + "次");
            switch(param1)
            {
               case 2:
                  _loc2_ = [1];
                  break;
               case 3:
                  _loc2_ = [1];
                  break;
               case 4:
                  _loc2_ = [1];
                  break;
               case 5:
                  _loc2_ = [1];
                  break;
               case 6:
                  _loc2_ = [0,0,0,0,0,1];
                  break;
               case 7:
                  _loc2_ = [0,0,0,0,0,0,1];
                  break;
               case 8:
                  _loc2_ = [0,0,0,0,0,0,0,1];
                  break;
               case 9:
                  _loc2_ = [0,0,0,0,0,0,0,0,1];
                  break;
               case 10:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,1];
                  break;
               case 11:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 12:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 13:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 14:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 15:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 16:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 17:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 18:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 19:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 20:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 21:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 22:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 23:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 24:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 25:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 26:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 27:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 28:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 29:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               case 30:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
                  break;
               default:
                  _loc2_ = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
            }
            return _loc2_;
         };
         onFighterActionEnd = function(param1:FighterEvent):void
         {
            var _loc2_:Fighter = param1.target as Fighter;
            _loc2_.removeEventListener(FighterEvent.ACTION_END,onFighterActionEnd);
            var _loc3_:FighterTurnResultInfo = atker.fighterTurnResultInfo;
            var _loc4_:SkillInfo;
            if((Boolean(_loc4_ = atker.fighterInfo.getSkillInfo(_loc3_.skillId))) && _loc4_.categoryId == SkillCategoryValue.BUF_VALUE)
            {
               atkee.fakeAct();
            }
            recordPlayedAction();
         };
         var recordPlayedAction:Function = function():void
         {
            ++_turnActionCount;
            if(atkee == atker || _turnActionCount == recordCount)
            {
               _turnActionCount = 0;
               if(_turnResultInfoVec.length > 0)
               {
                  parseTurnResultInfo(_turnResultInfoVec.pop());
               }
               else
               {
                  if(parsingTurnResultInfo)
                  {
                     parseBuffResult(false,SkillTypeRelation.YIBAN);
                  }
                  arenaUIController.updateStatusPanel();
                  dispatchParseEvent(PARSE_END);
               }
            }
         };
         arenaUIController = this._scene.arenaUIController;
         this.parsingTurnResultInfo = resultInfo;
         turnResultVec = resultInfo.fighterTurnResultInfoVec;
         _turnActionCount = 0;
         recordCount = turnResultVec.length;
         for each(fighterTurnInfo in turnResultVec)
         {
            fighter = this._scene.arenaData.getFighter(fighterTurnInfo.userId,fighterTurnInfo.catchTime);
            fighter.turnResultInfo = resultInfo;
            fighter.addEventListener(FighterEvent.ACTION_END,onFighterActionEnd);
            if(fighterTurnInfo.isAtker)
            {
               this.atker = fighter;
               this.atker.addEventListener(FighterEvent.HIT,onAtkerHit);
            }
            else
            {
               this.atkee = fighter;
            }
         }
         this.updateMainPosition(Vector.<Fighter>([this.atker,this.atkee]),adjustPositionComplete);
      }
      
      private function updateMainPosition(param1:Vector.<Fighter>, param2:Function) : void
      {
         var leftContain:Boolean = false;
         var controller:IFightController = null;
         var arenaController:IArenaUIController = null;
         var onChangeComplete:Function = null;
         var fighters:Vector.<Fighter> = param1;
         var onComplete:Function = param2;
         var updateFighterPosition:Function = function(param1:Fighter):void
         {
            var _loc2_:FighterTeam = null;
            var _loc3_:Boolean = false;
            leftContain = controller.leftTeam.hasFighter(param1);
            if(leftContain)
            {
               _loc2_ = controller.leftTeam;
            }
            else
            {
               _loc3_ = controller.rightTeam.hasFighter(param1);
               if(_loc3_)
               {
                  _loc2_ = controller.rightTeam;
               }
            }
            if(_loc2_ != null)
            {
               if(_loc2_.mainFighter != param1)
               {
                  _loc2_.changeMainSubPosition(onChangeComplete);
               }
               else
               {
                  onChangeComplete();
               }
               return;
            }
            throw new Error("该精灵[" + param1.name + "]不属于任何队伍!!");
         };
         onChangeComplete = function():void
         {
            arenaController.updateStatusPanelInfo();
            updateMainPosition(fighters,onComplete);
         };
         leftContain = false;
         controller = this._scene.fightController;
         arenaController = this._scene.arenaUIController;
         if(fighters.length > 0)
         {
            updateFighterPosition(fighters.pop());
         }
         else
         {
            onComplete();
         }
      }
      
      private function parseBuffResult(param1:Boolean, param2:uint) : void
      {
         var _loc5_:BuffResultInfo = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Fighter = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc3_:int = int(this._buffResultInfoVec.length);
         var _loc4_:uint = 0;
         while(this._buffResultInfoVec.length > 0)
         {
            _loc6_ = (_loc5_ = this._buffResultInfoVec.pop()).userId;
            _loc7_ = _loc5_.fighterId;
            _loc8_ = _loc5_.isDying;
            (_loc9_ = this._scene.arenaData.getFighter(_loc6_,_loc7_)).fighterBuffResultInfo = _loc5_;
            if(_loc8_)
            {
               _loc9_.dyingHp();
            }
            else
            {
               _loc10_ = int(_loc5_.buffNum);
               _loc11_ = 0;
               _loc12_ = 0;
               while(_loc12_ < _loc10_)
               {
                  _loc13_ = _loc5_.getChangeHp(_loc12_);
                  _loc9_.fighterInfo.changeHp(_loc13_);
                  _loc11_ += _loc13_;
                  _loc12_++;
               }
               if(_loc11_ > 0)
               {
                  ArenaAnimationManager.createAnimation(ArenaAnimationType.HPINCREASE,{
                     "fightSide":_loc9_.fighterSide,
                     "fighter":_loc9_,
                     "changedHp":_loc11_,
                     "startInterval":_loc4_
                  });
               }
               else if(_loc13_ < 0)
               {
                  ArenaAnimationManager.createAnimation(ArenaAnimationType.HPDECREASE,{
                     "reducedHp":Math.abs(_loc11_),
                     "fighter":_loc9_,
                     "fightSide":_loc9_.fighterSide,
                     "isBaoJi":param1,
                     "skillTypeRelation":param2
                  });
               }
               _loc4_ += 30;
            }
         }
      }
      
      private function dispatchParseEvent(param1:String) : void
      {
         if(hasEventListener(param1))
         {
            dispatchEvent(new Event(param1));
         }
      }
   }
}
