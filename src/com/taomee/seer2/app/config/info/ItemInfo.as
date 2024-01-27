package com.taomee.seer2.app.config.info {
public class ItemInfo {


    public var id:int;

    public var count:int;

    public function ItemInfo(param1:XML) {
        super();
        this.id = int(param1.attribute("id"));
        this.count = int(param1.attribute("count"));
    }
}
}
