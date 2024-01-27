package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.geom.Point;

public class MapProcessor_3839 extends MapProcessor {


    public function MapProcessor_3839(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.newSendNovice("2015活动", "年兽界王神", "进入年兽场景");
    }

    override public function dispose():void {
        super.dispose();
        SeatTipsManager.removeSeat(new Point(590, 100), 3839);
    }
}
}
