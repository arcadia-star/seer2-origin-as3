package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class Quest30002TurnTable extends BaseAniamationInteractive {


    private var _car:MovieClip;

    private var _ballMC:MovieClip;

    private var _goBtn:SimpleButton;

    private var _stopMC:MovieClip;

    private var _mouseHint:MovieClip;

    private var _mouseMC:MovieClip;

    private var _ballVec:Vector.<MovieClip>;

    private var _hitTest0:MovieClip;

    private var _hitTest1:MovieClip;

    private var _hitTest0X:Number;

    private var _hitTest1X:Number;

    private var _stop0:MovieClip;

    private var _stop1:MovieClip;

    private var _countTxt:TextField;

    private var _totalCount:int;

    private var _winCount:int;

    private var _isClick:Boolean;

    private var _currStopNum:int;

    private var _setTimeout:uint;

    public function Quest30002TurnTable() {
        super();
    }

    override protected function paramAnimation():void {
        LayerManager.moduleLayer.addChild(_animation);
        this.init();
    }

    private function init():void {
        this._car = _animation["car"];
        this._ballMC = _animation["ballMC"];
        this._goBtn = _animation["goBtn"];
        this._stopMC = _animation["stopMC"];
        this._mouseHint = _animation["mouseHint"];
        this._mouseMC = _animation["mouseMC"];
        this._hitTest0 = _animation["hitTest0"];
        this._hitTest0X = this._hitTest0.x;
        this._hitTest1 = _animation["hitTest1"];
        this._hitTest1X = this._hitTest1.x;
        this._stop0 = _animation["stopMC0"];
        this._stop1 = _animation["stopMC1"];
        this._countTxt = _animation["countTxt"];
        this._ballVec = Vector.<MovieClip>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._ballVec.push(_animation["ballMC" + _loc1_]);
            _loc1_++;
        }
        this._totalCount = 0;
        this._winCount = 0;
        this._currStopNum = 0;
        this._isClick = false;
        this.reset();
    }

    private function reset():void {
        var ball:MovieClip = null;
        this._ballMC.gotoAndStop(this._winCount + 1);
        this._countTxt.text = (10 - this._totalCount).toString();
        if (this._winCount >= 3) {
            this._car.gotoAndStop(2);
            this._setTimeout = setTimeout(function ():void {
                win();
            }, 1500);
            return;
        }
        if (this._totalCount >= 10 && this._winCount < 3) {
            this._setTimeout = setTimeout(function ():void {
                noWin();
            }, 1500);
            return;
        }
        this._currStopNum = 0;
        this._car.gotoAndStop(1);
        this._goBtn.visible = true;
        this._stopMC.visible = true;
        this._mouseHint.visible = false;
        this._mouseMC.visible = false;
        this._mouseMC.buttonMode = true;
        this._hitTest0.x = this._hitTest0X;
        this._hitTest1.x = this._hitTest1X;
        this._stop0.gotoAndStop(1);
        this._stop1.gotoAndStop(1);
        for each(ball in this._ballVec) {
            ball.visible = true;
            ball.gotoAndStop(1);
        }
        this.initEvent();
    }

    private function initEvent():void {
        this._goBtn.addEventListener(MouseEvent.CLICK, this.onGo);
        this._mouseMC.addEventListener(MouseEvent.CLICK, this.onMouse);
    }

    private function onGo(param1:MouseEvent):void {
        var _loc2_:MovieClip = null;
        for each(_loc2_ in this._ballVec) {
            _loc2_.gotoAndPlay(1);
        }
        this._stopMC.visible = false;
        this._goBtn.visible = false;
        this._mouseHint.visible = true;
        this._mouseMC.buttonMode = true;
        this._mouseMC.visible = true;
        _animation.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event):void {
        if (this._ballVec[0].hitTestObject(this._hitTest0)) {
            this._hitTest0.x = 0;
            if (this._currStopNum == 1) {
                this._ballVec[0].visible = false;
                this._ballVec[2].visible = false;
            } else {
                this._ballVec[1].visible = false;
            }
        }
        if (this._ballVec[0].hitTestObject(this._hitTest1)) {
            this._hitTest1.x = 0;
            if (this._currStopNum == 2) {
                this._ballVec[0].visible = false;
            } else {
                this._ballVec[2].visible = false;
            }
        }
        if (this._ballVec[0].currentFrame == this._ballVec[0].totalFrames && this._ballVec[0].visible == true) {
            _animation.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            ++this._totalCount;
            this.reset();
        }
        if (this._ballVec[1].currentFrame == this._ballVec[1].totalFrames && this._ballVec[1].visible == true) {
            _animation.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            ++this._totalCount;
            this.reset();
        }
        if (this._ballVec[2].currentFrame == this._ballVec[2].totalFrames && this._ballVec[2].visible == true) {
            _animation.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            ++this._totalCount;
            ++this._winCount;
            this.reset();
        }
    }

    private function win():void {
        _isSuccess = true;
        this.dispose();
    }

    private function noWin():void {
        this.dispose();
    }

    private function onMouse(param1:MouseEvent):void {
        var _loc2_:Number = NaN;
        var _loc3_:MovieClip = null;
        this._mouseHint.visible = false;
        this._mouseMC.visible = false;
        this._isClick = true;
        for each(_loc3_ in this._ballVec) {
            if (_loc3_["thisBall"] != null) {
                _loc2_ = Number(_loc3_["thisBall"].y);
            }
            if (_loc3_.visible == true && _loc2_ < this._hitTest0.y) {
                this._currStopNum = 1;
                this._stop0.gotoAndPlay(1);
                break;
            }
            if (_loc3_.visible == true && _loc2_ < this._hitTest1.y) {
                this._currStopNum = 2;
                this._stop1.gotoAndPlay(1);
                break;
            }
            if (_loc3_.visible == true) {
                this._currStopNum = 0;
                break;
            }
        }
    }

    override public function dispose():void {
        var _loc1_:MovieClip = null;
        clearTimeout(this._setTimeout);
        this._goBtn.removeEventListener(MouseEvent.CLICK, this.onGo);
        this._mouseMC.removeEventListener(MouseEvent.CLICK, this.onMouse);
        _animation.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        for each(_loc1_ in this._ballVec) {
            _loc1_.gotoAndStop(1);
        }
        this._car = null;
        this._ballMC = null;
        this._goBtn = null;
        this._stopMC = null;
        this._mouseHint = null;
        this._mouseMC = null;
        this._hitTest0 = null;
        this._hitTest1 = null;
        this._stop0 = null;
        this._stop1 = null;
        this._ballVec = null;
        this._countTxt = null;
        super.dispose();
    }
}
}
