package com.taomee.seer2.app.processor.activity.leiyiFight {
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DateUtil;

import flash.events.Event;

public class LeiyiFight133 {


    private var _map:MapModel;

    private var _teleport:Teleport;

    public function LeiyiFight133(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function init():void {
        this._teleport = AnimateElementManager.getElement(3) as Teleport;
        this._map.content.addEventListener(Event.ENTER_FRAME, this.onEnter);
    }

    private function onEnter(param1:Event):void {
        if (this.isTimerLater()) {
            this._teleport.visible = true;
        } else {
            this._teleport.visible = false;
        }
    }

    private function isTimerLater():Boolean {
        if (DateUtil.inInDateScope(0, 12, 1, 15, 1)) {
            return true;
        }
        return false;
    }

    public function dispose():void {
        this._map.content.removeEventListener(Event.ENTER_FRAME, this.onEnter);
        this._map = null;
        this._teleport = null;
    }
}
}
