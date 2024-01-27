package com.taomee.seer2.app.notify.data.queue {
import com.taomee.seer2.app.notify.data.notice.Notice;

public class NoticeQueue {


    private var _vec:Vector.<Notice>;

    public function NoticeQueue() {
        super();
        this._vec = new Vector.<Notice>();
    }

    public function enQueue(param1:Notice):void {
        this._vec.push(param1);
    }

    public function deQueue():Notice {
        if (this.length > 0) {
            return this._vec.shift();
        }
        return null;
    }

    public function get length():int {
        return this._vec.length;
    }

    public function getNotice(param1:uint, param2:uint = 0):Notice {
        var _loc3_:Notice = null;
        for each(_loc3_ in this._vec) {
            if (_loc3_.userId == param1) {
                return _loc3_;
            }
        }
        return null;
    }
}
}
