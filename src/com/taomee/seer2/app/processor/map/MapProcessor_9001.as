package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.core.map.MapModel;

import flash.events.MouseEvent;

public class MapProcessor_9001 extends MaiChapter3Map {


    public function MapProcessor_9001(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        fightId = 276;
        maxCount = 1;
        npcId = 148;
        super.init();
    }

    override protected function toFight(param1:MouseEvent):void {
        var _loc2_:ButtonPanelData = null;
        if (currentCount == maxCount) {
            _loc2_ = new ButtonPanelData();
            _loc2_.catchEnabled = false;
            FightManager.startFightBinaryWild(fightId, null, null, _loc2_);
        }
    }
}
}
