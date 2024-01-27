package com.taomee.seer2.app.home.panel.bar {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.home.panel.events.HomePanelEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class HomeFeatureBar extends HomeBar {


    private var _homeBtn:SimpleButton;

    private var _mapBtn:SimpleButton;

    private var _buddybtn:SimpleButton;

    private var _leftBtn:SimpleButton;

    private var _rightBtn:SimpleButton;

    private var _isShow:Boolean;

    public function HomeFeatureBar() {
        super();
        _container = UIManager.getMovieClip("UI_HomeFeatureBar");
        addChild(_container);
        _buttonVec = new Vector.<SimpleButton>();
        this._homeBtn = _container["home"];
        TooltipManager.addCommonTip(this._homeBtn, "回家");
        this._homeBtn.addEventListener(MouseEvent.CLICK, this.onHomeBtnClick);
        _buttonVec.push(this._homeBtn);
        this._mapBtn = _container["map"];
        TooltipManager.addCommonTip(this._mapBtn, "地图");
        this._mapBtn.addEventListener(MouseEvent.CLICK, this.onMapBtnClick);
        _buttonVec.push(this._mapBtn);
        this._buddybtn = _container["buddy"];
        TooltipManager.addCommonTip(this._buddybtn, "添加好友");
        this._buddybtn.addEventListener(MouseEvent.CLICK, this.onBuddyBtnClick);
        _buttonVec.push(this._buddybtn);
        this._leftBtn = _container["leftBtn"];
        this._leftBtn.addEventListener(MouseEvent.CLICK, this.onLeft);
        this._rightBtn = _container["rightBtn"];
        this._rightBtn.addEventListener(MouseEvent.CLICK, this.onRight);
        this._isShow = true;
        this.adjustPosition();
    }

    private function onLeft(param1:MouseEvent):void {
        this._isShow = false;
        TweenLite.to(_container, 0.6, {
            "x": -232,
            "ease": Expo.easeOut,
            "onComplete": this.onTweenRightComplete
        });
    }

    private function onRight(param1:MouseEvent):void {
        this._isShow = true;
        this._rightBtn.visible = false;
        TweenLite.to(_container, 0.6, {
            "x": 0,
            "ease": Expo.easeOut,
            "onComplete": this.onTweenRightComplete
        });
    }

    private function onTweenRightComplete():void {
        this.adjustPosition();
    }

    public function adjustPosition():void {
        _container.y = LayerManager.stage.stageHeight - 198;
        if (this._isShow) {
            _container.x = 0;
            this._rightBtn.visible = false;
        } else {
            _container.x = -232;
            this._rightBtn.visible = true;
        }
    }

    private function onHomeBtnClick(param1:MouseEvent):void {
        var _loc2_:uint = ActorManager.actorInfo.id;
        SceneManager.changeScene(SceneType.HOME, _loc2_);
    }

    private function onMapBtnClick(param1:MouseEvent):void {
        var _loc2_:Object = new Object();
        _loc2_["mapCategoryId"] = SceneManager.active.mapCategoryID;
        _loc2_["mapId"] = SceneManager.active.mapID;
        _loc2_["mapType"] = "star";
        ModuleManager.toggleModule(URLUtil.getAppModule("MapPanel"), "正在打开地图导航...", _loc2_);
    }

    private function onBuddyBtnClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_244);
        dispatchEvent(new HomePanelEvent(HomePanelEvent.REQUEST_ADD_BUDDY, true));
    }

    override protected function getShowButtonIndexVec(param1:Boolean):Vector.<int> {
        if (param1) {
            return Vector.<int>([1, 2]);
        }
        return Vector.<int>([0, 1, 2]);
    }

    override protected function updateLayout():void {
        var _loc1_:int = int(_buttonVec.length);
        var _loc2_:int = 55;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        while (_loc4_ < _loc1_) {
            if (_buttonVec[_loc4_].parent != null) {
                _buttonVec[_loc4_].x = 40 + _loc2_ * _loc3_++;
            }
            _loc4_++;
        }
    }

    override public function dispose():void {
        TooltipManager.remove(this._homeBtn);
        TooltipManager.remove(this._mapBtn);
        TooltipManager.remove(this._buddybtn);
        this._homeBtn.removeEventListener(MouseEvent.CLICK, this.onHomeBtnClick);
        this._mapBtn.removeEventListener(MouseEvent.CLICK, this.onMapBtnClick);
        this._buddybtn.removeEventListener(MouseEvent.CLICK, this.onBuddyBtnClick);
    }
}
}
