package com.taomee.seer2.app.arena.controller {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
import com.taomee.seer2.app.arena.processor.Processor_19;
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.arena.util.FightPostion;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.arena.util.FightState;
import com.taomee.seer2.app.config.FitConfig;

import org.taomee.utils.Tick;

internal class SingleModeChange extends BaseModeChange {


    public function SingleModeChange(param1:ArenaScene) {
        super(param1);
    }

    override public function changeLeftMainFighter(param1:Fighter, param2:uint):void {
        var hasDeadFighter:Boolean = false;
        var isPvpMode:Boolean = false;
        var onTick:Function = null;
        var onLeftMainFighterAnimationEnd:Function = null;
        var leftPrevMain:Fighter = null;
        var fighter:Fighter = param1;
        var angerVaule:uint = param2;
        onTick = function (param1:uint):void {
            Tick.instance.removeRender(onTick);
            onChangeStatusPet(1);
        };
        var onChangeStatusPet:Function = function (param1:int):void {
            leftTeam.replaceFighterPositionWithActive(FightPostion.MAIN, fighter);
            fighter.updatePosition();
            fighter.visible = false;
            _scene.mapModel.content.addChild(leftMainFighter);
            updateUI(param1);
            Processor_19.isChangeIng = false;
        };
        var updateUI:Function = function (param1:int):void {
            var _loc3_:Object = null;
            arenaUIController.updateStatusPanelInfo();
            arenaUIController.updateControlledFighter(leftMainFighter);
            arenaUIController.showSkillPanel();
            fightController.changeFighterState(FightState.CHANGE_LEFT_FIGHTER);
            var _loc2_:Boolean = true;
            if (hasDeadFighter == false && isPvpMode) {
                fightController.changeFighterState(FightState.FIGHTING);
                ArenaAnimationManager.hideWaiting();
                _loc2_ = false;
            }
            if (FitConfig.isPetFit(leftMainFighter.fighterInfo.bunchId)) {
                leftMainFighter.visible = true;
                leftMainFighter.playFighterSound();
                _loc3_ = {"parse": _loc2_};
                onLeftMainFighterAnimationEnd(_loc3_);
            } else if (leftPrevMain.fighterInfo.isChangeStatus != 1 && param1 == 0) {
                ArenaAnimationManager.fighterPresentAnimation(leftMainFighter, _scene.arenaData, onLeftMainFighterAnimationEnd, {"parse": _loc2_});
            } else if (param1 == 1) {
                fighter.visible = true;
                fightController.parseTurnResult();
                _scene.sortAllFighters();
            }
        };
        onLeftMainFighterAnimationEnd = function (param1:Object):void {
            if (fightController.state == FightState.CHANGE_LEFT_FIGHTER) {
                if (param1["parse"] == true) {
                    fightController.parseTurnResult();
                }
            }
            _scene.sortAllFighters();
        };
        var fightMode:uint = _scene.arenaData.fightMode;
        hasDeadFighter = this.hasDeadFighter();
        isPvpMode = FightMode.isPVPMode(fightMode);
        fighter.fighterInfo.fightAnger = angerVaule;
        if (!FitConfig.isPetFit(fighter.fighterInfo.bunchId)) {
            leftPrevMain = leftMainFighter;
            if (leftMainFighter.fighterInfo.isChangeStatus != 1) {
                leftMainFighter.disappear(FightSide.LEFT);
                onChangeStatusPet(0);
            } else {
                Tick.instance.addRender(onTick, 2000);
                leftMainFighter.disappear(FightSide.LEFT);
            }
        }
    }

    override public function changeLeftSubFighter(param1:Fighter, param2:uint):void {
        var isDoubleMode:Boolean;
        var onAnimationEnd:Function = null;
        var fighter:Fighter = param1;
        var angerVaule:uint = param2;
        onAnimationEnd = function ():void {
            _scene.sortAllFighters();
        };
        fighter.fighterInfo.fightAnger = angerVaule;
        isDoubleMode = _scene.arenaData.isDoubleMode;
        leftSubFighter.disappear(FightSide.LEFT);
        leftTeam.replaceFighterPositionWithActive(FightPostion.SUB, fighter);
        fighter.updatePosition();
        fighter.visible = false;
        _scene.mapModel.content.addChild(leftSubFighter);
        ArenaAnimationManager.fighterPresentAnimation(leftSubFighter, _scene.arenaData, onAnimationEnd);
    }
}
}
