package com.taomee.seer2.app.entity.handler {
import flash.net.URLRequest;
import flash.net.navigateToURL;

public class HandlerHttpClick extends HandlerEntityClick {


    private var _url:String;

    public function HandlerHttpClick() {
        super();
    }

    override public function initData(param1:XML):void {
        this._url = param1.toString();
    }

    override protected function action():void {
        navigateToURL(new URLRequest(this._url), "_blank");
    }
}
}
