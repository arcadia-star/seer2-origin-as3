package com.taomee.seer2.app.processor.quest.handler.main.quest10 {
import com.taomee.seer2.app.processor.quest.handler.main.QuestGame;

import flash.display.MovieClip;
import flash.geom.Rectangle;

public class QuestGame_10_203 extends QuestGame {

    private static const MAX_NUM:int = 3;

    private static const RESULT_INDEX:int = 3;


    private var _mcWrapperVec:Vector.<McWrapper>;

    private var _petMc:MovieClip;

    private var _resultMc:MovieClip;

    public function QuestGame_10_203(param1:MovieClip, param2:Function) {
        super(param1, param2);
    }

    override public function init():void {
        super.init();
        this._petMc = _mc["pet"];
        this._petMc.gotoAndStop(1);
        this._resultMc = _mc["result"];
        this._resultMc.gotoAndStop(1);
        this._mcWrapperVec = new Vector.<McWrapper>();
        var _loc1_:Rectangle = new Rectangle(297, 174, 605, 312);
        var _loc2_:int = 1;
        while (_loc2_ <= MAX_NUM) {
            this._mcWrapperVec.push(new McWrapper(_mc["mc_" + _loc2_], this._petMc, _loc2_, _loc1_, this.checkInteract));
            _loc2_++;
        }
    }

    private function checkInteract(param1:int, param2:Boolean):void {
        var _loc3_:int = 0;
        if (param2) {
            if (param1 == RESULT_INDEX) {
                this._resultMc.gotoAndStop(3);
                _isSuccess = true;
                hide();
            } else {
                this._resultMc.gotoAndStop(2);
                _loc3_ = 0;
                while (_loc3_ < MAX_NUM) {
                    if (_loc3_ != param1 - 1) {
                        this._mcWrapperVec[_loc3_].reset();
                    }
                    _loc3_++;
                }
            }
        }
    }

    override public function show():void {
        super.show();
        this._petMc.gotoAndStop(1);
        this._resultMc.gotoAndStop(1);
        var _loc1_:int = 0;
        while (_loc1_ < MAX_NUM) {
            this._mcWrapperVec[_loc1_].reset();
            _loc1_++;
        }
    }

    override public function dispose():void {
        super.dispose();
        var _loc1_:int = 0;
        while (_loc1_ < MAX_NUM) {
            this._mcWrapperVec[_loc1_].dispose();
            _loc1_++;
        }
    }
}
}

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

class McWrapper {


    private var _orginalPos:Point;

    private var _mc:MovieClip;

    private var _target:MovieClip;

    private var _index:int;

    private var _bounds:Rectangle;

    private var _isInteract:Boolean;

    private var _callBack:Function;

    public function McWrapper(param1:MovieClip, param2:MovieClip, param3:int, param4:Rectangle, param5:Function) {
        super();
        this._mc = param1;
        this._target = param2;
        this._index = param3;
        this._bounds = param4;
        this._callBack = param5;
        this._orginalPos = new Point(param1.x, param1.y);
        this._mc.addEventListener(MouseEvent.MOUSE_DOWN, this.onMcDown);
        this._mc.addEventListener(MouseEvent.MOUSE_UP, this.onMcUp);
    }

    private function onMcDown(param1:MouseEvent):void {
        this._mc.startDrag(false, this._bounds);
    }

    private function onMcUp(param1:MouseEvent):void {
        this._mc.stopDrag();
        if (this._mc.hitTestObject(this._target)) {
            this._isInteract = true;
            this._mc.visible = false;
            this._target.gotoAndStop(this._index + 1);
        } else {
            this._isInteract = false;
            this.reset();
        }
        this._callBack(this._index, this._isInteract);
    }

    public function reset():void {
        this._mc.visible = true;
        this._mc.x = this._orginalPos.x;
        this._mc.y = this._orginalPos.y;
    }

    public function dispose():void {
        this._mc.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMcDown);
        this._mc.removeEventListener(MouseEvent.MOUSE_UP, this.onMcUp);
    }
}
