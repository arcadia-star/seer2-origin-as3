package com.taomee.seer2.app.gameRule.cavingNotice {
import com.taomee.seer2.core.utils.DateUtil;

public class CavingTimeInfo {


    public var allTime:Boolean = false;

    public var minDay:uint;

    public var minHour:uint;

    public var minMinmute:uint;

    public var maxHour:uint;

    public var maxMinmute:uint = 0;

    public function CavingTimeInfo(param1:Boolean = false, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) {
        super();
        this.allTime = param1;
        this.minDay = param2;
        this.minHour = param3;
        this.minMinmute = param4;
        this.maxHour = param5;
        this.maxMinmute = param6;
    }

    public function toString():String {
        return "[allTime:" + this.allTime + "]\n" + "[minDay:" + this.minDay + "]" + "--- [minHour:" + this.minHour + "]" + "[minMinmute:" + this.minMinmute + "]" + "[maxHour:" + this.maxHour + "]" + "[maxMinmute:" + this.maxMinmute + "]";
    }

    public function isInTimeScope():Boolean {
        if (this.allTime) {
            return true;
        }
        return DateUtil.inInDateScope(this.minDay, this.minHour, this.minMinmute, this.maxHour, this.maxMinmute);
    }

    public function compare(param1:CavingTimeInfo):Boolean {
        if (param1.allTime && this.allTime) {
            return true;
        }
        if (param1.minDay == this.minDay && param1.minHour == this.minHour && param1.minMinmute == this.minMinmute && param1.maxHour == this.maxHour && param1.maxMinmute == this.maxMinmute) {
            return true;
        }
        return false;
    }
}
}
