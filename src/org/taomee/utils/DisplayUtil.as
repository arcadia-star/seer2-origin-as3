package org.taomee.utils {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.PixelSnapping;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class DisplayUtil {

    private static const MOUSE_EVENT_LIST:Array = [MouseEvent.CLICK, MouseEvent.DOUBLE_CLICK, MouseEvent.MOUSE_DOWN, MouseEvent.MOUSE_MOVE, MouseEvent.MOUSE_OUT, MouseEvent.MOUSE_OVER, MouseEvent.MOUSE_UP, MouseEvent.MOUSE_WHEEL, MouseEvent.ROLL_OUT, MouseEvent.ROLL_OVER];


    public function DisplayUtil() {
        super();
    }

    public static function FillColor(param1:DisplayObject, param2:uint):void {
        var _loc3_:ColorTransform = new ColorTransform();
        _loc3_.color = param2;
        param1.transform.colorTransform = _loc3_;
    }

    public static function stopAllMovieClip(param1:DisplayObjectContainer, param2:uint = 0):void {
        var _loc5_:DisplayObjectContainer = null;
        var _loc3_:MovieClip = param1 as MovieClip;
        if (_loc3_) {
            if (param2 > 0) {
                _loc3_.gotoAndStop(param2);
            } else {
                _loc3_.stop();
            }
            _loc3_ = null;
        }
        var _loc4_:int;
        if ((_loc4_ = param1.numChildren - 1) < 0) {
            return;
        }
        var _loc6_:int = _loc4_;
        while (_loc6_ >= 0) {
            if ((_loc5_ = param1.getChildAt(_loc6_) as DisplayObjectContainer) != null) {
                stopAllMovieClip(_loc5_, param2);
            }
            _loc6_--;
        }
    }

    public static function hasParent(param1:DisplayObject):Boolean {
        if (param1.parent == null) {
            return false;
        }
        return param1.parent.contains(param1);
    }

    public static function localToLocal(param1:DisplayObject, param2:DisplayObject, param3:Point = null):Point {
        if (param3 == null) {
            param3 = new Point(0, 0);
        }
        param3 = param1.localToGlobal(param3);
        return param2.globalToLocal(param3);
    }

    public static function copyDisplayAsBmp(param1:DisplayObject, param2:Boolean = true):Bitmap {
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        _loc4_ = param1.scaleY;
        _loc3_ = param1.scaleX;
        var _loc5_:BitmapData = new BitmapData(param1.width, param1.height, true, 0);
        var _loc6_:Rectangle = param1.getRect(param1);
        var _loc7_:Matrix = new Matrix();
        if (_loc3_ < 0) {
            param1.scaleX = -param1.scaleX;
        }
        if (_loc4_ < 0) {
            param1.scaleY = -param1.scaleY;
        }
        _loc7_.createBox(param1.scaleX, param1.scaleY, 0, -_loc6_.x * param1.scaleX, -_loc6_.y * param1.scaleY);
        _loc5_.draw(param1, _loc7_);
        param1.scaleX = _loc3_;
        param1.scaleY = _loc4_;
        var _loc8_:Bitmap = new Bitmap(_loc5_, PixelSnapping.AUTO, param2);
        if (_loc3_ < 0) {
            _loc8_.scaleX = -1;
        }
        if (_loc4_ < 0) {
            _loc8_.scaleY = -1;
        }
        _loc8_.x = _loc6_.x * param1.scaleX;
        _loc8_.y = _loc6_.y * param1.scaleY;
        return _loc8_;
    }

    public static function mouseEnabledAll(param1:InteractiveObject, param2:Boolean = false):void {
        var container:DisplayObjectContainer;
        var i:int = 0;
        var child:InteractiveObject = null;
        var target:InteractiveObject = param1;
        var isAll:Boolean = param2;
        var b:Boolean = MOUSE_EVENT_LIST.some(function (param1:String, param2:int, param3:Array):Boolean {
            if (target.hasEventListener(param1)) {
                return true;
            }
            return false;
        });
        if (!b) {
            if (target.name.indexOf("instance") != -1) {
                target.mouseEnabled = false;
            }
        }
        container = target as DisplayObjectContainer;
        if (container) {
            i = container.numChildren - 1;
            while (i >= 0) {
                child = container.getChildAt(i) as InteractiveObject;
                if (child) {
                    mouseEnabledAll(child);
                }
                i--;
            }
        }
    }

    public static function align(param1:DisplayObject, param2:int = 4, param3:Rectangle = null, param4:Point = null):void {
        var _loc5_:Rectangle = null;
        if (param3 == null) {
            if (!param1.stage) {
                param1.addEventListener(Event.ADDED_TO_STAGE, Delegate.create(onAddStage, param2, param4), false, 0, true);
                return;
            }
            _loc5_ = new Rectangle(0, 0, param1.stage.stageWidth, param1.stage.stageHeight);
        } else {
            _loc5_ = param3.clone();
        }
        align2(param1, _loc5_, param2, param4);
    }

    public static function getColor(param1:DisplayObject, param2:uint = 0, param3:uint = 0, param4:Boolean = false):uint {
        var _loc5_:BitmapData;
        (_loc5_ = new BitmapData(param1.width, param1.height)).draw(param1);
        var _loc6_:uint = !param4 ? _loc5_.getPixel(int(param2), int(param3)) : _loc5_.getPixel32(int(param2), int(param3));
        _loc5_.dispose();
        return _loc6_;
    }

    public static function removeForParent(param1:DisplayObject, param2:Boolean = true):void {
        var _loc3_:DisplayObjectContainer = null;
        if (param1 == null) {
            return;
        }
        if (param1.parent == null) {
            return;
        }
        if (param2) {
            _loc3_ = param1 as DisplayObjectContainer;
            if (_loc3_) {
                stopAllMovieClip(_loc3_);
                _loc3_ = null;
            }
        }
        param1.parent.removeChild(param1);
    }

    public static function playAllMovieClip(param1:DisplayObjectContainer):void {
        var _loc4_:DisplayObjectContainer = null;
        var _loc2_:MovieClip = param1 as MovieClip;
        if (_loc2_ != null) {
            _loc2_.gotoAndPlay(1);
            _loc2_ = null;
        }
        var _loc3_:int = param1.numChildren - 1;
        if (_loc3_ < 0) {
            return;
        }
        var _loc5_:int = _loc3_;
        while (_loc5_ >= 0) {
            if ((_loc4_ = param1.getChildAt(_loc5_) as DisplayObjectContainer) != null) {
                playAllMovieClip(_loc4_);
            }
            _loc5_--;
        }
    }

    private static function align2(param1:DisplayObject, param2:Rectangle, param3:int, param4:Point):void {
        if (param4) {
            param2.offsetPoint(param4);
        }
        var _loc5_:Rectangle = param1.getRect(param1);
        var _loc6_:Number = param2.width - param1.width;
        var _loc7_:Number = param2.height - param1.height;
        switch (param3) {
            case AlignType.TOP_LEFT:
                param1.x = param2.x;
                param1.y = param2.y;
                break;
            case AlignType.TOP_CENTER:
                param1.x = param2.x + _loc6_ / 2 - _loc5_.x;
                param1.y = param2.y;
                break;
            case AlignType.TOP_RIGHT:
                param1.x = param2.x + _loc6_ - _loc5_.x;
                param1.y = param2.y;
                break;
            case AlignType.MIDDLE_LEFT:
                param1.x = param2.x;
                param1.y = param2.y + _loc7_ / 2 - _loc5_.x;
                break;
            case AlignType.MIDDLE_CENTER:
                param1.x = param2.x + _loc6_ / 2 - _loc5_.x;
                param1.y = param2.y + _loc7_ / 2 - _loc5_.y;
                break;
            case AlignType.MIDDLE_RIGHT:
                param1.x = param2.x + _loc6_ - _loc5_.x;
                param1.y = param2.y + _loc7_ / 2 - _loc5_.y;
                break;
            case AlignType.BOTTOM_LEFT:
                param1.x = param2.x;
                param1.y = param2.y + _loc7_ - _loc5_.y;
                break;
            case AlignType.BOTTOM_CENTER:
                param1.x = param2.x + _loc6_ / 2 - _loc5_.x;
                param1.y = param2.y + _loc7_ - _loc5_.y;
                break;
            case AlignType.BOTTOM_RIGHT:
                param1.x = param2.x + _loc6_ - _loc5_.x;
                param1.y = param2.y + _loc7_ - _loc5_.y;
        }
    }

    public static function uniformScale(param1:DisplayObject, param2:Number):void {
        if (param1.width >= param1.height) {
            param1.width = param2;
            param1.scaleY = param1.scaleX;
        } else {
            param1.height = param2;
            param1.scaleX = param1.scaleY;
        }
    }

    private static function onAddStage(param1:Event, param2:int, param3:Point):void {
        var _loc5_:DisplayObject;
        (_loc5_ = param1.currentTarget as DisplayObject).removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
        align2(_loc5_, new Rectangle(0, 0, _loc5_.stage.stageWidth, _loc5_.stage.stageHeight), param2, param3);
    }

    public static function removeAllChild(param1:DisplayObjectContainer):void {
        var _loc2_:DisplayObjectContainer = null;
        while (param1.numChildren > 0) {
            _loc2_ = param1.removeChildAt(0) as DisplayObjectContainer;
            if (_loc2_ != null) {
                stopAllMovieClip(_loc2_);
                _loc2_ = null;
            }
        }
    }
}
}
