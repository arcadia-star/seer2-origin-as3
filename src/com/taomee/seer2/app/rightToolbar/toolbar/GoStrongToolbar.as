package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
import com.taomee.seer2.app.rightToolbar.RightToolbar;

import flash.events.MouseEvent;

public class GoStrongToolbar extends RightToolbar {


    public function GoStrongToolbar() {
        super();
    }

    override protected function onClick(param1:MouseEvent):void {
        NewGuidStatisManager.newPlayerStatisHandle(16);
        super.onClick(param1);
    }
}
}
