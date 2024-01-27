package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.Timer;

public class MakeBubbleAnimation extends BaseAniamationInteractive {


    private const LEFT_EDGE:Point = new Point(202, 107);

    private const RIGHT_EDGE:Point = new Point(806, 417);

    private const TOTAL_AREA:int = 187240;

    private var _percentTxt:TextField;

    private var _numTxt:TextField;

    private var _timer:Timer;

    private var _bubbleNum:int;

    private var _percentArea:int;

    private var _bubbleVec:Vector.<MovieClip>;

    private var _currentBubble:MovieClip;

    public function MakeBubbleAnimation() {
        super();
    }

    override protected function paramAnimation():void {
        this._percentTxt = _animation["percentTxt"];
        this._numTxt = _animation["numTxt"];
        this._timer = new Timer(100);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._bubbleVec = new Vector.<MovieClip>();
        this.reset();
    }

    private function reset():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._bubbleVec.length) {
            DisplayObjectUtil.removeFromParent(this._bubbleVec[_loc1_]);
            _loc1_++;
        }
        this._bubbleVec = new Vector.<MovieClip>();
        this._bubbleNum = 0;
        this._percentArea = 0;
        this.openEventListener();
        this.updataTxt();
    }

    private function openEventListener():void {
        _animation.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        _animation.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }

    private function closeEventListener():void {
        _animation.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        _animation.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }

    private function onMouseDown(param1:MouseEvent):void {
        var _loc2_:MovieClip = null;
        this._currentBubble = null;
        if (this.isAvalible()) {
            this._currentBubble = getMovieClip("bubble");
            this._currentBubble.x = LayerManager.topLayer.mouseX - 120;
            this._currentBubble.y = LayerManager.topLayer.mouseY - 50;
            _loc2_ = _animation["introTxt"];
            _animation["container"].addChild(this._currentBubble);
            this._bubbleVec.push(this._currentBubble);
            ++this._bubbleNum;
            this._timer.reset();
            this._timer.start();
        }
    }

    private function onMouseUp(param1:MouseEvent):void {
        this._timer.stop();
        this.updataTxt();
    }

    private function onTimer(param1:TimerEvent):void {
        if (this._currentBubble) {
            this._currentBubble.scaleX = this._currentBubble.scaleY = 1 + this._timer.currentCount * 0.5;
            this.isCrash();
            this.judgeEdge();
        }
    }

    private function isAvalible():Boolean {
        if (LayerManager.topLayer.mouseX - 120 < this.LEFT_EDGE.x + 10 || LayerManager.topLayer.mouseX - 120 > this.RIGHT_EDGE.x - 10) {
            return false;
        }
        if (LayerManager.topLayer.mouseY - 50 < this.LEFT_EDGE.y + 10 || LayerManager.topLayer.mouseY - 50 > this.RIGHT_EDGE.y - 10) {
            return false;
        }
        if (this.isCrash()) {
            return false;
        }
        return true;
    }

    private function isCrash():Boolean {
        var _loc1_:int = 0;
        while (_loc1_ < this._bubbleVec.length) {
            if (this._currentBubble) {
                if (this._currentBubble != this._bubbleVec[_loc1_]) {
                    if (this.judgeHitBubble(this._bubbleVec[_loc1_], new Point(this._currentBubble.x, this._currentBubble.y), this._currentBubble.width / 2 + this._bubbleVec[_loc1_].width / 2)) {
                        this._timer.stop();
                        return true;
                    }
                }
            } else if (this.judgeHitBubble(this._bubbleVec[_loc1_], new Point(LayerManager.topLayer.mouseX - 120, LayerManager.topLayer.mouseY - 50), this._bubbleVec[_loc1_].width / 2)) {
                return true;
            }
            _loc1_++;
        }
        return false;
    }

    private function judgeHitBubble(param1:MovieClip, param2:Point, param3:Number):Boolean {
        var _loc4_:int = param2.x - param1.x;
        var _loc5_:int = param2.y - param1.y;
        if (Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_) <= param3) {
            return true;
        }
        return false;
    }

    private function judgeEdge():void {
        var _loc1_:int = Math.min(this._currentBubble.x - this.LEFT_EDGE.x, this._currentBubble.y - this.LEFT_EDGE.y);
        if (_loc1_ < this._currentBubble.width / 2) {
            this._timer.stop();
        }
        var _loc2_:int = Math.min(this.RIGHT_EDGE.x - this._currentBubble.x, this.RIGHT_EDGE.y - this._currentBubble.y);
        if (_loc2_ < this._currentBubble.width / 2) {
            this._timer.stop();
        }
    }

    private function updataTxt():void {
        if (this._currentBubble) {
            this.computeArea();
        }
        this._percentTxt.text = this._percentArea.toString();
        this._numTxt.text = this._bubbleNum.toString();
        if (this._bubbleNum == 10) {
            if (this._percentArea >= 73 && this._percentArea <= 75) {
                dispatchEvent(new Event(AnimationEvent.MAKEBUBBLE));
                this.dispose();
            } else {
                AlertManager.showConfirm("产生水泡失败，再重新制造一遍吗？", this.tryAgain, this.noAgain);
            }
        }
    }

    private function tryAgain():void {
        this.reset();
    }

    private function noAgain():void {
        this.dispose();
    }

    private function computeArea():void {
        var _loc3_:Number = NaN;
        var _loc1_:Number = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this._bubbleVec.length) {
            _loc3_ = this._bubbleVec[_loc2_].width / 2;
            _loc1_ += Math.PI * _loc3_ * _loc3_ * 100;
            _loc2_++;
        }
        this._percentArea = Math.round(_loc1_ / this.TOTAL_AREA);
    }

    override public function dispose():void {
        super.dispose();
        this.closeEventListener();
        this._timer.stop();
        this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
    }
}
}
