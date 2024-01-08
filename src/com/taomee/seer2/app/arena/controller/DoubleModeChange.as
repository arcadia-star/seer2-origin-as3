package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.arena.util.FightPostion;
   import com.taomee.seer2.app.arena.util.FightState;
   
   internal class DoubleModeChange extends BaseModeChange
   {
       
      
      public function DoubleModeChange(param1:ArenaScene)
      {
         super(param1);
      }
      
      override public function changeLeftMainFighter(param1:Fighter, param2:uint) : void
      {
         var isParser:Boolean = false;
         var onLeftMainFighterAnimationEnd:Function = null;
         var fighter:Fighter = param1;
         var angerVaule:uint = param2;
         onLeftMainFighterAnimationEnd = function():void
         {
            if(fightController.state == FightState.CHANGE_LEFT_FIGHTER)
            {
               if(isParser)
               {
                  fightController.parseTurnResult();
               }
            }
            _scene.sortAllFighters();
         };
         var fightMode:uint = _scene.arenaData.fightMode;
         var hasDeadFighter:Boolean = this.hasDeadFighter();
         var isPvpMode:Boolean = FightMode.isPVPMode(fightMode);
         fighter.fighterInfo.fightAnger = angerVaule;
         leftTeam.replaceFighterPosition(FightPostion.MAIN,fighter);
         fighter.updatePosition();
         _scene.mapModel.content.addChild(leftMainFighter);
         fighter.tweenToPosition(onLeftMainFighterAnimationEnd);
         arenaUIController.updateStatusPanelInfo();
         arenaUIController.updateControlledFighter(leftMainFighter);
         arenaUIController.showSkillPanel();
         fightController.changeFighterState(FightState.CHANGE_LEFT_FIGHTER);
         isParser = true;
         if(!hasDeadFighter && isPvpMode)
         {
            fightController.changeFighterState(FightState.FIGHTING);
            ArenaAnimationManager.hideWaiting();
            isParser = false;
         }
      }
      
      override public function changeLeftSubFighter(param1:Fighter, param2:uint) : void
      {
         var isDoubleMode:Boolean;
         var onAnimationEnd:Function = null;
         var fighter:Fighter = param1;
         var angerVaule:uint = param2;
         onAnimationEnd = function():void
         {
            _scene.sortAllFighters();
         };
         fighter.fighterInfo.fightAnger = angerVaule;
         isDoubleMode = _scene.arenaData.isDoubleMode;
         leftTeam.replaceFighterPosition(FightPostion.SUB,fighter);
         fighter.updatePosition();
         fighter.tweenToPosition(onAnimationEnd);
         _scene.mapModel.content.addChild(leftSubFighter);
      }
   }
}
