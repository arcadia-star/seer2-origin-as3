package org.taomee.player {
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

public class SequenceUtil {

    private static var _rect:Rectangle = new Rectangle();

    private static var _pos:Point = new Point();


    public function SequenceUtil() {
        super();
    }

    public static function makeList(param1:BitmapData, param2:int, param3:int, param4:int, param5:Array, param6:int = 0, param7:int = 0):Vector.<FrameInfo> {
        var _loc8_:FrameInfo = null;
        var _loc11_:FrameInfo = null;
        var _loc13_:ValidFrameInfo = null;
        var _loc14_:FrameInfo = null;
        var _loc9_:Vector.<FrameInfo> = new Vector.<FrameInfo>(param4, true);
        var _loc10_:int = param1.width / param2;
        var _loc12_:int = 0;
        while (_loc12_ < param4) {
            for each(_loc13_ in param5) {
                if (_loc13_.keyFrame == _loc12_) {
                    _loc11_ = null;
                    for each(_loc14_ in _loc9_) {
                        if (_loc14_) {
                            if (_loc13_.index == _loc14_.index) {
                                _loc11_ = _loc14_;
                                break;
                            }
                        }
                    }
                    _loc8_ = new FrameInfo();
                    if (_loc11_) {
                        _loc8_.data = _loc11_.data;
                    } else {
                        _rect.x = int(_loc13_.index % _loc10_) * param2;
                        _rect.y = int(_loc13_.index / _loc10_) * param3;
                        _rect.width = _loc13_.width;
                        _rect.height = _loc13_.height;
                        _loc8_.data = new BitmapData(_loc13_.width, _loc13_.height);
                        _loc8_.data.copyPixels(param1, _rect, _pos);
                    }
                    _loc8_.index = _loc13_.index;
                    _loc8_.offsetX = param6 + _loc13_.offsetX;
                    _loc8_.offsetY = param7 + _loc13_.offsetY;
                    break;
                }
            }
            _loc9_[_loc12_] = _loc8_;
            _loc12_++;
        }
        return _loc9_;
    }
}
}
