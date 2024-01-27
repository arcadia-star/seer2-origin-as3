package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.gameRule.nono.time.NonoButlerController;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

import org.taomee.bean.BaseBean;

public class NonoTimeButlerBean extends BaseBean {


    public function NonoTimeButlerBean() {
        super();
        Connection.addCommandListener(CommandSet.NONO_TIME_BUTLER_UPDATE_1197, this.onUpdate);
        finish();
    }

    private function onUpdate(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        NonoButlerController.getInstance().update(_loc2_);
    }
}
}
