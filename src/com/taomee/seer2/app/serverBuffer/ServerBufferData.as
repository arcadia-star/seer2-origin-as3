package com.taomee.seer2.app.serverBuffer {
public class ServerBufferData {


    public var position:int;

    public var value:*;

    public var bit:int;

    public function ServerBufferData(param1:int, param2:*, param3:int = 1) {
        super();
        this.position = param1;
        this.value = param2;
        this.bit = param3;
    }
}
}
