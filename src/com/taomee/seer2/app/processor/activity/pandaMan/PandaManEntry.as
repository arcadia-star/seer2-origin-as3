package com.taomee.seer2.app.processor.activity.pandaMan {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class PandaManEntry {


    private var _entryMC:MovieClip;

    public function PandaManEntry() {
        super();
    }

    public function setup():void {
        this._entryMC = SceneManager.active.mapModel.content["entryMC"];
        this.initEvent();
    }

    private function initEvent():void {
        this._entryMC.buttonMode = true;
        TooltipManager.addCommonTip(this._entryMC, "青竹迷境");
        this._entryMC.addEventListener(MouseEvent.CLICK, this.onEntry);
    }

    private function onEntry(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        ItemManager.requestEquipList(function ():void {
            if (ItemManager.getEquipItem(100648) == null) {
                noEntry();
            } else {
                entry();
            }
        });
    }

    private function noEntry():void {
        AlertManager.showAlert("你没有茅山穿越帽！不能进入青竹迷境！", function ():void {
            ModuleManager.showModule(URLUtil.getAppModule("PandaManEntryPanel"), "正在打开面板...");
        });
    }

    private function entry():void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("panda/pandaScreen0"), function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 1090);
        }, false, true);
    }

    public function dispose():void {
        this._entryMC = null;
    }
}
}
