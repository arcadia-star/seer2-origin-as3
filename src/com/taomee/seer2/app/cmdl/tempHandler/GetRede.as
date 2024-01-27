package com.taomee.seer2.app.cmdl.tempHandler {
import com.taomee.seer2.app.net.parser.Parser_1548;
import com.taomee.seer2.app.popup.ServerMessager;

public class GetRede implements IHandler {


    public function GetRede() {
        super();
    }

    public function handle(param1:Parser_1548):void {
        if (param1 && param1.eventDataVec && param1.eventDataVec.length > 0) {
            ServerMessager.addMessage("获得" + param1.eventDataVec[0] + "个灯笼！");
        }
    }
}
}
