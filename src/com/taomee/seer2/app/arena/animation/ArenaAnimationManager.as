package com.taomee.seer2.app.arena.animation {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.animation.core.IArenaAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.animation.imples.*;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterBuffInfo;
import com.taomee.seer2.app.arena.data.TurnResultInfo;
import com.taomee.seer2.app.arena.newUI.toolbar.NewFightControlPanel;
import com.taomee.seer2.app.arena.util.ArenaUtil;
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.arena.util.FightPostion;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.arena.util.SkillCategoryName;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;

import org.taomee.ds.HashMap;

public class ArenaAnimationManager {

    private static var _animationPool:HashMap;

    private static var _par:Sprite;

    private static var _waitingAnimation:IArenaAnimation;

    private static var _countDownAnimation:IArenaAnimation;

    private static var _indicatorAnimation:IndicatorAnimation;


    public function ArenaAnimationManager() {
        super();
    }

    public static function initAnimation():void {
        _animationPool = new HashMap();
        _animationPool.add(ArenaAnimationType.BAOJI, BaoJiHitAnimation);
        _animationPool.add(ArenaAnimationType.CATCHPETFAIL, CatchFighterFailAnimation);
        _animationPool.add(ArenaAnimationType.CATCHPETSUCCESS, CatchFighterSuccessAnimation);
        _animationPool.add(ArenaAnimationType.CATCHHIT, CatchHintAnimation);
        _animationPool.add(ArenaAnimationType.ITEMUSE, ItemUseAnimation);
        _animationPool.add(ArenaAnimationType.KOANIMATION, KOAnimation);
        _animationPool.add(ArenaAnimationType.PRESENT, PresentAnimation);
        _animationPool.add(ArenaAnimationType.ABSORT, FightAbsorbAnimation);
        _animationPool.add(ArenaAnimationType.COUNTDOWN, FightCountDownAnimation);
        _animationPool.add(ArenaAnimationType.MISS, FightMissAnimation);
        _animationPool.add(ArenaAnimationType.HPDECREASE, HpDecreaseAnimation);
        _animationPool.add(ArenaAnimationType.HPINCREASE, HPIncreaseAnimation);
        _animationPool.add(ArenaAnimationType.POWSKILLHIT, PowSkillHitAnimation);
        _animationPool.add(ArenaAnimationType.POWSKILLSTART, PowSkillStartAnimation);
        _animationPool.add(ArenaAnimationType.WAITING, FightWaitingAnimation);
        _animationPool.add(ArenaAnimationType.INDICATOR, IndicatorAnimation);
        _animationPool.add(ArenaAnimationType.BUFF_DISABLE, BuffDisabledAnimation);
    }

    public static function addPar(param1:Sprite):void {
        _par = param1;
    }

    public static function environmentFeedback(param1:Fighter, param2:MapModel, param3:Boolean):void {
        var _loc4_:uint = param1.fighterTurnResultInfo.skillId;
        var _loc5_:SkillInfo = param1.fighterInfo.getSkillInfo(_loc4_);
        if (param1.turnResultInfo.isCritical) {
            if (_loc5_.category == SkillCategoryName.PHY && !param3) {
                ArenaUtil.drift(param1.fighterSide, param2);
            }
        }
        var _loc7_:*;
        var _loc6_:int;
        if ((_loc7_ = (_loc6_ = param1.turnResultInfo.changedHp) / param1.fighterInfo.maxHp > 0.33) == true) {
            ArenaUtil.vibrate(param2);
        }
    }

    public static function showAtkeeHpReduceSplash(param1:Fighter, param2:TurnResultInfo, param3:Number = 1):void {
        var _loc6_:HpDecreaseAnimation = null;
        var _loc4_:int = int(param1.fighterInfo.hp);
        var _loc5_:int;
        if ((_loc5_ = int(param2.changedHp * param3)) > 0) {
            if (param1.x == 0) {
                _loc6_ = ArenaAnimationManager.createAnimation(ArenaAnimationType.HPDECREASE, {
                    "reducedHp": _loc5_,
                    "initChangeHp": param2.changedHp,
                    "fighter": param1,
                    "fightSide": FightSide.LEFT,
                    "isBaoJi": param2.isCritical,
                    "skillTypeRelation": param2.skillTypeDelation
                }) as HpDecreaseAnimation;
            } else {
                _loc6_ = ArenaAnimationManager.createAnimation(ArenaAnimationType.HPDECREASE, {
                    "reducedHp": _loc5_,
                    "initChangeHp": param2.changedHp,
                    "fighter": param1,
                    "fightSide": FightSide.RIGHT,
                    "isBaoJi": param2.isCritical,
                    "skillTypeRelation": param2.skillTypeDelation
                }) as HpDecreaseAnimation;
            }
        } else if (_loc5_ == 0) {
            if (param2.atkTimes == 0) {
                if (param1.x == 0) {
                    ArenaAnimationManager.createAnimation(ArenaAnimationType.MISS, {"side": FightSide.LEFT});
                } else {
                    ArenaAnimationManager.createAnimation(ArenaAnimationType.MISS, {"side": FightSide.RIGHT});
                }
            } else if (param1.x == 0) {
                ArenaAnimationManager.createAnimation(ArenaAnimationType.ABSORT, {"side": FightSide.LEFT});
            } else {
                ArenaAnimationManager.createAnimation(ArenaAnimationType.ABSORT, {"side": FightSide.RIGHT});
            }
        }
    }

    public static function showBuffDisabledAnimation(param1:Vector.<FighterBuffInfo>, param2:int):void {
        var _loc3_:BuffDisabledAnimation = null;
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            if (BuffDisabledAnimation.BUFF_ID_LIST.indexOf(param1[_loc4_].buffId) != -1) {
                _loc3_ = ArenaAnimationManager.createAnimation(ArenaAnimationType.BUFF_DISABLE, {
                    "buffId": param1[_loc4_].buffId,
                    "side": param2
                }) as BuffDisabledAnimation;
                TweenNano.delayedCall(_loc4_ * 0.5, _loc3_.play);
            }
            _loc4_++;
        }
    }

    public static function getAnimation(param1:String):Class {
        if (_animationPool == null) {
            initAnimation();
        }
        return _animationPool.getValue(param1);
    }

    public static function createAnimation(param1:String, param2:Object = null, param3:Function = null, param4:Object = null):IArenaAnimation {
        var _loc6_:IArenaAnimation;
        var _loc5_:Class;
        if ((_loc6_ = new (_loc5_ = getAnimation(param1))()) != null) {
            _loc6_.addEventListener(ArenaAnimationEvent.EVT_END, onAnimationEnd);
            _loc6_.initData(param2);
            _loc6_.onComplete = param3;
            _loc6_.completeParams = param4;
            _par.addChild(_loc6_ as DisplayObject);
            _loc6_.play();
            return _loc6_;
        }
        throw new Error("阿嗲你个娘列,没有这个动画的！！" + param1);
    }

    private static function onAnimationEnd(param1:ArenaAnimationEvent):void {
        var _loc2_:IArenaAnimation = param1.currentTarget as IArenaAnimation;
        _loc2_.removeEventListener(ArenaAnimationEvent.EVT_END, onAnimationEnd);
        DisplayObjectUtil.removeFromParent(_loc2_ as DisplayObject);
        if (_loc2_.onComplete != null) {
            if (_loc2_.completeParams != null) {
                _loc2_.onComplete(_loc2_.completeParams);
            } else {
                _loc2_.onComplete();
            }
        }
        _loc2_.dispose();
    }

    public static function fighterPresentAnimation(param1:Fighter, param2:ArenaDataInfo, param3:Function, param4:Object = null):void {
        var onFighterPresent:Function = null;
        var targetY:Number = NaN;
        var fighter:Fighter = param1;
        var arenaData:ArenaDataInfo = param2;
        var onAnimationEnd:Function = param3;
        var onAnimationEndParams:Object = param4;
        onFighterPresent = function ():void {
            fighter.visible = true;
            fighter.playFighterSound();
        };
        var animation:PresentAnimation = ArenaAnimationManager.createAnimation(ArenaAnimationType.PRESENT, {"onFighterPresentFun": onFighterPresent}, onAnimationEnd, onAnimationEndParams) as PresentAnimation;
        if (arenaData.isDoubleMode) {
            if (fighter.fighterInfo.position == FightPostion.SUB) {
                animation.scaleX = animation.scaleY = Fighter.FIX_SCALE;
                animation.x = (1 - Fighter.FIX_SCALE) * LayerManager.root.width / 2;
                targetY = (1 - Fighter.FIX_SCALE) * LayerManager.root.height / 2;
                targetY += Fighter.SUB_FIGHTER_Y * Fighter.FIX_SCALE;
                animation.y = targetY;
            } else {
                animation.y = Fighter.MAIN_FIGHTER_Y;
            }
        }
    }

    public static function showWaiting(param1:uint):void {
        if (_waitingAnimation != null) {
            hideWaiting();
        }
        if (FightMode.isPVPMode(param1)) {
            _waitingAnimation = ArenaAnimationManager.createAnimation(ArenaAnimationType.WAITING);
        }
    }

    public static function hideWaiting():void {
        if (_waitingAnimation != null) {
            _waitingAnimation.dispose();
            _waitingAnimation = null;
        }
    }

    public static function showCountDown(param1:uint, param2:*):void {
        var onCountDownEnd:Function = null;
        var fightMode:uint = param1;
        var controlPanel:* = param2;
        onCountDownEnd = function ():void {
            controlPanel.automate();
        };
        abortCountDown();
        _countDownAnimation = ArenaAnimationManager.createAnimation(ArenaAnimationType.COUNTDOWN, null, onCountDownEnd);
    }

    public static function showCountDownNew(param1:uint, param2:NewFightControlPanel):void {
        var onCountDownEnd:Function = null;
        var fightMode:uint = param1;
        var controlPanel:NewFightControlPanel = param2;
        onCountDownEnd = function ():void {
            controlPanel.automate();
        };
        abortCountDown();
        _countDownAnimation = ArenaAnimationManager.createAnimation(ArenaAnimationType.COUNTDOWN, null, onCountDownEnd);
    }

    public static function abortCountDown():void {
        if (_countDownAnimation != null) {
            _countDownAnimation.dispose();
            _countDownAnimation = null;
        }
    }

    public static function showIndiator(param1:Fighter):void {
        hideIndiator();
        _indicatorAnimation = ArenaAnimationManager.createAnimation(ArenaAnimationType.INDICATOR) as IndicatorAnimation;
        _indicatorAnimation.x = param1.x + 200 * param1.scaleX;
        _indicatorAnimation.y = param1.y + 80 * param1.scaleY;
    }

    public static function hideIndiator():void {
        if (_indicatorAnimation != null) {
            _indicatorAnimation.stopPlay();
            _indicatorAnimation = null;
        }
    }
}
}
