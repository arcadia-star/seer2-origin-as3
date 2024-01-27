package com.taomee.seer2.app.cmdl.tempHandler {
import com.taomee.seer2.app.net.parser.Parser_1548;
import com.taomee.seer2.app.popup.ServerMessager;

public class GetRedRabbitHandle implements IHandler {


    public function GetRedRabbitHandle() {
        super();
    }

    public function handle(param1:Parser_1548):void {
        if (param1 && param1.eventDataVec && param1.eventDataVec.length > 0) {
            ServerMessager.addMessage("赤兔好感度提升！");
        }
    }
}
}
