package com.taomee.seer2.core.cache {
import com.taomee.seer2.core.loader.ContentInfo;

import flash.display.DisplayObject;

import org.taomee.utils.DomainUtil;

internal class PhasorParse extends CacheImpl {


    public function PhasorParse() {
        super();
    }

    override protected function parseOutput(param1:String, param2:String, param3:Function, param4:CacheInfo, param5:* = null):void {
        var _loc6_:DisplayObject = DomainUtil.getDisplayObject(name, param4.content);
        param3(new ContentInfo(param1, param2, _loc6_, param4.domain, param5));
    }
}
}
