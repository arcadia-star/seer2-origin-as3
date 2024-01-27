package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

import org.taomee.bean.BaseBean;

public class ItemMaxNotifyListener extends BaseBean {


    public function ItemMaxNotifyListener() {
        super();
        Connection.addCommandListener(CommandSet.ITEM_MAX_NOTIFY_INFO_1200, this.onMessage);
        finish();
    }

    private function onMessage(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        AlertManager.showItemMaxAlert(_loc4_);
    }
}
}
