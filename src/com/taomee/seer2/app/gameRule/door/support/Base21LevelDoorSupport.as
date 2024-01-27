package com.taomee.seer2.app.gameRule.door.support {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class Base21LevelDoorSupport implements IUpDoorSupport {

    public static const APPEAR_END_EVENT:String = "appear_end";

    public static const ESCAPE_END_EVENT:String = "escape_end";

    public static const APPEAR_STATUS:uint = 0;

    public static const STAND_STATUS:uint = 1;

    public static const ESCAPE_STATUS:uint = 2;


    protected var _supportInfo:DoorSupportInfo;

    protected var _map:MapModel;

    protected var _guard:MovieClip;

    protected var _guard_mc:MovieClip;

    protected var _doorLevel_MC:MovieClip;

    protected var _levelTip2:MovieClip;

    protected var _doorLevel:uint = 1;

    protected var _isGetServerGiveFlag:Boolean = false;

    private var _canLevelNow:Boolean = true;

    public function Base21LevelDoorSupport() {
        super();
    }

    public function get doorLevel():uint {
        return this._doorLevel;
    }

    public function init(param1:MapModel):void {
        this._canLevelNow = true;
        this._map = param1;
        this.initUI();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            this.dealWithFightResult(FightManager.fightWinnerSide);
        } else {
            this.setTrialLevel(this._supportInfo.currentDoorLevel);
        }
    }

    protected function dealWithFightResult(param1:uint):void {
    }

    protected function setTrialLevel(param1:uint):void {
        this._doorLevel = param1;
        this._guard_mc.addEventListener(APPEAR_END_EVENT, this.onGuardAppear);
        this.updateGuardStatus(APPEAR_STATUS);
        this._doorLevel_MC.gotoAndStop(this._doorLevel);
        this._levelTip2.gotoAndStop(this._doorLevel);
    }

    protected function onGuardClick(param1:MouseEvent):void {
    }

    protected function updateGuardStatus(param1:uint):void {
        this._guard.gotoAndStop(Door21LevelUtil.getGuardIndex(this._doorLevel) + 1);
        this._guard_mc.gotoAndPlay(Door21LevelUtil.getGuardLabel(this._doorLevel, param1));
    }

    public function dispose():void {
        this._doorLevel_MC.gotoAndStop(this._doorLevel_MC.totalFrames);
        this._doorLevel_MC = null;
        this._levelTip2.gotoAndStop(this._levelTip2.totalFrames);
        this._levelTip2 = null;
        this._guard_mc.gotoAndStop(this._guard_mc.totalFrames);
        this._guard.removeEventListener(MouseEvent.CLICK, this.onGuardClick);
        this._guard_mc.removeEventListener(MouseEvent.CLICK, this.onGuardClick);
        this._guard = null;
    }

    protected function initUI():void {
        this._doorLevel_MC = this._map.front["levelTip"];
        this._doorLevel_MC.gotoAndStop(this._doorLevel);
        this._levelTip2 = this._map.front["levelTip2"];
        this._guard_mc = this._map.front["guard"];
        this._guard = this._guard_mc["guard"];
        this._guard_mc.visible = true;
        this._guard.gotoAndStop(Door21LevelUtil.getGuardIndex(this._doorLevel) + 1);
    }

    private function onGuardAppear(param1:Event):void {
        this._guard_mc.removeEventListener(APPEAR_END_EVENT, this.onGuardAppear);
        this._guard.buttonMode = true;
        this._guard.useHandCursor = true;
        if (this._supportInfo.doorRule == DoorRule.ATLETICO_DOOR) {
            this._guard_mc.buttonMode = true;
            this._guard_mc.useHandCursor = true;
            this._guard_mc.addEventListener(MouseEvent.CLICK, this.onGuardClick);
        } else {
            this._guard.addEventListener(MouseEvent.CLICK, this.onGuardClick);
        }
    }

    public function reset():void {
        this._doorLevel = 1;
    }

    protected function clearServerGive():void {
    }

    public function get supportInfo():DoorSupportInfo {
        return this._supportInfo;
    }

    public function get canLevelNow():Boolean {
        return this._canLevelNow;
    }

    public function set canLevelNow(param1:Boolean):void {
        this._canLevelNow = param1;
    }
}
}
