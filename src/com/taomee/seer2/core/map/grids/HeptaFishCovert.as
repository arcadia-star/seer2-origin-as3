package com.taomee.seer2.core.map.grids {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class HeptaFishCovert {


    public function HeptaFishCovert() {
        super();
    }

    public static function divide(param1:Bitmap, param2:int, param3:int, param4:* = null):Array {
        var _loc10_:int = 0;
        var _loc11_:Array = null;
        var _loc12_:int = 0;
        var _loc13_:BitmapData = null;
        var _loc5_:uint = param1.width / param2;
        var _loc6_:uint = param1.height / param3;
        param4 = param4 == null ? param3 * param2 : param4;
        var _loc7_:Array = new Array();
        var _loc8_:Matrix = new Matrix();
        var _loc9_:Rectangle = new Rectangle(0, 0, _loc5_, _loc6_);
        _loc10_ = 0;
        loop0:
                while (_loc10_ < param3) {
                    _loc11_ = new Array();
                    _loc12_ = 0;
                    while (_loc12_ < param2) {
                        if (param4 <= 0) {
                            break loop0;
                        }
                        _loc13_ = new BitmapData(_loc5_, _loc6_, true, 0);
                        _loc8_.tx = -_loc12_ * _loc5_;
                        _loc8_.ty = -_loc10_ * _loc6_;
                        _loc13_.draw(param1, _loc8_, null, null, _loc9_, true);
                        _loc11_.push(_loc13_);
                        param4--;
                        _loc12_++;
                    }
                    _loc7_.push(_loc11_);
                    _loc10_++;
                }
        return _loc7_;
    }
}
}
