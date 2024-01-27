package com.taomee.seer2.app.activity.data {
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.utils.DateUtil;

public class ActivityDefinition {

    private static const MINUTES_PER_HOUR:uint = 60;

    private static const MILLISECONDS_PER_SECOND:uint = 1000;


    public var id:uint;

    public var name:String;

    private var activityCircle:ActivityCircle;

    private var detailTimeVec:Vector.<String>;

    private var phaseTimeVec:Vector.<String>;

    public function ActivityDefinition(param1:uint, param2:String, param3:int, param4:Array, param5:Array, param6:Array) {
        super();
        this.id = param1;
        this.activityCircle = new ActivityCircle(param3, param4);
        if (param5) {
            this.detailTimeVec = Vector.<String>(param5);
        }
        if (param6) {
            this.phaseTimeVec = Vector.<String>(param6);
        }
    }

    public function isTimeless():Boolean {
        return this.activityCircle.circleType == ActivityCircleType.TIME_LESS;
    }

    public function isEnterable():Boolean {
        if (this.activityCircle.circleType == ActivityCircleType.TIME_LESS) {
            return true;
        }
        switch (this.activityCircle.circleType) {
            case ActivityCircleType.ONCE:
                return this.parseOnce();
            case ActivityCircleType.DAY:
                return this.parseDay();
            case ActivityCircleType.WEEK:
                return this.parseWeek();
            case ActivityCircleType.MONTH:
                return this.parseMonth();
            case ActivityCircleType.YEAR:
                return this.parseYear();
            default:
                return false;
        }
    }

    public function isActivityDate():Boolean {
        var _loc1_:Date = null;
        var _loc2_:Number = NaN;
        var _loc3_:uint = 0;
        var _loc4_:String = null;
        var _loc5_:Number = NaN;
        var _loc6_:String = null;
        if (this.activityCircle.circleType == ActivityCircleType.TIME_LESS) {
            return true;
        }
        _loc3_ = uint(TimeManager.getServerTime());
        switch (this.activityCircle.circleType) {
            case ActivityCircleType.ONCE:
                _loc4_ = String(DateUtil.formatCalendarWithoutMark(_loc3_));
                return this.activityCircle.circleDate.indexOf(_loc4_) != -1;
            case ActivityCircleType.DAY:
                return true;
            case ActivityCircleType.WEEK:
                _loc1_ = new Date(_loc3_ * MILLISECONDS_PER_SECOND);
                _loc2_ = _loc1_.day;
                return this.activityCircle.circleDate.indexOf(_loc2_.toString()) != -1;
            case ActivityCircleType.MONTH:
                _loc1_ = new Date(_loc3_ * MILLISECONDS_PER_SECOND);
                _loc2_ = _loc1_.date;
                return this.activityCircle.circleDate.indexOf(_loc2_.toString()) != -1;
            case ActivityCircleType.YEAR:
                _loc1_ = new Date(_loc3_ * MILLISECONDS_PER_SECOND);
                _loc5_ = _loc1_.month + 1;
                _loc2_ = _loc1_.date;
                _loc6_ = _loc5_.toString() + _loc2_.toString();
                return this.activityCircle.circleDate.indexOf(_loc6_) != -1;
            default:
                return false;
        }
    }

    private function parseOnce():Boolean {
        var _loc1_:uint = uint(TimeManager.getServerTime());
        var _loc2_:String = String(DateUtil.formatCalendarWithoutMark(_loc1_));
        if (this.activityCircle.circleDate.indexOf(_loc2_) != -1) {
            return this.parseTime();
        }
        return false;
    }

    private function parseDay():Boolean {
        return this.parseTime();
    }

    private function parseWeek():Boolean {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * MILLISECONDS_PER_SECOND);
        var _loc2_:Number = _loc1_.day;
        if (this.activityCircle.circleDate.indexOf(_loc2_.toString()) != -1) {
            return this.parseTime();
        }
        return false;
    }

    private function parseMonth():Boolean {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * MILLISECONDS_PER_SECOND);
        var _loc2_:Number = _loc1_.date;
        if (this.activityCircle.circleDate.indexOf(_loc2_.toString()) != -1) {
            return this.parseTime();
        }
        return false;
    }

    private function parseYear():Boolean {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * MILLISECONDS_PER_SECOND);
        var _loc2_:Number = _loc1_.month + 1;
        var _loc3_:Number = _loc1_.date;
        var _loc4_:String = _loc2_.toString() + _loc3_.toString();
        if (this.activityCircle.circleDate.indexOf(_loc4_) != -1) {
            return this.parseTime();
        }
        return false;
    }

    private function parseTime():Boolean {
        var _loc4_:int = 0;
        var _loc5_:uint = 0;
        var _loc6_:uint = 0;
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:uint = uint(_loc1_.hours * MINUTES_PER_HOUR * 60) + uint(_loc1_.minutes * 60) + uint(_loc1_.seconds);
        var _loc3_:uint = 0;
        while (_loc3_ < this.phaseTimeVec.length) {
            _loc4_ = this.phaseTimeVec[_loc3_].indexOf(":");
            _loc5_ = uint(this.phaseTimeVec[_loc3_].substring(0, _loc4_)) * MINUTES_PER_HOUR * 60 + uint(this.phaseTimeVec[_loc3_].substring(_loc4_ + 1)) * 60;
            _loc4_ = this.phaseTimeVec[_loc3_ + 1].indexOf(":");
            _loc6_ = uint(this.phaseTimeVec[_loc3_ + 1].substring(0, _loc4_)) * MINUTES_PER_HOUR * 60 + uint(this.phaseTimeVec[_loc3_ + 1].substring(_loc4_ + 1)) * 60;
            if (_loc2_ >= _loc5_ && _loc2_ < _loc6_ - 30) {
                return true;
            }
            _loc3_ += 2;
        }
        return false;
    }

    public function isAvailableTime():Boolean {
        var _loc4_:int = 0;
        var _loc5_:uint = 0;
        var _loc6_:uint = 0;
        if (this.activityCircle.circleType == ActivityCircleType.TIME_LESS) {
            return true;
        }
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:uint = uint(_loc1_.hours * MINUTES_PER_HOUR * 60) + uint(_loc1_.minutes * 60) + uint(_loc1_.seconds);
        var _loc3_:uint = 0;
        while (_loc3_ < this.phaseTimeVec.length) {
            _loc4_ = this.phaseTimeVec[_loc3_].indexOf(":");
            _loc5_ = uint(this.phaseTimeVec[_loc3_].substring(0, _loc4_)) * MINUTES_PER_HOUR * 60 + uint(this.phaseTimeVec[_loc3_].substring(_loc4_ + 1)) * 60;
            _loc4_ = this.phaseTimeVec[_loc3_ + 1].indexOf(":");
            _loc6_ = uint(this.phaseTimeVec[_loc3_ + 1].substring(0, _loc4_)) * MINUTES_PER_HOUR * 60 + uint(this.phaseTimeVec[_loc3_ + 1].substring(_loc4_ + 1)) * 60;
            if (_loc2_ >= _loc5_ && _loc2_ < _loc6_) {
                return true;
            }
            _loc3_ += 2;
        }
        return false;
    }

    public function getPhaseTimeVec(param1:uint):Vector.<String> {
        var _loc2_:int = this.getPhaseIndex(param1);
        if (_loc2_ != -1) {
            return this.slicePhaseTimeVec(_loc2_);
        }
        return null;
    }

    private function slicePhaseTimeVec(param1:uint):Vector.<String> {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        var _loc4_:String = this.phaseTimeVec[param1 * 2];
        var _loc5_:String = this.phaseTimeVec[param1 * 2 + 1];
        var _loc6_:int = int(this.detailTimeVec.length);
        var _loc7_:uint = 0;
        while (_loc7_ < _loc6_) {
            if (this.detailTimeVec[_loc7_] == _loc4_) {
                _loc2_ = _loc7_;
            }
            if (this.detailTimeVec[_loc7_] == _loc5_) {
                _loc3_ = _loc7_;
                break;
            }
            _loc7_++;
        }
        var _loc8_:Vector.<String>;
        (_loc8_ = this.detailTimeVec.slice(_loc2_, _loc3_)).push(this.detailTimeVec[_loc3_]);
        return _loc8_;
    }

    public function getPhaseIndex(param1:uint):int {
        var _loc5_:int = 0;
        var _loc6_:uint = 0;
        var _loc7_:uint = 0;
        if (this.activityCircle.circleType == ActivityCircleType.TIME_LESS) {
            return -1;
        }
        var _loc2_:Date = new Date(param1 * 1000);
        var _loc3_:uint = uint(_loc2_.hours * MINUTES_PER_HOUR) + uint(_loc2_.minutes);
        var _loc4_:uint = 0;
        while (_loc4_ < this.phaseTimeVec.length - 1) {
            _loc5_ = this.phaseTimeVec[_loc4_].indexOf(":");
            _loc6_ = uint(this.phaseTimeVec[_loc4_].substring(0, _loc5_)) * MINUTES_PER_HOUR + uint(this.phaseTimeVec[_loc4_].substring(_loc5_ + 1));
            _loc5_ = this.phaseTimeVec[_loc4_ + 1].indexOf(":");
            _loc7_ = uint(this.phaseTimeVec[_loc4_ + 1].substring(0, _loc5_)) * MINUTES_PER_HOUR + uint(this.phaseTimeVec[_loc4_ + 1].substring(_loc5_ + 1));
            if (_loc3_ >= _loc6_ && _loc3_ < _loc7_) {
                return _loc4_ / 2;
            }
            _loc4_ += 2;
        }
        return -1;
    }
}
}
