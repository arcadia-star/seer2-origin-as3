package com.taomee.seer2.app.serverBuffer {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;

import org.taomee.ds.HashMap;

public class GetServerBufferHandler implements IGetServerBufferHandler {


    public var serverBufferType:int;

    public var callBackFunction:Function;

    public var bufferMap:HashMap;

    public function GetServerBufferHandler(param1:int, param2:HashMap, param3:Function) {
        this.serverBufferType = param1;
        this.bufferMap = param2;
        this.callBackFunction = param3;
        super();
    }

    public function getServerBufferData(param1:MessageEvent):void {
        var _loc4_:ServerBuffer = null;
        var _loc2_:LittleEndianByteArray = param1.message.getRawData().clone();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        if (_loc3_ == this.serverBufferType) {
            Connection.removeCommandListener(CommandSet.CLIENT_GET_BUFFER_INFO_1062, this.getServerBufferData);
            _loc4_ = new ServerBuffer(_loc2_, this.serverBufferType);
            this.bufferMap.add(this.serverBufferType, _loc4_);
            this.callBackFunction(this.bufferMap.getValue(this.serverBufferType) as ServerBuffer);
            this.serverBufferType = 0;
            this.bufferMap = null;
            this.callBackFunction = null;
        }
    }
}
}
