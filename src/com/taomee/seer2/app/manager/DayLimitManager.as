package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.info.DayLimitInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
import com.taomee.seer2.core.net.MessageEvent;

public class DayLimitManager {

    private static var _waitVec:Vector.<DayLimitInfo> = new Vector.<DayLimitInfo>();

    private static var _isBusy:Boolean = false;

    private static var _callBack:Function;

    private static var _currentInfo:DayLimitInfo;


    public function DayLimitManager() {
        super();
    }

    public static function getDoCount(param1:int, param2:Function):void {
        var _loc3_:DayLimitInfo = new DayLimitInfo();
        _loc3_.type = param1;
        _loc3_.callBack = param2;
        _waitVec.push(_loc3_);
        if (_isBusy == false) {
            connectServer();
        }
    }

    private static function connectServer():void {
        var _loc1_:MapPanelProtocolPanel = null;
        if (_waitVec.length >= 1) {
            _currentInfo = _waitVec.shift();
            _callBack = _currentInfo.callBack;
            Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, onGetDoCount);
            Connection.addErrorHandler(CommandSet.DAILY_LIMIT_1065, onGetDoCountError);
            Connection.send(CommandSet.DAILY_LIMIT_1065, _currentInfo.type);
            _isBusy = true;
            _loc1_ = MapPanelProtocolPanel.instance();
            if (_loc1_ != null) {
                _loc1_.addLog(MapPanelProtocolPanel.DAY_LIMIT, "\n每日限制： " + CommandSet.DAY_LIMIT_LIST_1241.toString());
            }
        }
    }

    private static function onGetDoCount(param1:MessageEvent):void {
        var _loc3_:MapPanelProtocolPanel = null;
        var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
        if (_loc2_.id == _currentInfo.type) {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, onGetDoCount);
            Connection.removeErrorHandler(CommandSet.DAILY_LIMIT_1065, onGetDoCountError);
            _callBack(_loc2_.count);
            _callBack = null;
            _isBusy = false;
            connectServer();
            _loc3_ = MapPanelProtocolPanel.instance();
            if (_loc3_ != null) {
                MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT, _loc2_.id + "=" + _loc2_.count + "\n");
            }
        }
    }

    private static function onGetDoCountError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, onGetDoCount);
        Connection.removeErrorHandler(CommandSet.DAILY_LIMIT_1065, onGetDoCountError);
        _isBusy = false;
        var _loc2_:MapPanelProtocolPanel = MapPanelProtocolPanel.instance();
        if (_loc2_ != null) {
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT, "\n每日限制：回包异常");
        }
        connectServer();
    }
}
}
