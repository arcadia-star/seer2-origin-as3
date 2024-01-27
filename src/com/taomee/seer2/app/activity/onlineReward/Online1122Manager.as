package com.taomee.seer2.app.activity.onlineReward {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class Online1122Manager {

    private static var _waitList:Array = new Array();

    private static var _isRequesting:Boolean = false;

    private static var _successCallBack:Function;

    private static var _errorCallBack:Function;


    public function Online1122Manager() {
        super();
    }

    public static function request1122(param1:Function, param2:Function = null):void {
        _waitList.push({
            "success": param1,
            "error": param2
        });
        processNextRequest();
    }

    private static function processNextRequest():void {
        var _loc1_:Object = null;
        if (Boolean(_waitList.length) && _isRequesting == false) {
            _isRequesting = true;
            _loc1_ = _waitList.shift();
            _successCallBack = _loc1_.success;
            _errorCallBack = _loc1_.error;
            Connection.addErrorHandler(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122, onGerRewardError);
            Connection.addCommandListener(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122, onGetRewardSuccess);
            Connection.send(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122);
        }
    }

    private static function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122, onGerRewardError);
        Connection.removeCommandListener(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122, onGetRewardSuccess);
        _successCallBack(param1.message.getRawData());
        _successCallBack = null;
        _isRequesting = false;
        processNextRequest();
    }

    private static function onGerRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122, onGerRewardError);
        Connection.removeCommandListener(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122, onGetRewardSuccess);
        if (_errorCallBack != null) {
            _errorCallBack(param1.message.statusCode);
            _errorCallBack = null;
        }
        _isRequesting = false;
        processNextRequest();
    }
}
}
