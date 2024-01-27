package com.taomee.seer2.app.entity.handler {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class HandlerVipPanelSelect extends HandlerEntityClick {


    public function HandlerVipPanelSelect() {
        super();
    }

    override public function initData(param1:XML):void {
    }

    override protected function action():void {
        if (0 == ActorManager.actorInfo.vipInfo.vipFlag) {
            ModuleManager.showModule(URLUtil.getAppModule("NewVipPanel"), "打开米币商城面板");
        } else {
            ModuleManager.showModule(URLUtil.getAppModule("ShopPanel"), "打开Vip充值面板");
        }
    }
}
}
