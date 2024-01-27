package com.taomee.seer2.core.cache {
import flash.system.ApplicationDomain;

internal class CacheInfo {


    public var url:String;

    public var content:*;

    public var domain:ApplicationDomain;

    public function CacheInfo() {
        super();
    }

    public function dispose():void {
        this.content = null;
        this.domain = null;
    }
}
}
