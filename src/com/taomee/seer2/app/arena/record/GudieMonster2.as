package com.taomee.seer2.app.arena.record {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class GudieMonster2 implements IFightRequest {


    private var _recordData:FightRecordData;

    private var _onStart:Function;

    private var _onError:Function;

    private var _gudieIndex:int;

    public function GudieMonster2(param1:Function, param2:Function, param3:int) {
        super();
        this._onStart = param1;
        this._onError = param2;
        this._gudieIndex = param3;
    }

    public function get fightRecordData():FightRecordData {
        return this._recordData;
    }

    public function get uid():Number {
        return this._recordData.fightUniqueID;
    }

    public function startFight(param1:Object, param2:ButtonPanelData, param3:Number = -1):void {
        if (param3 == -1) {
            param3 = UUID.getUnique();
        }
        this._recordData = new FightRecordData(param3, param1, param2);
        if (this._onStart != null) {
            this._onStart();
        }
        FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_SUCCESS));
        AlertManager.closeAllPopUp();
        switch (this._gudieIndex) {
            case 0:
                SceneManager.changeScene(SceneType.GUDIE_ARENA2, SceneManager.active.fightMapId);
                break;
            case 1:
                SceneManager.changeScene(SceneType.GUDIE_ARENA3, SceneManager.active.fightMapId);
                break;
            case 2:
                SceneManager.changeScene(SceneType.GUDIE_ARENA4, SceneManager.active.fightMapId);
                break;
            case 3:
                SceneManager.changeScene(SceneType.GUDIE_ARENA5, SceneManager.active.fightMapId);
                break;
            case 4:
                SceneManager.changeScene(SceneType.GUIDE_NEW_ARENA1, SceneManager.active.fightMapId);
                break;
            case 5:
                SceneManager.changeScene(SceneType.GUIDE_NEW_ARENA2, SceneManager.active.fightMapId);
                break;
            case 6:
                SceneManager.changeScene(SceneType.GUIDE_NEW_ARENA3, SceneManager.active.fightMapId);
        }
    }
}
}
