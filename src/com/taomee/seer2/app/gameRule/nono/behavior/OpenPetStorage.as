package com.taomee.seer2.app.gameRule.nono.behavior {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.gameRule.nono.core.INonoBehavior;
import com.taomee.seer2.app.gameRule.nono.core.NonoInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class OpenPetStorage implements INonoBehavior {


    private var _userInfo:UserInfo;

    private var _nonoInfo:NonoInfo;

    private var _iconButton:SimpleButton;

    public function OpenPetStorage(param1:NonoInfo, param2:UserInfo) {
        super();
        this._nonoInfo = param1;
        this._userInfo = param2;
    }

    public function get tipDescription():String {
        return "精灵仓库（VIP）";
    }

    public function get nonoX():Number {
        return 45;
    }

    public function get nonoY():Number {
        return -35;
    }

    public function get iconButton():SimpleButton {
        return this._iconButton;
    }

    public function set iconButton(param1:SimpleButton):void {
        if (this._iconButton) {
            this._iconButton.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._iconButton = param1;
        this._iconButton.addEventListener(MouseEvent.CLICK, this.onClick);
        TooltipManager.addCommonTip(this._iconButton, this.tipDescription);
    }

    private function onClick(param1:MouseEvent):void {
        var onConfirmHandler:Function = null;
        var event:MouseEvent = param1;
        onConfirmHandler = function ():void {
            VipManager.navigateToPayPage();
        };
        if (this._userInfo.vipInfo.isVip() == false) {
            AlertManager.showConfirm("开通VIP才能开启仓库哦！要现在开通吗？", onConfirmHandler);
        } else {
            this.clickHandler();
        }
    }

    public function clickHandler():void {
        if (this._nonoInfo == ActorManager.actorInfo.getNonoInfo()) {
            ModuleManager.toggleModule(URLUtil.getAppModule("PetStoragePanel"), "正在打开精灵仓库...");
        }
    }

    public function dispose():void {
        if (this._iconButton) {
            this._iconButton.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._iconButton = null;
    }
}
}
