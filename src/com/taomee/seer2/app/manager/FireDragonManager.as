package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class FireDragonManager {

    private static var _fireDragonBtn:SimpleButton;

    private static var endTime:uint = new Date(2012, 0, 20, 15, 30).getTime() / 1000;


    public function FireDragonManager() {
        super();
    }

    public static function show():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
        if (!QuestManager.isFreshQuestComplete()) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
        }
    }

    private static function onSwitchComplete(param1:SceneEvent):void {
        processVisible();
    }

    private static function onQuestComplete(param1:QuestEvent):void {
        processVisible();
    }

    private static function processVisible():void {
        if (canShow()) {
            showFireDragonBtn();
        } else {
            hideFireDragonBtn();
        }
    }

    private static function canShow():Boolean {
        var _loc1_:Boolean = QuestManager.isFreshQuestComplete();
        var _loc2_:* = !(SceneManager.currentSceneType == SceneType.ARENA || SceneManager.active.mapID >= 400 && SceneManager.active.mapID <= 450);
        var _loc3_:* = TimeManager.getServerTime() < endTime;
        var _loc4_:* = SceneManager.active.type != SceneType.HOME;
        return _loc1_ && _loc2_ && _loc3_ && _loc4_ && DreamManager.isDreamMap() == false;
    }

    public static function hide():void {
        processVisible();
    }

    private static function hideFireDragonBtn():void {
        DisplayObjectUtil.removeFromParent(_fireDragonBtn);
    }

    private static function showFireDragonBtn():void {
        if (_fireDragonBtn == null) {
            _fireDragonBtn = UIManager.getButton("UI_ToolBar_FireDragonBtn");
            TooltipManager.addCommonTip(_fireDragonBtn, "光伊特的新春礼物");
            _fireDragonBtn.addEventListener(MouseEvent.CLICK, onFireDragonClick);
        }
        _fireDragonBtn.x = 892;
        _fireDragonBtn.y = 430;
        LayerManager.uiLayer.addChild(_fireDragonBtn);
    }

    private static function onFireDragonClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("LoongGoToMapPanel"), "正在打开光伊特的新春礼物面板...");
    }
}
}
