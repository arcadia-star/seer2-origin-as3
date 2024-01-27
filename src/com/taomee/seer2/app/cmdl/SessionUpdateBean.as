package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.manager.GlobalsManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.Util;

import flash.utils.ByteArray;

import org.taomee.bean.BaseBean;
import org.taomee.utils.Tick;

public class SessionUpdateBean extends BaseBean {

    private static const STEP:uint = 1000 * 60 * 5;


    public function SessionUpdateBean() {
        super();
        Tick.instance.addRender(this.getSession, STEP);
        this.getSession();
        finish();
    }

    private function getSession(param1:uint = 0):void {
        Connection.addCommandListener(CommandSet.SESSION_1156, this.onGetSession);
        Connection.send(CommandSet.SESSION_1156, ClientConfig.productID);
    }

    private function onGetSession(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.SESSION_1156, this.onGetSession);
        var _loc2_:ByteArray = param1.message.getRawData();
        var _loc3_:String = String(Util.getSessionString(_loc2_));
        GlobalsManager.session = _loc3_;
    }
}
}
