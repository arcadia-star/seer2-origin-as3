package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.events.ActorEvent;
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.arena.data.RevenueInfo;
import com.taomee.seer2.app.gameRule.util.MapUserStatusType;
import com.taomee.seer2.app.miniGame.MiniGameEvent;
import com.taomee.seer2.app.miniGame.MiniGameManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.PetPowerUpdate;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;

import org.taomee.bean.BaseBean;
import org.taomee.manager.EventManager;
import org.taomee.utils.Tick;

public class PetOnhookBean extends BaseBean {

    private static const REFRESH_EXP_FRAME:uint = 15000;

    private static const UP_EXP_MIN_NUM:uint = 10;

    private static const UP_EXP_MAX_NUM:uint = 50;


    private var _user:Actor;

    private var _isNewPet:Boolean;

    public function PetOnhookBean() {
        super();
        Connection.addCommandListener(CommandSet.GET_IS_START_ONHOOK_1212, this.onStopOnhook);
        Connection.addErrorHandler(CommandSet.GET_IS_START_ONHOOK_1212, this.onGetLevelError);
        EventManager.addEventListener(ActorEvent.ACTOR_ONHOOK_WALK, this.onHookOverHandler);
        MiniGameManager.addEventListener(MiniGameEvent.START_PLAY_GAME, this.onStartMinGame);
        MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME, this.onEndtMinGame);
        PetInfoManager.addEventListener(PetInfoEvent.PET_SET_FOLLOW, this.onNewFollowingPet);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.onMapSwitchStart);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
        this._user = ActorManager.getActor();
        this._user.addEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        PetInfoManager.addEventListener(PetInfoEvent.HOOK_PET_EXPERENCE_CHANGE, this.onPetExpChange);
        finish();
    }

    private function onMapSwitchStart(param1:SceneEvent):void {
        this.stopHook();
    }

    private function onHookOverHandler(param1:ActorEvent):void {
        this.stopHook();
    }

    private function onStartMinGame(param1:MiniGameEvent):void {
        this.stopHook();
    }

    private function onEndtMinGame(param1:MiniGameEvent):void {
        this.isActorCanHook();
    }

    private function onMapSwitchComplete(param1:SceneEvent):void {
        this.isActorCanHook();
    }

    private function onActorMoveFinished(param1:MoveEvent):void {
        this.isActorCanHook();
    }

    private function onNewFollowingPet(param1:PetInfoEvent):void {
        this._isNewPet = true;
        if (this._user.getInfo()._isOnhook == MapUserStatusType.NORMAL) {
            this.isActorCanHook();
        } else {
            this.stopHook();
        }
    }

    private function stopHook():void {
        Tick.instance.removeTimeout(this.onStartPlay);
        Tick.instance.removeTimeout(this.onStartSend);
        if (this._user.getInfo()._isOnhook == MapUserStatusType.ONHOOK) {
            Connection.send(CommandSet.GET_IS_START_ONHOOK_1212, 0);
        } else if (this._user.getInfo()._isPlanHook == MapUserStatusType.PLANHOOK) {
            this._user.getInfo()._isPlanHook = MapUserStatusType.NORMAL;
            if (this._user.getFollowingPet().getInfo()) {
                this._user.getFollowingPet().addIsShow = false;
                this._user.getFollowingPet().addokIsShow = false;
                if (this._isNewPet == true) {
                    this._isNewPet = false;
                    this.isActorCanHook();
                }
            }
        }
    }

    private function isActorCanHook():void {
        var _loc1_:uint = 0;
        if (this._user.getFollowingPet().getInfo()) {
            _loc1_ = this._user.getFollowingPet().getInfo().level;
            if (this._user.getInfo()._isOnhook == MapUserStatusType.NORMAL && this._user.hasFollowingPet() && _loc1_ < 100 && SceneManager.currentSceneType != SceneType.ARENA && QuestManager.isFreshQuestComplete() && QuestManager.isCompleteGudieTask()) {
                this._user.getFollowingPet().addIsShow = false;
                Tick.instance.removeTimeout(this.onStartPlay);
                Tick.instance.addTimeout(5000, this.onStartPlay);
            }
        }
    }

    private function onStartPlay():void {
        this._user.getInfo()._isPlanHook = MapUserStatusType.PLANHOOK;
        this._user.getFollowingPet().addIsShow = true;
        Tick.instance.removeTimeout(this.onStartSend);
        Tick.instance.addTimeout(10000, this.onStartSend);
    }

    private function onStartSend():void {
        if (this._user.getFollowingPet().getInfo()) {
            Connection.send(CommandSet.GET_IS_START_ONHOOK_1212, 1);
        }
    }

    private function onStopOnhook(param1:MessageEvent):void {
        var _loc2_:int = int(param1.message.getRawData().readUnsignedInt());
        if (_loc2_ < 0) {
            this._user.getInfo()._isOnhook = MapUserStatusType.ONHOOK;
            this._user.getInfo()._isPlanHook = MapUserStatusType.NORMAL;
            Tick.instance.addRender(this.onTimer, REFRESH_EXP_FRAME);
        } else {
            this._user.getInfo()._isOnhook = MapUserStatusType.NORMAL;
            this._user.getInfo()._isPlanHook = MapUserStatusType.NORMAL;
            if (this._user.getFollowingPet().getInfo()) {
                this._user.getFollowingPet().addIsShow = false;
                Tick.instance.removeRender(this.onTimer);
            }
            if (this._isNewPet) {
                this._isNewPet = false;
                this.isActorCanHook();
            }
        }
    }

    private function onTimer(param1:int):void {
        this.upExp();
    }

    private function upExp():void {
        var _loc1_:uint = uint(TimeManager.getAvailableTime());
        if (_loc1_ <= 0) {
            this._user.getFollowingPet().addLevels = UP_EXP_MIN_NUM;
        } else {
            this._user.getFollowingPet().addLevels = UP_EXP_MAX_NUM;
        }
    }

    private function onGetLevelError(param1:MessageEvent):void {
        if (param1.message.statusCode == 201) {
        }
    }

    private function onPetExpChange(param1:PetInfoEvent):void {
        var obj:Object = null;
        var evt:PetInfoEvent = param1;
        var resultInfo:FightResultInfo = evt.content.resultInfo;
        var revenueInfo:RevenueInfo = evt.content.revenueInfo;
        if (this._user.getFollowingPet().getInfo()) {
            if (revenueInfo) {
                if (revenueInfo.fighterRevenueInfoVec.length > 0) {
                    obj = new Object();
                    obj.petInfoVec = PetInfoManager.getAllBagPetInfo();
                    obj.revenueInfo = revenueInfo;
                    obj.resultInfo = resultInfo;
                    ModuleManager.addEventListener("OnHookResultPanel", ModuleEvent.DISPOSE, function onHookDispose(param1:ModuleEvent):void {
                        ModuleManager.removeEventListener("OnHookResultPanel", ModuleEvent.DISPOSE, onHookDispose);
                        EventManager.dispatchEvent(new Event(PetPowerUpdate.PET_UPDATE));
                    });
                    ModuleManager.showModule(URLUtil.getAppModule("OnHookResultPanel"), "正在打开战斗结算面板...", obj);
                }
            }
        }
    }
}
}
