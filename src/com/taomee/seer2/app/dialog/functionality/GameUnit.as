package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.constant.FunctionalityPriority;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class GameUnit extends BaseUnit {


    private var _gameId:String;

    public function GameUnit() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.type = FunctionalityType.GAME;
        this.priority = FunctionalityPriority.GAME;
    }

    override protected function addIcon():void {
        _icon = UIManager.getSprite("UI_DialogGame");
        addChild(_icon);
    }

    override protected function onBtnClick(param1:MouseEvent):void {
        this._gameId = this.params;
        ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"), "正在打开" + "小游戏" + "...", {"gameId": this._gameId});
        DialogPanel.hide();
    }
}
}
