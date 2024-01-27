package com.taomee.analytics {
import com.taomee.analytics.info.ErrorInfoBox;
import com.taomee.analytics.item.ErrorItem;
import com.taomee.analytics.item.StatisticsItem;

import flash.display.Stage;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.sendToURL;
import flash.system.Capabilities;
import flash.system.Security;
import flash.utils.ByteArray;
import flash.utils.getTimer;

public class Analytics {

    private static var statisticObj:Object = {};

    private static var _productID:int = 0;

    private static var errorObj:Object = {};

    private static var statisticLimit:Object = {};

    private static var errorLimit:Object = {};

    private static var _stats:Stats = new Stats();

    private static var _webAddr:String;

    public static var enabledSubmit:Boolean = true;

    public static var dataBinding:Function;

    private static var _stage:Stage;


    public function Analytics() {
        super();
    }

    private static function checkErrorType(param1:ErrorItem):Boolean {
        var _loc2_:int = param1.id;
        if (!errorObj[_loc2_]) {
            errorObj[_loc2_] = 0;
        }
        if (!errorLimit[_loc2_]) {
            errorLimit[_loc2_] = param1.submitLimit;
        }
        if (errorObj[_loc2_] >= errorLimit[_loc2_]) {
            return false;
        }
        return true;
    }

    public static function hide():void {
        _stats.hide();
    }

    public static function recordTagCommand(param1:int, param2:String):void {
        RecordSocketHistory.pushInTagHistory(param1, param2);
    }

    public static function init(param1:int, param2:String, param3:Stage, param4:Function = null):void {
        var productID:int = param1;
        var webAddr:String = param2;
        var stage:Stage = param3;
        var _dataBinding:Function = param4;
        var url:String = URLUitl.reviseURL(webAddr + "/crossdomain.xml");
        //Security.loadPolicyFile(url);
        _productID = productID;
        _webAddr = webAddr;
        _stage = stage;
        _stats.start(_stage);
        if (_dataBinding != null) {
            dataBinding = _dataBinding;
        } else {
            dataBinding = function (param1:ErrorItem):void {
                throw "没有绑定信息收集函数！\n请参考Analytics.dataBinding方法";
            };
        }
    }

    private static function checkStatistics(param1:StatisticsItem):Boolean {
        var _loc2_:int = param1.data;
        if (!statisticObj[_loc2_]) {
            statisticObj[_loc2_] = 0;
        }
        if (!statisticLimit[_loc2_]) {
            statisticLimit[_loc2_] = param1.submitLimit;
        }
        if (statisticObj[_loc2_] >= statisticLimit[_loc2_]) {
            return false;
        }
        return true;
    }

    public static function submitErrorInfo(param1:ErrorItem, param2:String = ""):void {
        var info:ErrorInfoBox = null;
        var errstr:String = null;
        var request:URLRequest = null;
        var variables:URLVariables = null;
        var i:String = null;
        var actionHistory:Array = null;
        var lastArr:Array = null;
        var k:int = 0;
        var isLogin:uint = 0;
        var webAdds:Array = null;
        var exBytes:ByteArray = null;
        var tcmd:int = 0;
        var item:ErrorItem = param1;
        var description:String = param2;
        if (!enabledSubmit) {
            return;
        }
        if (checkErrorType(item)) {
            if (dataBinding != null) {
                info = dataBinding(item);
            }
            if (info) {
                errstr = new Error("#Analytics#").getStackTrace();
                if (errstr) {
                    description = description + "\n" + errstr;
                }
                ++errorObj[item.id];
                request = new URLRequest();
                request.method = URLRequestMethod.POST;
                variables = new URLVariables();
                for (i in info) {
                    variables[i] = info[i];
                }
                variables.errorDes = item.label;
                variables.errorType = item.id;
                variables.language = Capabilities.language;
                variables.flashVersion = Capabilities.version;
                variables.os = Capabilities.os;
                variables.playerType = Capabilities.playerType;
                variables.clientTime = uint(new Date().time / 1000);
                variables.playerStartTime = getTimer();
                actionHistory = RecordSocketHistory.actionHistory;
                variables.lastAction = actionHistory.length > 0 ? String(actionHistory) : "";
                variables.lastWriteCmd = 0;
                variables.performance = _stats.getEqualityFps();
                variables.performanceMap = ByteUtil.toString(_stats.getFpsBytes());
                lastArr = actionHistory.splice(0);
                k = 0;
                while (k < lastArr.length) {
                    tcmd = int(lastArr[k].split(":")[0]);
                    if (lastArr[k].split("/")[1] == "write") {
                        variables.lastWriteCmd = tcmd;
                    }
                    lastArr[k] = tcmd;
                    k++;
                }
                lastArr = lastArr.reverse();
                try {
                    if (lastArr.length >= 3) {
                        variables.lastCmd3 = lastArr[2];
                        variables.lastCmd2 = lastArr[1];
                        variables.lastCmd1 = lastArr[0];
                        isLogin = 1;
                    } else if (lastArr.length == 2) {
                        variables.lastCmd3 = 0;
                        variables.lastCmd2 = lastArr[1];
                        variables.lastCmd1 = lastArr[0];
                        isLogin = 1;
                    } else if (lastArr.length == 1) {
                        variables.lastCmd3 = 0;
                        variables.lastCmd2 = 0;
                        variables.lastCmd1 = lastArr[0];
                        isLogin = 1;
                    } else {
                        variables.lastCmd3 = 0;
                        variables.lastCmd2 = 0;
                        variables.lastCmd1 = 0;
                        isLogin = 1;
                    }
                } catch (e:Error) {
                }
                variables.isLogin = isLogin;
                variables.isDebugger = Capabilities.isDebugger ? 1 : 0;
                variables.isAutoReport = 1;
                variables.photo = "";
                webAdds = String(_stage.loaderInfo.url.split(".swf")[0]).split("/");
                webAdds.pop();
                variables.webServer = webAdds.join("/");
                variables.webServer = String(variables.webServer).split("|").join("/");
                exBytes = new ByteArray();
                exBytes.writeUTFBytes(description);
                exBytes.compress();
                exBytes.position = 0;
                variables.ex_data = ByteUtil.toString(exBytes);
                variables.mem_use = ByteUtil.toString(_stats.getMemoryBytes());
                request.data = variables;
                request.url = URLUitl.reviseURL(_webAddr + "/error_report/report.php?gameid=" + _productID);
                try {
                    //sendToURL(request);
                } catch (error:Error) {
                    trace("错误报告提交失败！！");
                }
                trace(request.url);
            }
        }
    }

    public static function reset():void {
        RecordSocketHistory.actionHistory.length = 0;
    }

    public static function recordCommand(param1:int, param2:int):void {
        if (param2 == 1) {
            RecordSocketHistory.pushInActionHistory(param1, RecordSocketHistory.ACTION_WRITE);
        } else if (param2 == 0) {
            RecordSocketHistory.pushInActionHistory(param1, RecordSocketHistory.ACTION_READ);
        }
    }

    public static function show(param1:Number = 0, param2:Number = 0):void {
        _stats.x = param1;
        _stats.y = param2;
        _stats.show(_stage);
    }

    public function submitStatisticsInfo(param1:StatisticsItem, param2:Number):void {
        var request:URLRequest = null;
        var variables:URLVariables = null;
        var item:StatisticsItem = param1;
        var value:Number = param2;
        if (!enabledSubmit) {
            return;
        }
        if (checkStatistics(item)) {
            ++statisticObj[item.data];
            request = new URLRequest();
            request.method = URLRequestMethod.POST;
            variables = new URLVariables();
            variables.typeDes = item.label;
            variables.type = item.data;
            variables.value = value;
            request.data = variables;
            request.url = URLUitl.reviseURL(_webAddr + "/error_report/statistics.php?gameid=" + _productID);
            try {
                //sendToURL(request);
            } catch (error:Error) {
                trace("错误报告提交失败！！");
            }
            trace(request.url);
        }
    }
}
}
