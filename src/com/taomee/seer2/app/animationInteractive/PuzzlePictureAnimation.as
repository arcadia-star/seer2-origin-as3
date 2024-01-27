package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class PuzzlePictureAnimation extends BaseAniamationInteractive {


    private const BLOCK_NUM:int = 8;

    private var _container:MovieClip;

    private var _blockVec:Vector.<MovieClip>;

    private var _successCnt:int;

    private var _mouseBlock:MovieClip;

    private var _currentIndex:int;

    private const GRID_NUM:int = 8;

    private const GRID_SIZE:int = 17;

    private const GRID_START:Point = new Point(436, 193);

    public function PuzzlePictureAnimation() {
        super();
    }

    override protected function paramAnimation():void {
        var _loc2_:MovieClip = null;
        this._successCnt = 0;
        this._currentIndex = -1;
        this._container = _animation["container"];
        this._container.gotoAndStop(1);
        _animation.addEventListener(MouseEvent.CLICK, this.onContainerClick);
        this._mouseBlock = _animation["mouseBlock"];
        this._mouseBlock.addEventListener(Event.ENTER_FRAME, this.onEnterBlock);
        this._mouseBlock.visible = false;
        this._mouseBlock.mouseEnabled = false;
        this._mouseBlock.mouseChildren = false;
        this._blockVec = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < this.BLOCK_NUM) {
            _loc2_ = _animation["block_" + _loc1_];
            _loc2_.gotoAndStop(1);
            this._blockVec.push(_loc2_);
            _loc1_++;
        }
        this.openBlockListener();
    }

    private function openBlockListener():void {
        var _loc2_:MovieClip = null;
        var _loc1_:int = 0;
        while (_loc1_ < this.BLOCK_NUM) {
            _loc2_ = this._blockVec[_loc1_];
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.MOUSE_DOWN, this.onBlockDown);
            _loc1_++;
        }
    }

    private function closeBlockListener():void {
        var _loc2_:MovieClip = null;
        var _loc1_:int = 0;
        while (_loc1_ < this.BLOCK_NUM) {
            _loc2_ = this._blockVec[_loc1_];
            _loc2_.buttonMode = false;
            _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN, this.onBlockDown);
            _loc1_++;
        }
    }

    private function onBlockDown(param1:MouseEvent):void {
        if (this._currentIndex != -1) {
            return;
        }
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _loc2_.visible = false;
        var _loc3_:String = _loc2_.name;
        this._currentIndex = int(_loc3_.substr(_loc3_.length - 1, 1));
        this._mouseBlock.visible = true;
        this._mouseBlock.gotoAndStop(this._currentIndex + 1);
    }

    private function onContainerClick(param1:MouseEvent):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        if (this._currentIndex == -1) {
            return;
        }
        var _loc2_:MovieClip = this._blockVec[this._currentIndex];
        var _loc3_:Point = new Point(this._mouseBlock.x - this._mouseBlock.width / 2, this._mouseBlock.y - this._mouseBlock.height / 2);
        if (_loc3_.x > this.GRID_START.x + this.GRID_SIZE * this.GRID_NUM + this.GRID_SIZE || _loc3_.x < this.GRID_START.x - this.GRID_SIZE || _loc3_.y > this.GRID_START.y + this.GRID_SIZE * this.GRID_NUM + this.GRID_SIZE || _loc3_.y < this.GRID_START.y - this.GRID_SIZE) {
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
        } else {
            _loc4_ = Math.round((_loc3_.x - this.GRID_START.x) / this.GRID_SIZE);
            _loc5_ = Math.round((_loc3_.y - this.GRID_START.y) / this.GRID_SIZE);
            _loc2_.x = this.GRID_START.x + _loc4_ * this.GRID_SIZE;
            _loc2_.y = this.GRID_START.y + _loc5_ * this.GRID_SIZE;
            this.isPuzzleOver();
        }
        _loc2_.visible = true;
        this._mouseBlock.visible = false;
        this._currentIndex = -1;
    }

    private function isPuzzleOver():void {
        if (this._blockVec[0].y != this._blockVec[1].y || this._blockVec[1].y != this._blockVec[3].y || this._blockVec[0].y != this._blockVec[3].y) {
            return;
        }
        var _loc1_:int = this._blockVec[0].x + this._blockVec[3].x + this._blockVec[1].x;
        if (this._blockVec[3].x - this._blockVec[0].x != 34 || _loc1_ != 1427 && _loc1_ != 1444) {
            return;
        }
        if (this._blockVec[5].y != this._blockVec[6].y || this._blockVec[5].y != this._blockVec[2].y || this._blockVec[6].y != this._blockVec[2].y) {
            return;
        }
        if (this._blockVec[5].x != 436 || this._blockVec[6].x != 453 || this._blockVec[2].x != 504 || this._blockVec[4].x != 436 || this._blockVec[7].x != 436) {
            return;
        }
        if (this._blockVec[7].y - this._blockVec[4].y != 17 || this._blockVec[4].y - this._blockVec[5].y != 51) {
            return;
        }
        if (this._blockVec[2].y == 244 && this._blockVec[3].y != 193) {
            return;
        }
        if (this._blockVec[2].y == 193 && this._blockVec[3].y != 278) {
            return;
        }
        dispatchEvent(new Event(AnimationEvent.PUZZLEPICTURE));
        this.dispose();
    }

    private function onEnterBlock(param1:Event):void {
        this._mouseBlock.x = LayerManager.topLayer.mouseX;
        this._mouseBlock.y = LayerManager.topLayer.mouseY;
    }

    override public function dispose():void {
        super.dispose();
        this.closeEventListener();
    }

    private function closeEventListener():void {
        this.closeBlockListener();
        this._mouseBlock.removeEventListener(Event.ENTER_FRAME, this.onEnterBlock);
        _animation.removeEventListener(MouseEvent.CLICK, this.onContainerClick);
    }
}
}
