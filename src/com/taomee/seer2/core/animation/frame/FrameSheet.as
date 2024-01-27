package com.taomee.seer2.core.animation.frame {
import com.taomee.seer2.core.log.Logger;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

public class FrameSheet {


    private var _unitWidth:uint;

    private var _unitHeight:uint;

    private var _sheetBitmapData:BitmapData;

    private var _frameNum:uint;

    private var _frameInfoVec:Vector.<FrameInfo>;

    private var _logger:Logger;

    private var _isReady:Boolean = false;

    private var _frameNumX:uint;

    private var _frameNumY:uint;

    private var _initializedFrameCount:uint;

    private var _loader:Loader;

    public function FrameSheet(param1:ByteArray) {
        super();
        this._logger = Logger.getLogger("FrameSheet");
        this.parseFrameInfo(param1);
        this.parseSheet(param1);
    }

    private function parseFrameInfo(param1:ByteArray):void {
        var _loc5_:FrameInfo = null;
        var _loc2_:ByteArray = new ByteArray();
        var _loc3_:int = param1.readShort();
        param1.readBytes(_loc2_, 0, _loc3_);
        this._unitWidth = _loc2_.readShort();
        this._unitHeight = _loc2_.readShort();
        this._frameNum = _loc2_.readShort();
        this._frameInfoVec = new Vector.<FrameInfo>();
        var _loc4_:int = 0;
        while (_loc4_ < this._frameNum) {
            (_loc5_ = new FrameInfo()).keyNum = _loc2_.readShort();
            _loc5_.offsetX = _loc2_.readShort();
            _loc5_.offsetY = _loc2_.readShort();
            _loc5_.contentWidth = _loc2_.readShort();
            _loc5_.contentHeight = _loc2_.readShort();
            _loc5_.sheetIndex = _loc2_.readShort();
            this._frameInfoVec.push(_loc5_);
            _loc4_++;
        }
    }

    private function parseSheet(param1:ByteArray):void {
        var _loc2_:ByteArray = new ByteArray();
        param1.readBytes(_loc2_);
        _loc2_.position = 0;
        this._loader = new Loader();
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onImageLoaded);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
        this._loader.loadBytes(_loc2_);
    }

    private function removeImageLoaderEventListener():void {
        if (this._loader) {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onImageLoaded);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
        }
    }

    private function onImageLoaded(param1:Event):void {
        this.removeImageLoaderEventListener();
        var _loc2_:LoaderInfo = param1.target as LoaderInfo;
        this._sheetBitmapData = (_loc2_.content as Bitmap).bitmapData;
        this._frameNumX = this._sheetBitmapData.width / this._unitWidth;
        this._frameNumY = this._sheetBitmapData.height / this._unitHeight;
        this._isReady = true;
        this._loader.unloadAndStop();
        this._loader = null;
    }

    private function onError(param1:Event):void {
        this._logger.error("文件解析失败");
    }

    public function get isReady():Boolean {
        return this._isReady;
    }

    public function getFrameInfo(param1:int):FrameInfo {
        var _loc2_:uint = this.findFrameInfoIndex(param1);
        var _loc3_:FrameInfo = this._frameInfoVec[_loc2_];
        if (_loc3_.bitmapData == null) {
            this.createFrameData(_loc3_, _loc3_.sheetIndex);
        }
        return _loc3_;
    }

    private function findFrameInfoIndex(param1:uint):uint {
        var _loc4_:FrameInfo = null;
        var _loc2_:int = int(this._frameInfoVec.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this._frameInfoVec[_loc3_];
            if (param1 == _loc4_.keyNum) {
                return _loc3_;
            }
            if (param1 < _loc4_.keyNum) {
                return _loc3_ - 1;
            }
            _loc3_++;
        }
        return _loc2_ - 1;
    }

    private function createFrameData(param1:FrameInfo, param2:int):void {
        var _loc8_:BitmapData = null;
        var _loc3_:int = param2 % this._frameNumX;
        var _loc4_:int = param2 / this._frameNumX;
        var _loc5_:int = _loc3_ * this._unitWidth;
        var _loc6_:int = _loc4_ * this._unitHeight;
        var _loc7_:Rectangle = new Rectangle(_loc5_, _loc6_, param1.contentWidth, param1.contentHeight);
        (_loc8_ = new BitmapData(param1.contentWidth, param1.contentHeight, true, 16724991)).copyPixels(this._sheetBitmapData, _loc7_, new Point(0, 0));
        param1.bitmapData = _loc8_;
        ++this._initializedFrameCount;
        if (this._initializedFrameCount >= this._frameNum) {
            this.disposeSheetImage();
        }
    }

    private function disposeSheetImage():void {
        if (this._sheetBitmapData) {
            this._sheetBitmapData.dispose();
            this._sheetBitmapData = null;
        }
    }

    public function dispose():void {
        var _loc1_:FrameInfo = null;
        this.removeImageLoaderEventListener();
        for each(_loc1_ in this._frameInfoVec) {
            if (_loc1_.bitmapData) {
                _loc1_.bitmapData.dispose();
            }
            _loc1_ = null;
        }
        this._frameInfoVec = null;
        this.disposeSheetImage();
    }
}
}
