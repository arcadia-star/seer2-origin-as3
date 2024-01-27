package com.taomee.seer2.app.gameRule.nono.core {
import flash.display.SimpleButton;

public interface INonoBehavior {


    function get tipDescription():String;

    function set iconButton(param1:SimpleButton):void;

    function get iconButton():SimpleButton;

    function clickHandler():void;

    function dispose():void;

    function get nonoX():Number;

    function get nonoY():Number;
}
}
