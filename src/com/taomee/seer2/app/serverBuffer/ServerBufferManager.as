package com.taomee.seer2.app.serverBuffer {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;

import org.taomee.ds.HashMap;

public class ServerBufferManager {

    private static var _bufferMap:HashMap;

    {
        initialize();
    }

    public function ServerBufferManager() {
        super();
    }

    private static function initialize():void {
        _bufferMap = new HashMap();
    }

    public static function getServerBuffer(param1:int, param2:Function, param3:Boolean = true):void {
        var _loc4_:GetServerBufferHandler = null;
        if (Boolean(_bufferMap.containsKey(param1)) && param3) {
            param2(_bufferMap.getValue(param1) as ServerBuffer);
        } else {
            _loc4_ = new GetServerBufferHandler(param1, _bufferMap, param2);
            Connection.addCommandListener(CommandSet.CLIENT_GET_BUFFER_INFO_1062, _loc4_.getServerBufferData);
            Connection.send(CommandSet.CLIENT_GET_BUFFER_INFO_1062, param1);
        }
    }

    public static function updateServerBuffer(param1:int, param2:int, param3:*):void {
        var _loc4_:UpdateServerBufferHandler = new UpdateServerBufferHandler(param1, Vector.<ServerBufferData>([new ServerBufferData(param2, param3)]));
        getServerBuffer(param1, _loc4_.updateServerBufferHandler);
    }

    public static function updateServerBufferGroup(param1:int, param2:Vector.<ServerBufferData>):void {
        var _loc3_:UpdateServerBufferHandler = new UpdateServerBufferHandler(param1, param2);
        getServerBuffer(param1, _loc3_.updateServerBufferHandler);
    }

    public static function updataSvrExpandBuffer(param1:int, param2:int, param3:int):void {
        Connection.send(CommandSet.CLIENT_SET_SVR_BUF_INFO_1113, param1, param2, param3);
    }

    public static function updateServerBufferList(param1:int, param2:int, param3:Vector.<int>):void {
        var _loc4_:UpdateServerBufferList = new UpdateServerBufferList(param1, param2, param3);
        getServerBuffer(param1, _loc4_.updateServerBufferHandler);
    }

    //todo dev
    public static function getPetSkin(monsterId:int, cb:Function) {
        if (monsterId > 10000) {
            cb(-1);
            return;
        }
        ServerBufferManager.getServerBuffer(10000 + monsterId, function (buffer:ServerBuffer) {
            var skinId = buffer.readDataAtPostionGetInt(0);
            cb(skinId);
        });
    }

    //todo dev
    public static function setPetSkin(monsterId:int, skinId:int) {
        if (monsterId > 10000) {
            return;
        }
        ServerBufferManager.updateServerBuffer(10000 + monsterId, 0, skinId);
    }
}
}
