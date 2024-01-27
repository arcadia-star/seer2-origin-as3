package com.taomee.seer2.app.popup.alert {
import com.greensock.TweenMax;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertInitInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

public class ItemSpeialGainedAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _goBtn:SimpleButton;

    private var _iconDisplay:IconDisplayer;

    private var _nameTxt:TextField;

    private var _contentTxt:TextField;

    private var _msgTxt:TextField;

    private var _info:AlertInitInfo;

    public function ItemSpeialGainedAlert() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_ItemSpeialGainedAlert");
        this._goBtn = this._ui["goBtn"];
        this._goBtn.addEventListener(MouseEvent.CLICK, this.onGoClick);
        this._confirmBtn = this._ui["confirmBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._nameTxt = this._ui["nameTxt"];
        this._contentTxt = this._ui["contentTxt"];
        this._msgTxt = this._ui["msgTxt"];
        this._iconDisplay = new IconDisplayer();
        this._iconDisplay.setBoundary(60, 60);
        this._ui["iconBG"].addChild(this._iconDisplay);
        addChild(this._ui);
    }

    private function onGoClick(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiSuperProcessPanel"), "打开面板...");
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        var _loc2_:Point = new Point(this._iconDisplay.x, this._iconDisplay.y);
        var _loc3_:Point = this._iconDisplay.parent.localToGlobal(_loc2_);
        this._iconDisplay.x = _loc3_.x;
        this._iconDisplay.y = _loc3_.y;
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._confirmBtn = null;
        DisplayObjectUtil.removeFromParent(this._ui);
        LayerManager.root.addChild(this._iconDisplay);
        TweenMax.to(this._iconDisplay, 1.5, {
            "x": 517,
            "y": 526,
            "scaleX": 0.1,
            "scaleY": 0.1,
            "onComplete": this.tweenComplete
        });
        param1.stopImmediatePropagation();
        this.dispose();
    }

    private function tweenComplete():void {
        if (Boolean(this._iconDisplay) && Boolean(this._iconDisplay.parent)) {
            DisplayObjectUtil.removeFromParent(this._iconDisplay);
        }
        this._iconDisplay = null;
    }

    private function displayMessage():void {
        var _loc1_:String = ItemConfig.getItemIconUrl(this._info.referenceId);
        var _loc2_:String = ItemConfig.getItemName(this._info.referenceId);
        if (this._info.referenceId >= 102000 && this._info.referenceId < 103000) {
            this._iconDisplay.setIconUrl(URLUtil.getNonoEquipIconSwf(this._info.referenceId));
        } else {
            this._iconDisplay.setIconUrl(_loc1_);
        }
        if (this._info.message == "") {
            this._msgTxt.text = "";
            this._contentTxt.text = "x" + this._info.quantity + "，已经放入你的背包。";
            this._nameTxt.text = _loc2_;
        } else {
            this._msgTxt.text = this._info.message;
            this._contentTxt.text = "";
            this._nameTxt.text = "";
        }
    }

    public function show(param1:AlertInfo):void {
        var _loc2_:* = 0;
        var _loc3_:* = 0;
        this._info = param1.initInfo;
        this.displayMessage();
        if (param1.centralize == true) {
            _loc2_ = LayerManager.root.width - this.width >> 1;
            _loc3_ = LayerManager.root.height - this.height >> 1;
            this.x = _loc2_;
            this.y = _loc3_;
        }
        LayerManager.topLayer.addChild(this);
    }

    public function dispose():void {
        if (this._info.closeHandler != null) {
            this._info.closeHandler();
            this._info.closeHandler = null;
        }
        this._info = null;
        this._ui = null;
        AlertManager.removePopUp(this, false);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}
