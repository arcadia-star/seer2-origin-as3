package com.taomee.seer2.app.component {
public interface IBaseView {


    function init():void;

    function updateView(param1:*):void;

    function clearView():void;

    function dispose():void;
}
}
