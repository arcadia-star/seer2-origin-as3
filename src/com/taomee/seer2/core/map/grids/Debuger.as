package com.taomee.seer2.core.map.grids {
import flash.events.*;
import flash.external.ExternalInterface;
import flash.text.TextField;
import flash.utils.Timer;

import mx.events.PropertyChangeEvent;

public class Debuger implements IEventDispatcher {

    public static var JS_COMMAND:Array = ["sendToActionScript", "sendToJavaScript"];

    private static var _1514753340STATIC_DEBUG_MSG:String = "";

    private static var _staticBindingEventDispatcher:EventDispatcher = new EventDispatcher();


    private var _bindingEventDispatcher:EventDispatcher;

    public function Debuger() {
        this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
        super();
    }

    public static function debug(param1:TextField, param2:String):void {
        param1.appendText(param2);
    }

    public static function staticDebug(param1:String, param2:Boolean = true):void {
        if (param2) {
            STATIC_DEBUG_MSG += param1;
        } else {
            STATIC_DEBUG_MSG = param1;
        }
    }

    public static function callBackDebug(param1:Function, ...rest):void {
    }

    public static function JSDebug(param1:String):void {
        var _loc2_:Timer = null;
        if (ExternalInterface.available) {
            try {
                ExternalInterface.call(JS_COMMAND[1], param1);
                if (!checkJavaScriptReady()) {
                    _loc2_ = new Timer(100, 0);
                    _loc2_.addEventListener(TimerEvent.TIMER, timerHandler);
                    _loc2_.start();
                }
            } catch (error:SecurityError) {
            } catch (error:Error) {
            }
        }
    }

    private static function receivedFromJavaScript(param1:String):void {
    }

    private static function checkJavaScriptReady():Boolean {
        return ExternalInterface.call("isReady");
    }

    private static function timerHandler(param1:TimerEvent):void {
        var _loc2_:Boolean = checkJavaScriptReady();
        if (_loc2_) {
            Timer(param1.target).stop();
        }
    }

    private static function clickHandler(param1:MouseEvent):void {
        if (ExternalInterface.available) {
        }
    }

    [Bindable(event="propertyChange")]
    public static function get STATIC_DEBUG_MSG():String {
        return Debuger._1514753340STATIC_DEBUG_MSG;
    }

    public static function set STATIC_DEBUG_MSG(param1:String):void {
        var _loc3_:IEventDispatcher = null;
        var _loc2_:Object = Debuger._1514753340STATIC_DEBUG_MSG;
        switch (param1) {
            default:
                _loc3_.dispatchEvent(PropertyChangeEvent.createUpdateEvent(Debuger, "STATIC_DEBUG_MSG", _loc2_, param1));
                break;
            case _loc2_:
            case _loc3_:
        }
    }

    public static function get staticEventDispatcher():IEventDispatcher {
        return _staticBindingEventDispatcher;
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        this._bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public function dispatchEvent(param1:Event):Boolean {
        return this._bindingEventDispatcher.dispatchEvent(param1);
    }

    public function hasEventListener(param1:String):Boolean {
        return this._bindingEventDispatcher.hasEventListener(param1);
    }

    public function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        this._bindingEventDispatcher.removeEventListener(param1, param2, param3);
    }

    public function willTrigger(param1:String):Boolean {
        return this._bindingEventDispatcher.willTrigger(param1);
    }
}
}
