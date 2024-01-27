package com.taomee.seer2.app.entity {
import com.taomee.seer2.app.entity.pool.TeleportResourcePool;

import flash.display.MovieClip;

public class DreamTeleport extends Teleport {


    private var _spot:MovieClip;

    public function DreamTeleport() {
        super();
    }

    override protected function addSpot():void {
        this._spot = TeleportResourcePool.checkDreamTeleportOut();
        addChild(this._spot);
    }

    public function get spot():MovieClip {
        return this._spot;
    }

    override protected function checkPortInPool():void {
        TeleportResourcePool.checkDreamTeleportIn(this._spot);
    }

    override public function dispose():void {
        super.dispose();
        this._spot = null;
    }
}
}
