package com.taomee.seer2.app.home.panel {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.group.UserGroupCookie;
import com.taomee.seer2.app.controls.LeftMinorToolBar;
import com.taomee.seer2.app.controls.MapTitlePanel;
import com.taomee.seer2.app.controls.MinorToolBar;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.controls.ProcessBuddyPanel;
import com.taomee.seer2.app.controls.TestAssistPanel;
import com.taomee.seer2.app.home.data.HomeInfo;
import com.taomee.seer2.app.home.panel.bar.HomeFeatureBar;
import com.taomee.seer2.app.home.panel.bar.HomeSideBar;
import com.taomee.seer2.app.home.panel.buddy.HomeBuddyPanel;
import com.taomee.seer2.app.home.panel.buddy.HomeBuddySelfItem;
import com.taomee.seer2.app.home.panel.buddy.HomeEnergyPanel;
import com.taomee.seer2.app.home.panel.data.HomeBuddyDataUnit;
import com.taomee.seer2.app.home.panel.events.HomePanelEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class HomePanel extends Sprite {

    private static var _instance:HomePanel;


    private var _featureBar:HomeFeatureBar;

    private var _sideBar:HomeSideBar;

    private var _buddyPanel:HomeBuddyPanel;

    private var _welcome:HomeWelcome;

    private var _homeEnergy:HomeEnergyPanel;

    private var _selfItem:HomeBuddySelfItem;

    private var _selfDataUnit:HomeBuddyDataUnit;

    private var _homeInfo:HomeInfo;

    private var _addBuddyPanel:ProcessBuddyPanel;

    public function HomePanel() {
        super();
        this.createChildren();
        this._selfDataUnit = new HomeBuddyDataUnit();
        this._selfDataUnit.status = HomeBuddyDataUnit.READY;
        this._selfDataUnit.userInfo = ActorManager.actorInfo;
        this._selfItem.setData(this._selfDataUnit);
        this.initEventListener();
    }

    public static function show():void {
        if (_instance == null) {
            _instance = new HomePanel();
        }
        _instance.show();
    }

    public static function hide():void {
        if (_instance) {
            _instance.hide();
        }
    }

    public static function update(param1:HomeInfo):void {
        if (_instance) {
            _instance.closeProcessBuddyPanel();
            _instance.setData(param1);
        }
    }

    public static function showSomePanel():void {
        if (_instance) {
            _instance.addChild(_instance._buddyPanel);
            _instance.addChild(_instance._homeEnergy);
            _instance.addChild(_instance._selfItem);
            _instance.addChild(_instance._featureBar);
            _instance._sideBar.enableSomeBtn();
        }
    }

    public static function hideSomePanel():void {
        if (_instance) {
            DisplayUtil.removeForParent(_instance._buddyPanel);
            DisplayUtil.removeForParent(_instance._homeEnergy);
            DisplayUtil.removeForParent(_instance._selfItem);
            DisplayUtil.removeForParent(_instance._featureBar);
            _instance._sideBar.disEnableSomeBtn();
        }
    }

    public static function layIcons():void {
        if (_instance) {
            _instance._buddyPanel.adjustPosition();
            _instance._featureBar.adjustPosition();
            _instance._sideBar.adjustPosition();
            _instance._homeEnergy.adjustPosition();
            _instance._selfItem.adjustPosition();
        }
    }

    public static function getSidBar():HomeSideBar {
        return _instance._sideBar;
    }

    private function createChildren():void {
        this._featureBar = new HomeFeatureBar();
        addChild(this._featureBar);
        this._sideBar = new HomeSideBar();
        addChild(this._sideBar);
        this._buddyPanel = new HomeBuddyPanel();
        addChild(this._buddyPanel);
        this._welcome = new HomeWelcome();
        addChild(this._welcome);
        this._homeEnergy = new HomeEnergyPanel();
        addChild(this._homeEnergy);
        this._selfItem = new HomeBuddySelfItem();
        addChild(this._selfItem);
    }

    private function show():void {
        this.showTool();
        LayerManager.uiLayer.addChild(this);
    }

    private function hide():void {
        this.hideTool();
        DisplayObjectUtil.removeFromParent(this);
    }

    private function showTool():void {
        MapTitlePanel.show();
        PetAvatarPanel.show();
        MinorToolBar.show();
        LeftMinorToolBar.show();
        TestAssistPanel.show();
        LayerManager.stage.addEventListener(Event.ENTER_FRAME, this.onEnter);
    }

    private function onEnter(param1:Event):void {
        TestAssistPanel.updateTestAssist();
    }

    private function hideTool():void {
        LayerManager.stage.removeEventListener(Event.ENTER_FRAME, this.onEnter);
        MapTitlePanel.hide();
        PetAvatarPanel.hide();
        MinorToolBar.hide();
        LeftMinorToolBar.hide();
        TestAssistPanel.hide();
    }

    private function initEventListener():void {
        this._featureBar.addEventListener(HomePanelEvent.REQUEST_ADD_BUDDY, this.onRequestAddBuddy);
        this._buddyPanel.addEventListener(HomePanelEvent.REQUEST_ADD_BUDDY, this.onRequestAddBuddy);
    }

    private function onRequestAddBuddy(param1:Event):void {
        param1.stopPropagation();
        if (this._addBuddyPanel != null) {
            this._addBuddyPanel.show();
            addChild(this._addBuddyPanel);
            return;
        }
        this._addBuddyPanel = new ProcessBuddyPanel(ProcessBuddyPanel.ADD_BUDDY, new Point(330, 210));
        addChild(this._addBuddyPanel);
    }

    private function closeProcessBuddyPanel():void {
        if (this._addBuddyPanel != null) {
            this._addBuddyPanel.hide();
        }
    }

    private function setData(param1:HomeInfo):void {
        this._homeInfo = param1;
        this.updateCookie();
        this.updateDisplay();
    }

    private function updateCookie():void {
        UserGroupCookie.addIntervieweeCount(this._homeInfo.userId);
    }

    private function updateDisplay():void {
        MapTitlePanel.update(SceneManager.active.mapModel);
        this._homeEnergy.setData(this._homeInfo.leftFightCount);
        this._featureBar.setData(this._homeInfo);
        this._sideBar.setData(this._homeInfo);
        this._buddyPanel.setData(this._homeInfo);
        this._welcome.setData(this._homeInfo);
    }
}
}
