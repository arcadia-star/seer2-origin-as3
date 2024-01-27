package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.core.net.MessageEvent;

public class InteractiveRewardManager {

    private static var _successCallBack:Function;

    private static var _errorCallBack:Function;

    private static var _waitList:Array;

    private static var _isRequesting:Boolean = false;

    {
        initialize();
    }

    public function InteractiveRewardManager() {
        super();
    }

    private static function initialize():void {
        _waitList = new Array();
    }

    public static function requestReward(param1:uint, param2:Function, param3:Function = null):void {
        if (param1) {
            _waitList.push({
                "id": param1,
                "success": param2,
                "error": param3
            });
        }
        processNextRequest();
    }

    private static function processNextRequest():void {
        var _loc1_:Object = null;
        if (Boolean(_waitList.length) && _isRequesting == false) {
            _isRequesting = true;
            _loc1_ = _waitList.shift();
            _successCallBack = _loc1_.success;
            _errorCallBack = _loc1_.error;
            Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060, onGerRewardError);
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, onGetRewardSuccess);
            Connection.send(CommandSet.DIGGER_MINE_1060, _loc1_.id);
        }
    }

    private static function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, onGetRewardSuccess);
        var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
        _successCallBack(_loc2_);
        _successCallBack = null;
        _isRequesting = false;
        processNextRequest();
    }

    private static function onGerRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, onGetRewardSuccess);
        if (_errorCallBack != null) {
            _errorCallBack(param1.message.statusCode);
            _errorCallBack = null;
        }
        _isRequesting = false;
        processNextRequest();
    }
}
}
