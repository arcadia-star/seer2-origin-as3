package com.taomee.seer2.core.animation {
import com.taomee.seer2.core.animation.frame.FrameInfo;
import com.taomee.seer2.core.animation.frame.FrameLabelInfo;
import com.taomee.seer2.core.animation.frame.FrameSequence;
import com.taomee.seer2.core.animation.frame.FrameSequenceManager;
import com.taomee.seer2.core.entity.events.ActionEvent;

import flash.display.Bitmap;
import flash.display.PixelSnapping;
import flash.geom.Point;

import org.taomee.ds.HashMap;

public class FramePlayer extends Bitmap implements IAnimation {


    private var _frameSequence:FrameSequence;

    private var _resourceUrl:String;

    private var _totalFrameNum:uint = 1;

    private var _currentFrameIndex:uint = 1;

    private var _currentStartIndex:uint = 1;

    private var _currentEndIndex:uint = 1;

    private var _drawedFrameIndex:uint = 0;

    private var _currentLabel:String;

    private var _labelMap:HashMap;

    private var _currentFrameInfo:FrameInfo;

    private var _initialized:Boolean = false;

    private var _isPlaying:Boolean = true;

    private var _scaleX:Number;

    private var _scaleY:Number;

    private var _isStopAllAnimation:Boolean = false;

    public function FramePlayer(param1:String = null) {
        super();
        this._resourceUrl = param1;
        this.initialize();
    }

    protected function initialize():void {
        this._scaleX = 1;
        this._scaleY = 1;
        this.smoothing = true;
        this.pixelSnapping = PixelSnapping.AUTO;
        this.initFrameSequence();
    }

    protected function initFrameSequence():void {
        if (this._resourceUrl != null) {
            this._frameSequence = FrameSequenceManager.getFrameSequence(this._resourceUrl);
        }
    }

    public function set frameSequence(param1:FrameSequence):void {
        this._frameSequence = param1;
        this._initialized = false;
    }

    public function get frameSequence():FrameSequence {
        return this._frameSequence;
    }

    public function get resourceUrl():String {
        return this._resourceUrl;
    }

    public function get totalFrameNum():uint {
        if (this._frameSequence.isReady == true) {
            return this._frameSequence.getTotalFrameNum();
        }
        return 1;
    }

    public function get currentFrameIndex():uint {
        return this._currentFrameIndex;
    }

    public function get currentFrameLabel():String {
        return this._currentLabel;
    }

    public function play():void {
        this.updateFrameIndex();
        this.gotoAndPlay(this._currentFrameIndex);
    }

    public function stop():void {
        this.gotoAndStop(this._currentFrameIndex);
    }

    public function gotoAndPlay(param1:uint):void {
        this._isPlaying = true;
        var _loc2_:uint = this._currentFrameIndex;
        if (Boolean(this._frameSequence) && this._frameSequence.isReady) {
            this.updateFrameIndexRange();
        }
        this._currentFrameIndex = _loc2_;
    }

    public function gotoAndStop(param1:uint):void {
        this._isPlaying = false;
        this._currentFrameIndex = param1;
        this._currentStartIndex = param1;
        this._currentEndIndex = param1;
    }

    public function hasLabel(param1:String):Boolean {
        return this._labelMap.containsKey(param1);
    }

    public function gotoLabel(param1:String):void {
        if (this._currentLabel == param1) {
            return;
        }
        this._currentLabel = param1;
        if (this._initialized == true) {
            this.updateIndexRangeByLabel();
        }
        this.dispatchActionEvent(ActionEvent.START);
    }

    public function get initialized():Boolean {
        return this._initialized;
    }

    private function updateIndexRangeByLabel():void {
        var _loc1_:FrameLabelInfo = this._labelMap.getValue(this._currentLabel) as FrameLabelInfo;
        if (_loc1_ != null) {
            this._currentStartIndex = _loc1_.startIndex;
            this._currentFrameIndex = this._currentStartIndex;
            this._currentEndIndex = _loc1_.endIndex;
        }
    }

    public function update():void {
        if (Boolean(this._frameSequence) && this._frameSequence.isReady) {
            if (this._initialized == false) {
                this.updateFrameIndexRange();
                this._initialized = true;
            }
            this.updateFrame();
            this.updateFrameIndex();
        }
    }

    private function updateFrameIndex():void {
        if (this._isStopAllAnimation == false) {
            ++this._currentFrameIndex;
        } else if (this._currentFrameIndex != 1) {
            this._currentFrameIndex = 1;
        }
        if (this._currentFrameIndex > this._currentEndIndex) {
            this.dispatchActionEvent(ActionEvent.FINISHED);
            this._currentFrameIndex = this._currentStartIndex;
        }
    }

    public function isStopAllAnimation(param1:Boolean):void {
        this._isStopAllAnimation = param1;
    }

    private function dispatchActionEvent(param1:String):void {
        if (hasEventListener(param1)) {
            dispatchEvent(new ActionEvent(param1));
        }
    }

    private function updateFrame():void {
        if (this._currentFrameIndex == this._drawedFrameIndex) {
            return;
        }
        this._currentFrameInfo = this._frameSequence.getFrameInfoByIndex(this._currentFrameIndex);
        this.drawFrame();
        this._drawedFrameIndex = this._currentFrameIndex;
    }

    private function drawFrame():void {
        var _loc1_:Point = null;
        if (this._currentFrameInfo != null) {
            _loc1_ = this._frameSequence.anchor;
            this.x = -_loc1_.x * this._scaleX;
            this.y = -_loc1_.y * this._scaleY;
            this.x += this._currentFrameInfo.offsetX * this._scaleX;
            this.y += this._currentFrameInfo.offsetY * this._scaleY;
            this.bitmapData = this._currentFrameInfo.bitmapData;
        }
    }

    private function updateFrameIndexRange():void {
        this._labelMap = this._frameSequence.getLabelMap();
        if (this._isPlaying == true) {
            if (this._currentLabel != null) {
                this.updateIndexRangeByLabel();
            } else {
                this._currentEndIndex = this._frameSequence.getTotalFrameNum();
            }
        }
    }

    override public function get scaleX():Number {
        return this._scaleX;
    }

    override public function set scaleX(param1:Number):void {
        this._scaleX = param1;
        super.scaleX = param1;
        this.drawFrame();
    }

    override public function get scaleY():Number {
        return this._scaleY;
    }

    override public function set scaleY(param1:Number):void {
        this._scaleY = param1;
        super.scaleY = param1;
        this.drawFrame();
    }

    protected function releaseFrameSequence():void {
        if (this._frameSequence == null) {
            return;
        }
        if (this._frameSequence.isFromPool == true) {
            FrameSequenceManager.recyleFrameSequence(this._frameSequence);
        } else {
            this._frameSequence.dispose();
        }
        this._frameSequence = null;
    }

    public function dispose():void {
        this.releaseFrameSequence();
        this._currentFrameInfo = null;
        this.bitmapData = null;
    }
}
}
