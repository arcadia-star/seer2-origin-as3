package com.taomee.seer2.app.announcement.horn {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import org.taomee.utils.AlignType;
import org.taomee.utils.DisplayUtil;

public class AbstractHorn {


    public var _info:HornInfo;

    private var _hornMC:MovieClip;

    private var _groupMC:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _contentTxt:TextField;

    private var _contentMC:MovieClip;

    public function AbstractHorn(param1:HornInfo) {
        super();
        this._info = param1;
        this.init();
        this.initEvent();
        this.show();
    }

    private function init():void {
        this._hornMC = UIManager.getMovieClip("UI_Horn");
        this._closeBtn = this._hornMC["closeBtn"];
        this._contentMC = this._hornMC["contentMC"];
        this._contentTxt = this._hornMC["contentTxt"];
        this._groupMC = this._hornMC["groupMC"];
        this._contentTxt.autoSize = TextFieldAutoSize.LEFT;
        this._contentTxt.htmlText = this._info.content;
        this._groupMC.width = this._contentTxt.width + this._closeBtn.width + 20;
        this._closeBtn.x = this._groupMC.width - 5;
        this._contentMC.width = this._groupMC.width - this._closeBtn.width - 5;
    }

    public function initEvent():void {
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        this._contentMC.buttonMode = true;
        this._contentMC.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function removeEvent():void {
        if (this._closeBtn) {
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
            this._contentMC.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    public function onClick(param1:MouseEvent):void {
        StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_26);
    }

    public function show():void {
        FightManager.addEventListener(FightStartEvent.START_SUCCESS, this.onStartFight);
        LayerManager.topLayer.addChild(this._hornMC);
        DisplayUtil.align(this._hornMC, AlignType.TOP_CENTER);
        this._hornMC.y = 100;
    }

    private function onStartFight(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight);
        this.onClose(null);
    }

    public function onClose(param1:MouseEvent):void {
        DisplayUtil.removeForParent(this._hornMC);
        this.removeEvent();
        this._hornMC = null;
        this._closeBtn = null;
        this._contentMC = null;
        this._contentTxt = null;
    }
}
}
