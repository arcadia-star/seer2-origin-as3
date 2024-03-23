package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.app.net.Command;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.ui.UIManager;

import flash.events.MouseEvent;

public class YingYingGuaiUnit extends BaseUnit {

    public function YingYingGuaiUnit() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.type = FunctionalityType.YingYingGuai;
    }

    override protected function addIcon():void {
        _icon = UIManager.getSprite("UI_DialogReward");
        addChild(_icon);
    }

    /**
     * 嘤嘤怪赐予你力量！
     */
    override protected function onBtnClick(param1:MouseEvent):void {
        var split:Array = params.split(",");
        if (split.length == 0) {
            AlertManager.showAlert("配置错误，请联系嘤嘤怪！");
            return;
        }
        var cmd:uint = uint(split[0]);
        var data:LittleEndianByteArray = new LittleEndianByteArray();
        for (var i:int = 1; i < split.length; i++) {
            data.writeUnsignedInt(uint(split[i]));
        }

        var command:Command = Command.getCommand(cmd);
        if (command == null) {
            AlertManager.showAlert("协议错误，请联系嘤嘤怪！");
            return;
        }

        Connection.send(command, data);
        DialogPanel.hide("");
    }
}
}
