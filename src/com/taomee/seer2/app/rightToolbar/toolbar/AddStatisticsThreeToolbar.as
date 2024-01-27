package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.rightToolbar.RightToolbar;

import flash.events.MouseEvent;

public class AddStatisticsThreeToolbar extends RightToolbar {


    public function AddStatisticsThreeToolbar() {
        super();
    }

    override protected function onClick(param1:MouseEvent):void {
        StatisticsManager.newSendNovice("2015活动", "ICON点击", "点击45号ICON");
        super.onClick(param1);
    }
}
}
