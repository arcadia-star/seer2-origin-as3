package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.activity.data.ActivityDefinition;
import com.taomee.seer2.app.activity.processor.callLeiyi.CallLeiyiFightEvent;

public class CallLeiyi extends ActivityProcessor {


    private var _specialEvent:CallLeiyiFightEvent;

    public function CallLeiyi(param1:ActivityDefinition) {
        _relatedMapIDArr = [860];
        super(param1);
    }

    override public function start():void {
        super.start();
    }

    override public function refresh():void {
        super.refresh();
    }

    override public function dispose():void {
        this._specialEvent = null;
        super.dispose();
    }
}
}
