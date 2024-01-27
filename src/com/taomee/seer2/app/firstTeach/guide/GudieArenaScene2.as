package com.taomee.seer2.app.firstTeach.guide {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD2;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD3;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD4;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD5;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD6;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD7;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD8;
import com.taomee.seer2.app.arena.controller.FightWeatherController;
import com.taomee.seer2.app.arena.controller.IArenaUIController;
import com.taomee.seer2.app.arena.controller.IFightController;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.resource.ArenaResourceLoader;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.firstTeach.guide.controller.GudieArenaUIController2;
import com.taomee.seer2.app.firstTeach.guide.controller.GudieFightController2;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.utils.setTimeout;

public class GudieArenaScene2 extends ArenaScene {


    private var _arenaData:ArenaDataInfo;

    private var _fightController:IFightController;

    private var _arenaUIController:IArenaUIController;

    private var _weatherController:FightWeatherController;

    private var arenaResourceLoader:ArenaResourceLoader;

    private var interruptFlag:Boolean = false;

    public function GudieArenaScene2(param1:int) {
        this._arenaData = new ArenaDataInfo();
        super(param1);
    }

    override protected function syncToServer():void {
        completeMap();
        DialogPanel.hide();
        if (type == SceneType.GUDIE_ARENA2) {
            new GudieArenaResourceLoadCMD2(this._arenaData, this.onGetInfoComplete).send();
        } else if (type == SceneType.GUDIE_ARENA3) {
            new GudieArenaResourceLoadCMD3(this._arenaData, this.onGetInfoComplete).send();
        } else if (type == SceneType.GUDIE_ARENA4) {
            new GudieArenaResourceLoadCMD4(this._arenaData, this.onGetInfoComplete).send();
        } else if (type == SceneType.GUDIE_ARENA5) {
            new GudieArenaResourceLoadCMD5(this._arenaData, this.onGetInfoComplete).send();
        } else if (type == SceneType.GUIDE_NEW_ARENA1) {
            new GudieArenaResourceLoadCMD6(this._arenaData, this.onGetInfoComplete).send();
        } else if (type == SceneType.GUIDE_NEW_ARENA2) {
            new GudieArenaResourceLoadCMD7(this._arenaData, this.onGetInfoComplete).send();
        } else if (type == SceneType.GUIDE_NEW_ARENA3) {
            new GudieArenaResourceLoadCMD8(this._arenaData, this.onGetInfoComplete).send();
        }
    }

    private function onGetInfoComplete():void {
        this.arenaResourceLoader = ArenaResourceLoader.instance;
        ArenaResourceLoader.addLoadingBar();
        this.arenaResourceLoader.updateLoadingBarShowData(this.onArenaLoadingBarClose, this.leftTeam.mainFighterInfo, this.rightTeam.mainFighterInfo, this.leftTeam.subFighterInfo, this.rightTeam.subFighterInfo);
        setTimeout(this.startLoadingFightResource, 2500);
    }

    private function startLoadingFightResource():void {
        this.arenaResourceLoader.loadFightResource(this.leftTeam, this.rightTeam, this._arenaData);
    }

    private function onArenaLoadingBarClose():void {
        if (this.interruptFlag) {
            AlertManager.showAutoCloseAlert("对手已逃跑", 3, exitFight);
        } else {
            this._arenaUIController = new GudieArenaUIController2(this);
            this._fightController = new GudieFightController2(this);
            updateWeather(this._arenaData.fightWeather);
            this._arenaUIController.startActiveFighter();
            this._fightController.startFighter();
        }
        FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.FIGHT_LOADING_END));
    }

    override public function get fightController():IFightController {
        return this._fightController;
    }

    override public function get arenaUIController():IArenaUIController {
        return this._arenaUIController;
    }

    override public function get leftTeam():FighterTeam {
        return this._arenaData.leftTeam;
    }

    override public function get rightTeam():FighterTeam {
        return this._arenaData.rightTeam;
    }

    override public function get fightMode():uint {
        return this._arenaData.fightMode;
    }

    override public function get arenaData():ArenaDataInfo {
        return this._arenaData;
    }
}
}
