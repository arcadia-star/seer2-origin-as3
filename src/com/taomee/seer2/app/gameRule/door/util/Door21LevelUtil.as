package com.taomee.seer2.app.gameRule.door.util {
import com.taomee.seer2.app.gameRule.door.constant.Door21LevelConstant;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.pet.data.PetInfo;

public class Door21LevelUtil {

    private static const GUARD_MC_LABELS:Array = [["appear_l1", "stand_l1", "escape_l1"], ["appear_l2", "stand_l2", "escape_l2"], ["appear_l3", "stand_l3", ""]];

    private static const GUARD_NAMES:Array = ["初阶守护者", "中阶守护者", "高阶守护者"];


    public function Door21LevelUtil() {
        super();
    }

    public static function getGuardPets(param1:uint, param2:uint, param3:uint):Vector.<PetInfo> {
        var _loc4_:Array = Door21LevelConstant.GUARD_NPCS[param3 - 1];
        var _loc5_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc6_:uint = _loc4_.length;
        var _loc7_:uint = 0;
        while (_loc7_ < _loc6_) {
            if (_loc4_[_loc7_].level == param1) {
                _loc5_.push(parseToPetInfo(_loc4_[_loc7_], param2));
            }
            _loc7_++;
        }
        return _loc5_;
    }

    private static function parseToPetInfo(param1:Object, param2:uint):PetInfo {
        var _loc3_:PetInfo = new PetInfo();
        _loc3_.resourceId = param1["id"];
        if (param2 == DoorType.Door_50V50) {
            _loc3_.level = 50;
        } else if (param2 == DoorType.Door_NORMAL) {
            _loc3_.level = param1["petLevel"];
        }
        _loc3_.hp = 1;
        _loc3_.maxHp = 1;
        return _loc3_;
    }

    public static function getGuardLabel(param1:uint, param2:uint):String {
        var _loc3_:Array = GUARD_MC_LABELS;
        var _loc4_:uint = getGuardIndex(param1);
        return _loc3_[_loc4_][param2];
    }

    public static function getBinaryGuardName(param1:uint):String {
        var _loc2_:String = "第四小队队员";
        if (param1 == 21 || param1 == 42) {
            _loc2_ = "西贡";
        } else if (param1 >= 35 && param1 <= 41) {
            _loc2_ = "第四小队暗部";
        }
        return _loc2_;
    }

    public static function getGuardName(param1:uint):String {
        return String(GUARD_NAMES[getGuardIndex(param1)]);
    }

    public static function getGuardIndex(param1:uint):uint {
        if (param1 == 7 || param1 == 14 || param1 == 28 || param1 == 35) {
            return 1;
        }
        if (param1 == 21 || param1 == 42) {
            return 2;
        }
        return 0;
    }
}
}
