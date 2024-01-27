package com.taomee.seer2.app.home.panel.buddy {
import com.taomee.seer2.core.utils.NumberUtil;

import flash.display.MovieClip;
import flash.display.Sprite;

import org.taomee.utils.AlignType;
import org.taomee.utils.DisplayUtil;

public class HomeNumber extends Sprite {


    private var _container:Sprite;

    private var _numberVec:Vector.<MovieClip>;

    private var _number:int;

    private var _alignType:int;

    private var _initialWidth:int;

    public function HomeNumber(param1:MovieClip, param2:int) {
        super();
        this._container = param1;
        this._alignType = param2;
        this._initialWidth = this._container.width;
        this.initialize();
    }

    private function initialize():void {
        this.addContainer();
        this.extractAssets();
    }

    private function addContainer():void {
        this.x = this._container.x;
        this.y = this._container.y;
        this._container.x = 0;
        this._container.y = 0;
        addChild(this._container);
    }

    private function extractAssets():void {
        this._numberVec = new Vector.<MovieClip>();
        this.extractMcByName("hundred");
        this.extractMcByName("ten");
        this.extractMcByName("one");
    }

    private function extractMcByName(param1:String):void {
        var _loc2_:MovieClip = this._container[param1];
        _loc2_.gotoAndStop(1);
        this._numberVec.push(_loc2_);
    }

    public function setNumber(param1:int):void {
        this._number = param1;
        this.resetNumberVec();
        this.updateNumberVec();
        this.updateLayout();
    }

    private function resetNumberVec():void {
        var _loc1_:int = int(this._numberVec.length);
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            DisplayUtil.removeForParent(this._numberVec[_loc2_]);
            _loc2_++;
        }
    }

    private function updateNumberVec():void {
        var _loc5_:MovieClip = null;
        var _loc1_:Vector.<int> = NumberUtil.parseNumberToDigitVec(this._number);
        var _loc2_:int = int(_loc1_.length);
        var _loc3_:int = int(this._numberVec.length);
        var _loc4_:int = _loc2_ - 1;
        while (_loc4_ >= 0) {
            (_loc5_ = this._numberVec[--_loc3_]).gotoAndStop(_loc1_[_loc4_] + 1);
            this._container.addChild(_loc5_);
            _loc4_--;
        }
    }

    private function updateLayout():void {
        this.updateCoordinate();
        switch (this._alignType) {
            case AlignType.MIDDLE_LEFT:
                this._container.x = 0;
                break;
            case AlignType.MIDDLE_CENTER:
                this._container.x = (this._initialWidth - this._container.width) / 2;
        }
    }

    private function updateCoordinate():void {
        var _loc1_:int = 9;
        var _loc2_:int = int(this._numberVec.length);
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            if (this._numberVec[_loc4_].parent != null) {
                this._numberVec[_loc4_].x = _loc3_++ * _loc1_;
            }
            _loc4_++;
        }
    }
}
}
