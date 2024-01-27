package com.taomee.seer2.app.cmdl.tempHandler {
import com.taomee.seer2.app.net.parser.Parser_1548;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.core.module.ModuleManager;

public class GetHotWheeHandle implements IHandler {


    public function GetHotWheeHandle() {
        super();
    }

    public function handle(param1:Parser_1548):void {
        var par:Parser_1548 = param1;
        if (par) {
            ServerBufferManager.getServerBuffer(214, function (param1:ServerBuffer):void {
                if (param1.readDataAtPostion(11) == 0) {
                    ModuleManager.showAppModule("HotWheelsVipTipPanel");
                    ServerBufferManager.updateServerBuffer(214, 11, 1);
                }
            });
        }
    }
}
}
