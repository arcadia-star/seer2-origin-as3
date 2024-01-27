package com.taomee.seer2.core.utils {
import com.taomee.seer2.core.ui.UIManager;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class LabelRenderer {

    private static var _tf:TextField;

    private static var _tfFormat:TextFormat;

    private static var _top:Matrix = new Matrix(1, 0, 0, 1, 1, 0);

    private static var _left:Matrix = new Matrix(1, 0, 0, 1, 0, 1);

    private static var _right:Matrix = new Matrix(1, 0, 0, 1, 2, 1);

    private static var _bottom:Matrix = new Matrix(1, 0, 0, 1, 1, 2);

    private static var _center:Matrix = new Matrix(1, 0, 0, 1, 1, 1);

    {
        initialize();
    }

    public function LabelRenderer(param1:Blocker) {
        super();
    }

    private static function initialize():void {
        _tf = new TextField();
        _tfFormat = new TextFormat("_sans", 12);
        _tf.defaultTextFormat = _tfFormat;
    }

    public static function getLabelImage(param1:String, param2:uint = 255, param3:uint = 16777215, param4:uint = 12):Bitmap {
        var _loc5_:Bitmap = new Bitmap();
        if (param4 != 12) {
            _tf.defaultTextFormat = new TextFormat("_sans", param4);
        }
        var _loc6_:TextField;
        (_loc6_ = changeTextField(param1, param2)).defaultTextFormat = _tfFormat;
        var _loc7_:BitmapData;
        (_loc7_ = new BitmapData(_loc6_.width + 2, _loc6_.height + 2, true, 16777215)).draw(changeTextField(param1, param3), _top);
        _loc7_.draw(changeTextField(param1, param3), _left);
        _loc7_.draw(changeTextField(param1, param3), _right);
        _loc7_.draw(changeTextField(param1, param3), _bottom);
        _loc7_.draw(changeTextField(param1, param2), _center);
        _loc5_.bitmapData = _loc7_;
        return _loc5_;
    }

    public static function getYearVipImage(param1:String, param2:uint = 255, param3:uint = 16777215, param4:uint = 12):Bitmap {
        var _loc5_:Bitmap = new Bitmap();
        if (param4 != 12) {
            _tf.defaultTextFormat = new TextFormat("_sans", param4);
        }
        var _loc6_:TextField;
        (_loc6_ = changeTextField(param1, param2)).defaultTextFormat = _tfFormat;
        var _loc7_:Number = _loc6_.textWidth + 2;
        var _loc8_:Sprite = UIManager.getMovieClip("YearVipIconBg") as Sprite;
        var _loc9_:Sprite;
        (_loc9_ = new Sprite()).addChild(_loc8_);
        if (_loc7_ / 40 > 1) {
            _loc8_.scaleX = _loc7_ / 40;
        }
        _loc9_.addChild(_loc6_);
        _loc6_.x = _loc8_.x + (_loc8_.width - _loc6_.width) / 2;
        _loc6_.y = _loc8_.y + (_loc8_.height - _loc6_.height) / 2 + 3;
        var _loc10_:BitmapData = new BitmapData(_loc9_.width + 2, _loc9_.height + 2, true, 16777215);
        changeTextField(param1, param3);
        _loc10_.draw(_loc9_, _top);
        changeTextField(param1, param3);
        _loc10_.draw(_loc9_, _left);
        changeTextField(param1, param3);
        _loc10_.draw(_loc9_, _right);
        changeTextField(param1, param3);
        _loc10_.draw(_loc9_, _bottom);
        changeTextField(param1, param2);
        _loc10_.draw(_loc9_, _center);
        _loc5_.bitmapData = _loc10_;
        return _loc5_;
    }

    private static function changeTextField(param1:String, param2:uint):TextField {
        _tf.autoSize = TextFieldAutoSize.LEFT;
        _tf.textColor = param2;
        _tf.text = param1;
        return _tf;
    }
}
}

class Blocker {


    public function Blocker() {
        super();
    }
}
