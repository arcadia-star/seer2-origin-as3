package com.taomee.seer2.core.quest.data {
public class TargetDefinition {


    public var type:String;

    public var count:int;

    public var params:String;

    public var alert:String;

    public var transport:String;

    public function TargetDefinition(param1:XML = null) {
        super();
        if (param1 != null) {
            this.parseData(param1);
        }
    }

    private function parseData(param1:XML):void {
        this.type = param1.attribute("type").toString();
        this.count = int(param1.attribute("count").toString());
        this.params = param1.attribute("params").toString();
        this.alert = param1.attribute("alert").toString();
        this.transport = param1.attribute("transport").toString();
    }
}
}
