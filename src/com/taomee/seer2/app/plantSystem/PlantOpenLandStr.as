package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.app.actor.ActorManager;

public class PlantOpenLandStr {


    public function PlantOpenLandStr() {
        super();
    }

    public static function getStr(param1:uint, param2:Boolean):String {
        if (ActorManager.actorInfo.vipInfo.isVip()) {
            return getVipStr(param1, param2);
        }
        return getBaseStr(param1, param2);
    }

    public static function getLevelUint(param1:uint, param2:Boolean):uint {
        if (ActorManager.actorInfo.vipInfo.isVip()) {
            return getLevelVipStr(param1, param2);
        }
        return getLevelBaseStr(param1, param2);
    }

    private static function getVipStr(param1:uint, param2:Boolean):String {
        var _loc3_:String = "";
        switch (param1) {
            case 0:
                _loc3_ = "1";
                break;
            case 1:
                _loc3_ = "2";
                break;
            case 2:
                _loc3_ = "2";
                break;
            case 3:
                _loc3_ = "4";
                break;
            case 4:
                _loc3_ = "6";
                break;
            case 5:
                _loc3_ = "6";
                break;
            case 6:
                _loc3_ = "7";
                break;
            case 7:
                _loc3_ = "7";
                break;
            case 8:
                _loc3_ = "8";
                break;
            case 9:
                _loc3_ = "9";
                break;
            case 10:
                _loc3_ = "10";
                break;
            case 11:
                _loc3_ = "11";
                break;
            case 12:
                _loc3_ = "12";
                break;
            case 13:
                _loc3_ = "12";
                break;
            case 14:
                _loc3_ = "13";
                break;
            case 15:
                _loc3_ = "14";
        }
        return _loc3_;
    }

    private static function getLevelVipStr(param1:uint, param2:Boolean):uint {
        var _loc3_:uint = 0;
        switch (param1) {
            case 0:
                _loc3_ = 1;
                break;
            case 1:
                _loc3_ = 3;
                break;
            case 2:
                _loc3_ = 3;
                break;
            case 3:
                _loc3_ = 4;
                break;
            case 4:
                _loc3_ = 4;
                break;
            case 5:
                _loc3_ = 6;
                break;
            case 6:
                _loc3_ = 8;
                break;
            case 7:
                _loc3_ = 9;
                break;
            case 8:
                _loc3_ = 10;
                break;
            case 9:
                _loc3_ = 11;
                break;
            case 10:
                _loc3_ = 12;
                break;
            case 11:
                _loc3_ = 14;
                break;
            case 12:
                _loc3_ = 15;
                break;
            case 13:
                _loc3_ = 16;
                break;
            case 14:
                _loc3_ = 16;
        }
        return _loc3_;
    }

    private static function getLevelBaseStr(param1:uint, param2:Boolean):uint {
        var _loc3_:uint = 0;
        switch (param1) {
            case 0:
                _loc3_ = 1;
                break;
            case 1:
                _loc3_ = 2;
                break;
            case 2:
                _loc3_ = 2;
                break;
            case 3:
                _loc3_ = 3;
                break;
            case 4:
                _loc3_ = 3;
                break;
            case 5:
                _loc3_ = 4;
                break;
            case 6:
                _loc3_ = 5;
                break;
            case 7:
                _loc3_ = 6;
                break;
            case 8:
                _loc3_ = 7;
                break;
            case 9:
                _loc3_ = 8;
                break;
            case 10:
                _loc3_ = 9;
                break;
            case 11:
                _loc3_ = 10;
                break;
            case 12:
                _loc3_ = 11;
                break;
            case 13:
                _loc3_ = 12;
                break;
            case 14:
                _loc3_ = 12;
        }
        return _loc3_;
    }

    private static function getBaseStr(param1:uint, param2:Boolean):String {
        var _loc3_:String = "";
        switch (param1) {
            case 0:
                _loc3_ = "1";
                break;
            case 1:
                _loc3_ = "2";
                break;
            case 2:
                _loc3_ = "4";
                break;
            case 3:
                _loc3_ = "6";
                break;
            case 4:
                _loc3_ = "7";
                break;
            case 5:
                _loc3_ = "8";
                break;
            case 6:
                _loc3_ = "9";
                break;
            case 7:
                _loc3_ = "10";
                break;
            case 8:
                _loc3_ = "11";
                break;
            case 9:
                _loc3_ = "12";
                break;
            case 10:
                _loc3_ = "13";
                break;
            case 11:
                _loc3_ = "14";
                break;
            case 12:
                _loc3_ = "15";
                break;
            case 13:
                _loc3_ = "15";
                break;
            case 14:
                _loc3_ = "15";
                break;
            case 15:
                _loc3_ = "15";
        }
        return _loc3_;
    }
}
}
