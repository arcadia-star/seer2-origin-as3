package com.taomee.seer2.app.mail {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.log.Logger;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

import org.taomee.bean.BaseBean;

public class GmailManager extends BaseBean {

    private static var _logger:Logger;


    public function GmailManager() {
        super();
        _logger = Logger.getLogger("GmailManager");
        Connection.addCommandListener(CommandSet.NEW_MAIL_ARRIVE_1258, this.onNewMail);
        finish();
    }

    private function onNewMail(param1:MessageEvent):void {
        var _loc2_:GmailDataObj = new GmailDataObj();
        var _loc3_:IDataInput = param1.message.getRawData();
        _loc2_.mailId = _loc3_.readUnsignedInt();
        _loc2_.rawSendTime = _loc3_.readUnsignedInt();
        _loc2_.readSymble = Boolean(_loc3_.readUnsignedInt());
        _loc2_.type = _loc3_.readUnsignedInt();
        _loc2_.attachmentSymble = Boolean(_loc3_.readUnsignedInt());
        _loc2_.senderId = _loc3_.readUnsignedInt();
        _loc2_.senderName = _loc3_.readUTFBytes(_loc3_.readUnsignedInt());
        _loc2_.mailTitle = _loc3_.readUTFBytes(_loc3_.readUnsignedInt());
        GmailDataManager.getInstance().saveSingleData(_loc2_);
    }
}
}
