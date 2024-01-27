package com.taomee.seer2.app.dream {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.net.MessageEvent;

public class DreamSpawnedPet extends SpawnedPet {


    private var _dreamNpcType:uint;

    private var _fightMapType:uint;

    private var _taskId:uint;

    public function DreamSpawnedPet(param1:int, param2:int, param3:int, param4:Object) {
        super(param1, param2, param3);
        this._dreamNpcType = param4.dreamNpcType;
        this._fightMapType = param4.fightMapType;
        this._taskId = param4.taskId;
    }

    override protected function startFight():void {
        Connection.addErrorHandler(CommandSet.GET_DREAM_REWAED_1053, this.onGetDreamRewardError);
        Connection.addCommandListener(CommandSet.GET_DREAM_REWAED_1053, this.onMessage);
        Connection.send(CommandSet.GET_DREAM_REWAED_1053, this._dreamNpcType, this._taskId);
    }

    private function onMessage(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.GET_DREAM_REWAED_1053, this.onGetDreamRewardError);
        Connection.removeCommandListener(CommandSet.GET_DREAM_REWAED_1053, this.onMessage);
        DreamManager.addDreamNum();
    }

    private function onGetDreamRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.GET_DREAM_REWAED_1053, this.onGetDreamRewardError);
        Connection.removeCommandListener(CommandSet.GET_DREAM_REWAED_1053, this.onMessage);
        if (param1.message.statusCode == 66) {
            AlertManager.showAlert("嘘，让它做个好梦吧！今天就别打扰喽！");
            DreamManager.addDreamNum(DreamManager.DREAM_LIMIT);
        }
    }
}
}
