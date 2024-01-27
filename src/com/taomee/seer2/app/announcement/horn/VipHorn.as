package com.taomee.seer2.app.announcement.horn {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class VipHorn extends AbstractHorn {


    public function VipHorn(param1:HornInfo) {
        param1 = new HornInfo();
        param1.content = "开通VIP，商城装扮永久不过期！<font color=\'#00ffff\'><a>【点击有奖哦】</a></font>";
        super(param1);
    }

    override public function onClick(param1:MouseEvent):void {
        Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        Connection.send(CommandSet.DIGGER_MINE_1060, 118);
        ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"), "正在打开Vip面板...", {"currentTab": 5});
        super.onClick(param1);
        this.onClose(new MouseEvent(MouseEvent.CLICK));
    }

    private function onGerRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
    }

    private function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
        _loc2_.showResult(true);
    }

    override public function onClose(param1:MouseEvent):void {
        HornControl._isShowHorn = false;
        super.onClose(param1);
    }
}
}
