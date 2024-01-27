package com.taomee.seer2.app {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

public class GetUsrStarBetweenTimeManager {

    public static var money:int;

    private static var _successCallBack:Function;

    private static var _errorCallBack:Function;


    public function GetUsrStarBetweenTimeManager() {
        super();
    }

    public static function sellStar(param1:uint, param2:int, param3:uint, param4:Function, param5:Function = null):void {
        _successCallBack = param4;
        _errorCallBack = param5;
        Connection.addErrorHandler(CommandSet.CLI_HAVECLIE_REQUEST_1271, onSellError);
        Connection.addCommandListener(CommandSet.CLI_HAVECLIE_REQUEST_1271, onStar);
        Connection.send(CommandSet.CLI_HAVECLIE_REQUEST_1271, param1, param2, param3);
    }

    private static function onStar(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.CLI_HAVECLIE_REQUEST_1271, onSellError);
        Connection.removeCommandListener(CommandSet.CLI_HAVECLIE_REQUEST_1271, onStar);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        money = _loc2_.readUnsignedInt();
        _successCallBack();
        _errorCallBack = null;
    }

    private static function onSellError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.CLI_HAVECLIE_REQUEST_1271, onSellError);
        Connection.removeCommandListener(CommandSet.CLI_HAVECLIE_REQUEST_1271, onStar);
        _successCallBack();
        _errorCallBack = null;
    }
}
}
