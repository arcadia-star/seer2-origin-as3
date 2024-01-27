package com.taomee.seer2.app.firstTeach.guide {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.cmd.GudieArenaResourceLoadCMD;
import com.taomee.seer2.app.arena.controller.FightWeatherController;
import com.taomee.seer2.app.arena.controller.IArenaUIController;
import com.taomee.seer2.app.arena.controller.IFightController;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.resource.ArenaResourceLoader;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.firstTeach.guide.controller.GudieArenaUIController;
import com.taomee.seer2.app.firstTeach.guide.controller.GudieFightController;
import com.taomee.seer2.app.popup.AlertManager;

import flash.utils.setTimeout;

public class GudieArenaScene extends ArenaScene {


    private var _arenaData:ArenaDataInfo;

    private var _fightController:IFightController;

    private var _arenaUIController:IArenaUIController;

    private var _weatherController:FightWeatherController;

    private var arenaResourceLoader:ArenaResourceLoader;

    private var interruptFlag:Boolean = false;

    public function GudieArenaScene(param1:int) {
        this._arenaData = new ArenaDataInfo();
        super(param1);
    }

    override protected function syncToServer():void {
        completeMap();
        DialogPanel.hide();
        new GudieArenaResourceLoadCMD(this._arenaData, this.onGetInfoComplete).send();
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
            this._arenaUIController = new GudieArenaUIController(this);
            this._fightController = new GudieFightController(this);
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
