package com.taomee.seer2.app.questTiny {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.tree.TreeItem;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.StyleSheet;
import flash.text.TextField;

public class QuestTinyStepItem extends TreeItem {


    private var _mainUI:MovieClip;

    private var _nameTxt:TextField;

    private var _quest:*;

    private var _data:*;

    private var _goBtn:SimpleButton;

    public function QuestTinyStepItem() {
        this._mainUI = UIManager.getMovieClip("QuestStepItemUI");
        this._nameTxt = this._mainUI["txt"];
        this._goBtn = this._mainUI["go"];
        this._goBtn.visible = false;
        this._goBtn.addEventListener(MouseEvent.CLICK, this.onGoBtnClick);
        super(this._mainUI);
        var _loc1_:StyleSheet = new StyleSheet();
        _loc1_.parseCSS("a:link{color:#33EE00}a:hover{color: #FF0000} a:active{color:#FF0000} a:visited{color: #00FF00}");
        this._nameTxt.styleSheet = _loc1_;
        this._nameTxt.addEventListener(TextEvent.LINK, this.linkHandler);
    }

    private function onGoBtnClick(param1:MouseEvent):void {
        var _loc3_:Vector.<int> = null;
        var _loc2_:uint = uint(this._quest.getAcceptMapId());
        if (_loc2_ == 0) {
            _loc3_ = this._quest.getRelatedMapIds();
            if (_loc3_.length > 0) {
                _loc2_ = uint(_loc3_[0]);
            }
        }
        if (_loc2_ > 0) {
            if (_loc2_ == 50000) {
                if (SceneManager.active.mapID == ActorManager.getActor().id) {
                    AlertManager.showAlert("你已经在此地图了！");
                } else {
                    SceneManager.changeScene(SceneType.HOME, ActorManager.getActor().id);
                }
            } else if (_loc2_ == 70000) {
                if (SceneManager.active.mapID == ActorManager.getActor().id) {
                    AlertManager.showAlert("你已经在此地图了！");
                } else {
                    SceneManager.changeScene(SceneType.PLANT, ActorManager.getActor().id);
                }
            } else if (SceneManager.active.mapID == _loc2_) {
                AlertManager.showAlert("你已经在此地图了！");
            } else {
                SceneManager.changeScene(SceneType.LOBBY, _loc2_);
            }
        }
    }

    override public function update(param1:*):void {
        this._quest = param1.data;
        this._data = param1;
        this._nameTxt.htmlText = param1.txt;
        if (param1.go) {
            this._goBtn.visible = true;
        } else {
            this._goBtn.visible = false;
        }
    }

    override public function get data():* {
        return this._quest;
    }

    private function linkHandler(param1:TextEvent):void {
        var _loc3_:Object = null;
        var _loc2_:int = int(param1.text);
        if (_loc2_ > 0) {
            if (_loc2_ == 50000) {
                if (SceneManager.active.mapID == ActorManager.getActor().id) {
                    AlertManager.showAlert("你已经在此地图了！");
                } else {
                    SceneManager.changeScene(SceneType.HOME, ActorManager.getActor().id);
                }
            } else if (_loc2_ == 70000) {
                if (SceneManager.active.mapID == ActorManager.getActor().id) {
                    AlertManager.showAlert("你已经在此地图了！");
                } else {
                    SceneManager.changeScene(SceneType.PLANT, ActorManager.getActor().id);
                }
            } else if (SceneManager.active.mapID == _loc2_) {
                AlertManager.showAlert("你已经在此地图了！");
            } else if (this._quest && Boolean(this._quest.getCurrentOrNextStep().point)) {
                SceneManager.changeScene(SceneType.LOBBY, _loc2_, this._quest.getCurrentOrNextStep().point.x, this._quest.getCurrentOrNextStep().point.y);
            } else {
                SceneManager.changeScene(SceneType.LOBBY, _loc2_);
            }
        } else {
            _loc3_ = new Object();
            if (this._data.para != null) {
                _loc3_ = {"type": this._data.para};
            } else {
                _loc3_ = null;
            }
            ModuleManager.showAppModule(param1.text, _loc3_);
        }
    }
}
}
