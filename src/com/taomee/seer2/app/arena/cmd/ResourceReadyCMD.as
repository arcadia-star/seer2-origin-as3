package com.taomee.seer2.app.arena.cmd {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;

public class ResourceReadyCMD implements IArenaBaseCMD {


    private var _fightMode:uint;

    public function ResourceReadyCMD(param1:uint) {
        super();
        this._fightMode = param1;
    }

    public function init():void {
    }

    public function send():void {
        var _loc1_:int = FightManager.currentFightRecord.initData.hasOwnProperty("positionIndex") ? int(FightManager.currentFightRecord.initData.positionIndex) : 0;
        Connection.send(CommandSet.FIGHT_RES_READY_1501, _loc1_);
        ArenaAnimationManager.showWaiting(this._fightMode);
    }

    public function dispose():void {
    }
}
}
