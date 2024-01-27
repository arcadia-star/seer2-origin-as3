package com.taomee.seer2.app.arena.animation.core {
import flash.events.IEventDispatcher;

public interface IArenaAnimation extends IEventDispatcher {


    function get completeParams():Object;

    function set completeParams(param1:Object):void;

    function dispose():void;

    function initData(param1:Object):void;

    function initialize():void;

    function get onComplete():Function;

    function set onComplete(param1:Function):void;

    function play():void;
}
}
