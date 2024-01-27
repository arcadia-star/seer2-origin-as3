package com.taomee.seer2.app.processor.quest.handler.branch.quest10130 {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class MaliangGame {


    private var _fun:Function;

    private var _mc:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _moveList:Vector.<MovieClip>;

    private var _uiList:Vector.<MovieClip>;

    private var _currDownIndex:int;

    private var _currDownPoint:Point;

    private var _count:int;

    private var _b:Boolean;

    private var _uiuiList:Vector.<MovieClip>;

    public function MaliangGame(param1:MovieClip, param2:Function) {
        super();
        this._mc = param1;
        this._fun = param2;
        this._count = 0;
        this._b = false;
        LayerManager.topLayer.addChild(this._mc);
        DisplayUtil.align(this._mc, 4, LayerManager.rootRect);
        this.initMC();
    }

    private function initMC():void {
        this._closeBtn = this._mc["closeBtn"];
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.dispose);
        this._moveList = Vector.<MovieClip>([]);
        this._uiList = Vector.<MovieClip>([]);
        this._uiuiList = Vector.<MovieClip>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 6) {
            this._moveList.push(this._mc["move" + _loc1_]);
            this._uiList.push(this._mc["ui" + _loc1_]);
            this._uiuiList.push(this._mc["uiui" + _loc1_]);
            this._uiList[_loc1_].visible = false;
            this._uiList[_loc1_].gotoAndStop(1);
            this._uiuiList[_loc1_].addEventListener(MouseEvent.MOUSE_UP, this.onUiUp);
            this._moveList[_loc1_].gotoAndStop(1);
            this._moveList[_loc1_].visible = true;
            this._moveList[_loc1_].buttonMode = true;
            this._moveList[_loc1_].addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            _loc1_++;
        }
    }

    private function onDown(param1:MouseEvent):void {
        this._b = true;
        this._currDownIndex = this._moveList.indexOf(param1.currentTarget as MovieClip);
        this._moveList[this._currDownIndex].mouseChildren = false;
        this._moveList[this._currDownIndex].mouseEnabled = false;
        this._moveList[this._currDownIndex].gotoAndStop(2);
        this._currDownPoint = new Point(this._moveList[this._currDownIndex].x, this._moveList[this._currDownIndex].y);
        this._mc.addEventListener(Event.ENTER_FRAME, this.onMove);
        this._mc.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
    }

    private function onMove(param1:Event):void {
        this._moveList[this._currDownIndex].x = this._mc.mouseX - 40;
        this._moveList[this._currDownIndex].y = this._mc.mouseY - 40;
    }

    private function onUp(param1:MouseEvent):void {
        this._b = false;
        this._moveList[this._currDownIndex].gotoAndStop(1);
        this._mc.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
        this._mc.removeEventListener(Event.ENTER_FRAME, this.onMove);
        this._moveList[this._currDownIndex].x = this._currDownPoint.x;
        this._moveList[this._currDownIndex].y = this._currDownPoint.y;
        this._moveList[this._currDownIndex].mouseChildren = true;
        this._moveList[this._currDownIndex].mouseEnabled = true;
    }

    private function onUiUp(param1:MouseEvent):void {
        if (this._b == false) {
            return;
        }
        var _loc2_:int = this._uiuiList.indexOf(param1.currentTarget as MovieClip);
        if (this._currDownIndex != _loc2_) {
            AlertManager.showAlert("错了啦！");
            this.onUp(null);
        } else {
            this._moveList[this._currDownIndex].visible = false;
            this._uiList[this._currDownIndex].visible = true;
            ++this._count;
            if (this._count >= 6) {
                this.win();
            }
        }
    }

    private function win():void {
        this._fun();
    }

    public function dispose(param1:MouseEvent):void {
        if (this._mc) {
            this._mc.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this._mc.removeEventListener(Event.ENTER_FRAME, this.onMove);
            DisplayUtil.removeForParent(this._mc);
        }
    }
}
}
