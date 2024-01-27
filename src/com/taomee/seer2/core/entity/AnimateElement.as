package com.taomee.seer2.core.entity {
import com.taomee.seer2.core.animation.FramePlayer;
import com.taomee.seer2.core.animation.IAnimation;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class AnimateElement extends Sprite {


    private var _id:uint;

    private var _animation:IAnimation;

    private var _resourceUrl:String;

    private var _height:Number = -1;

    private var _width:Number = -1;

    private var _action:String;

    private var _wrappers:Vector.<ListenerWrapper>;

    private var _pos:Point;

    public function AnimateElement() {
        this._pos = new Point();
        super();
    }

    public function set id(param1:uint):void {
        this._id = param1;
    }

    public function get id():uint {
        return this._id;
    }

    override public function set width(param1:Number):void {
        this._width = param1;
    }

    override public function get width():Number {
        if (this._width == -1) {
            return super.width;
        }
        return this._width;
    }

    override public function set height(param1:Number):void {
        this._height = param1;
    }

    override public function get height():Number {
        if (this._height == -1) {
            return super.height;
        }
        return this._height;
    }

    public function get pos():Point {
        this._pos.x = x;
        this._pos.y = y;
        return this._pos;
    }

    public function setPostion(param1:Point):void {
        this.x = param1.x;
        this.y = param1.y;
    }

    public function set resourceUrl(param1:String):void {
        if (param1 != null) {
            this._resourceUrl = param1;
            this.animation = new FramePlayer(this._resourceUrl);
        }
    }

    public function get resourceUrl():String {
        return this._resourceUrl;
    }

    public function set animation(param1:IAnimation):void {
        if (param1 != null) {
            this.clearAnimation();
            this._animation = param1;
            addChild(this._animation as DisplayObject);
            this._animation.play();
        }
    }

    public function get animation():IAnimation {
        return this._animation;
    }

    public function play():void {
        this._animation.play();
    }

    public function stop():void {
        this._animation.stop();
    }

    public function gotoAndStop(param1:uint):void {
        this._animation.gotoAndStop(param1);
    }

    public function gotoAndPlay(param1:uint):void {
        this._animation.gotoAndPlay(param1);
    }

    public function get currentFrameIndex():uint {
        return this._animation.currentFrameIndex;
    }

    public function set action(param1:String):void {
        this._action = param1;
        this._animation.gotoLabel(this.action);
    }

    public function get action():String {
        return this._action;
    }

    public function update():void {
        if (this._animation != null) {
            this._animation.update();
        }
    }

    public function addActionEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        (this._animation as EventDispatcher).addEventListener(param1, param2, param3, param4, param5);
    }

    public function removeActionEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        (this._animation as EventDispatcher).removeEventListener(param1, param2, param3);
    }

    public function hasActionEventListener(param1:String):Boolean {
        return (this._animation as EventDispatcher).hasEventListener(param1);
    }

    override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        if (this._wrappers == null) {
            this._wrappers = new Vector.<ListenerWrapper>();
        }
        this._wrappers.push(new ListenerWrapper(param1, param2));
        super.addEventListener(param1, param2, param3, param4, param5);
    }

    override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        this.removeListenerWrapper(param2);
        super.removeEventListener(param1, param2, param3);
    }

    private function removeListenerWrapper(param1:Function):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (this._wrappers) {
            _loc2_ = int(this._wrappers.length);
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                if (this._wrappers[_loc3_].listener == param1) {
                    this._wrappers.splice(_loc3_, 1);
                    return;
                }
                _loc3_++;
            }
        }
    }

    public function removeEventListenerByType(param1:String):void {
        var _loc4_:ListenerWrapper = null;
        if (this._wrappers == null) {
            return;
        }
        var _loc2_:int = int(this._wrappers.length);
        var _loc3_:int = _loc2_ - 1;
        while (_loc3_ > 0) {
            if ((_loc4_ = this._wrappers[_loc3_]).type == param1) {
                this.removeEventListener(_loc4_.type, _loc4_.listener);
            }
            _loc3_--;
        }
    }

    private function removeAllListenerWrapper():void {
        var _loc1_:ListenerWrapper = null;
        for each(_loc1_ in this._wrappers) {
            this.removeEventListener(_loc1_.type, _loc1_.listener);
        }
        this._wrappers = null;
    }

    private function clearAnimation():void {
        if (this._animation != null) {
            DisplayUtil.removeForParent(this._animation as DisplayObject);
            this._animation.dispose();
            this._animation = null;
        }
    }

    public function dispose():void {
        this.clearAnimation();
        this.removeAllListenerWrapper();
    }
}
}

class ListenerWrapper {


    public var type:String;

    public var listener:Function;

    public function ListenerWrapper(param1:String, param2:Function) {
        super();
        this.type = param1;
        this.listener = param2;
    }
}
