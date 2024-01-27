package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.popup.AlertInfo;

import flash.events.IEventDispatcher;

public interface IAlert extends IEventDispatcher {


    function show(param1:AlertInfo):void;

    function dispose():void;

    function get x():Number;

    function set x(param1:Number):void;

    function get y():Number;

    function set y(param1:Number):void;

    function get width():Number;

    function get height():Number;
}
}
