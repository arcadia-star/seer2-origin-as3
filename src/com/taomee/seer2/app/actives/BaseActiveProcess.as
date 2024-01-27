package com.taomee.seer2.app.actives {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.ResourceLibrary;

import flash.display.Loader;

public class BaseActiveProcess implements IActiveProcess {


    protected var _loader:Loader;

    protected var _resLib:ResourceLibrary;

    public function BaseActiveProcess() {
        super();
    }

    public function start():void {
    }

    protected function loadResouse(param1:int, param2:Function):void {
        var id:int = param1;
        var onLoad:Function = param2;
        QueueLoader.load("res/active/resource/" + id + ".swf", LoadType.DOMAIN, function (param1:ContentInfo):void {
            _resLib = new ResourceLibrary(param1.content);
            onLoad();
        });
    }
}
}
