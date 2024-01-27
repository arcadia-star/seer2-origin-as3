package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.utils.URLUtil;

public class LocalMsgManager {

    private static var _instance:LocalMsgManager;

    private static const SEER2_MOVIE:uint = 0;

    private static const PETKING_MODIEY:uint = 1;

    private static const NOTICE:uint = 2;


    private var _noticeSettingData:XML;

    private var _curtVersion:uint;

    public function LocalMsgManager(param1:PrivateClass) {
        super();
    }

    public static function getInstance():LocalMsgManager {
        if (_instance == null) {
            _instance = new LocalMsgManager(new PrivateClass());
        }
        return _instance;
    }

    public function setup():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.LOCAL_MESSAGE, this.getBuffer);
    }

    private function getBuffer(param1:ServerBuffer):void {
        var _loc2_:int = 0;
        var _loc3_:Object = null;
        _loc2_ = param1.readDataAtPostion(PETKING_MODIEY);
        if (_loc2_ == 0) {
        }
        _loc2_ = param1.readDataAtPostion(NOTICE);
        QueueLoader.load(URLUtil.getNoticeSetting(), LoadType.TEXT, this.onSettingDataLoaded);
        this._curtVersion = _loc2_;
    }

    private function onSettingDataLoaded(param1:ContentInfo):void {
        this._noticeSettingData = XML(param1.content);
        this.parseNotice();
    }

    private function parseNotice():void {
        var _loc3_:Object = null;
        var _loc1_:uint = uint(this._noticeSettingData.@version);
        var _loc2_:String = this._noticeSettingData.elements("content");
        if (_loc1_ > this._curtVersion) {
        }
    }
}
}

class PrivateClass {


    public function PrivateClass() {
        super();
    }
}
