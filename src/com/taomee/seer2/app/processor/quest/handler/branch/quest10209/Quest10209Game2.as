package com.taomee.seer2.app.processor.quest.handler.branch.quest10209 {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class Quest10209Game2 {


    private var _mc:MovieClip;

    private var _mainPanel:MovieClip;

    private var _startBtn:SimpleButton;

    private var _closeBtn:SimpleButton;

    private var _gameList:Vector.<SimpleButton>;

    private var _comFun:Function;

    private var _prevPoint:int;

    public function Quest10209Game2(param1:MovieClip, param2:Function) {
        super();
        this._mc = param1;
        this._mainPanel = this._mc["mainPanel"];
        this._mainPanel.visible = true;
        this._startBtn = this._mainPanel["startBtn"];
        this._prevPoint = 0;
        this._startBtn.addEventListener(MouseEvent.CLICK, this.onStart);
        this._closeBtn = this._mc["closeBtn"];
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        this._comFun = param2;
        this._gameList = Vector.<SimpleButton>([]);
        var _loc3_:int = 0;
        while (_loc3_ < 5) {
            this._gameList.push(this._mc["game" + _loc3_]);
            this._gameList[_loc3_].visible = true;
            this._gameList[_loc3_].addEventListener(MouseEvent.CLICK, this.onGame);
            _loc3_++;
        }
    }

    private function onClose(param1:MouseEvent):void {
        var _loc2_:SimpleButton = null;
        this._startBtn.removeEventListener(MouseEvent.CLICK, this.onStart);
        this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
        for each(_loc2_ in this._gameList) {
            _loc2_.removeEventListener(MouseEvent.CLICK, this.onGame);
        }
        DisplayUtil.removeForParent(this._mc);
    }

    private function onGame(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        var index:int = this._gameList.indexOf(event.currentTarget as SimpleButton);
        if (index == 0 || index == this._prevPoint + 1) {
            if (index == 4) {
                this._comFun();
                this.onClose(null);
            } else {
                this._gameList[index].visible = false;
                this._prevPoint = index;
            }
        } else {
            AlertManager.showAlert("没有按正确的顺序拆除铁杆", function ():void {
                onClose(null);
            });
        }
    }

    private function onStart(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10209_5"), function ():void {
            _mainPanel.visible = false;
        }, true, true, 2);
    }
}
}
