package com.taomee.seer2.app.home.garbage {
import flash.geom.Point;

public class HomeGarbageHelper {

    private static const POSITION_ARR:Array = [[265, 350], [500, 270], [434, 359], [535, 355], [424, 312], [528, 314], [567, 255], [860, 358], [834, 380]];

    private static const GARBAGE_TYPE_ARR:Array = [HomeGarbageData.ROACH, HomeGarbageData.CAPSULE, HomeGarbageData.MEDICINE];

    private static var _positionUsedArr:Array;

    private static var _garbageTypeUsedArr:Array;


    public function HomeGarbageHelper() {
        super();
    }

    public static function prepare():void {
        _positionUsedArr = [];
        var _loc1_:int = 0;
        while (_loc1_ < POSITION_ARR.length) {
            _positionUsedArr.push(false);
            _loc1_++;
        }
        _garbageTypeUsedArr = [];
        _loc1_ = 0;
        while (_loc1_ < 3) {
            _garbageTypeUsedArr.push(0);
            _loc1_++;
        }
    }

    public static function getGarbageData():HomeGarbageData {
        var _loc1_:HomeGarbageData = new HomeGarbageData();
        _loc1_.pos = getUnusedPos();
        _loc1_.type = getGarbageType();
        return _loc1_;
    }

    private static function getUnusedPos():Point {
        var _loc1_:int = 0;
        do {
            _loc1_ = Math.floor(Math.random() * POSITION_ARR.length);
        }
        while (_positionUsedArr[_loc1_]);

        _positionUsedArr[_loc1_] = true;
        return new Point(POSITION_ARR[_loc1_][0], POSITION_ARR[_loc1_][1]);
    }

    private static function getGarbageType():String {
        var _loc1_:int = 0;
        do {
            _loc1_ = Math.floor(Math.random() * _garbageTypeUsedArr.length);
        }
        while (_garbageTypeUsedArr[_loc1_] >= 2);

        _garbageTypeUsedArr[_loc1_] += 1;
        return GARBAGE_TYPE_ARR[_loc1_];
    }
}
}
