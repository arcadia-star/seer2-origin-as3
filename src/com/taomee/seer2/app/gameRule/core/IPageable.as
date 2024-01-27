package com.taomee.seer2.app.gameRule.core {
public interface IPageable {


    function perPage():void;

    function nextPage():void;

    function set dataProvide(param1:Object):void;

    function get currentPageIndex():uint;
}
}
