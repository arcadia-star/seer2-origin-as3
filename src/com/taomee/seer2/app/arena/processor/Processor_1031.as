package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
import com.taomee.seer2.app.arena.animation.ArenaAnimationType;
import com.taomee.seer2.app.arena.util.FightState;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class Processor_1031 extends ArenaProcessor {

    public static var CATCHING:Boolean = false;


    private var _catchFighterId:uint;

    public function Processor_1031(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_CATCH_PET_1031, this.processor);
        Connection.addErrorHandler(CommandSet.FIGHT_CATCH_PET_1031, this.onFighterCatchError);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        this._catchFighterId = _loc2_.readUnsignedInt();
        if (!CATCHING) {
            CATCHING = true;
            if (_loc3_ != 0 && this._catchFighterId != 0) {
                if (_loc3_ == 1 && this._catchFighterId == 1) {
                    fightController.changeFighterState(FightState.CATCH_FIGHTER_SUCCESS);
                    ArenaAnimationManager.createAnimation(ArenaAnimationType.CATCHPETSUCCESS, {
                        "target": this._catchFighterId,
                        "onCatchSuccessFun": this.onCatchSuccess
                    }, this.onVirtualCatchAnimationEnd);
                } else {
                    fightController.changeFighterState(FightState.CATCH_FIGHTER_SUCCESS);
                    ArenaAnimationManager.createAnimation(ArenaAnimationType.CATCHPETSUCCESS, {
                        "target": this._catchFighterId,
                        "onCatchSuccessFun": this.onCatchSuccess
                    }, this.onCatchAnimationEnd);
                    arenaUIController.showSkillPanel();
                }
            } else {
                fightController.changeFighterState(FightState.CATCH_FIGHTER_FAILED);
                ArenaAnimationManager.createAnimation(ArenaAnimationType.CATCHPETFAIL, {"target": this._catchFighterId}, this.onCatchAnimationEnd);
                arenaUIController.showSkillPanel();
            }
            return;
        }
        throw new Error("在扑捉过程中多次收到扑捉命令!");
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_CATCH_PET_1031, this.processor);
        Connection.removeErrorHandler(CommandSet.FIGHT_CATCH_PET_1031, this.onFighterCatchError);
    }

    private function onFighterCatchError(param1:MessageEvent):void {
        if (param1.message.statusCode == 16) {
            AlertManager.showAlert("不能捕捉精灵");
        }
    }

    private function onCatchSuccess():void {
        fightController.rightMainFighter.deactive();
        DisplayObjectUtil.removeFromParent(fightController.rightMainFighter);
    }

    private function onVirtualCatchAnimationEnd():void {
        CATCHING = false;
        fightController.parseTurnResult();
    }

    private function onCatchAnimationEnd():void {
        var _loc1_:Object = null;
        CATCHING = false;
        if (fightController.state == FightState.CATCH_FIGHTER_SUCCESS) {
            _loc1_ = {
                "petId": this._catchFighterId,
                "closeCallback": fightController.exitFight
            };
            ModuleManager.toggleModule(URLUtil.getAppModule("PetCatchPanel"), "正在打开捕捉成功面板...", _loc1_);
        } else if (fightController.state == FightState.CATCH_FIGHTER_FAILED) {
            fightController.parseTurnResult();
        }
    }
}
}
