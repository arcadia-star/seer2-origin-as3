package com.taomee.seer2.app.pet {
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;

public class MonsterManager {

    public static var isShow:Boolean = true;


    public function MonsterManager() {
        super();
    }

    public static function hideAllMonster():void {
        isShow = false;
        MobileManager.hideMoileVec(MobileType.SPAWNED_PET);
    }

    public static function showAllMonster():void {
        isShow = true;
        MobileManager.showMoileVec(MobileType.SPAWNED_PET);
    }
}
}
