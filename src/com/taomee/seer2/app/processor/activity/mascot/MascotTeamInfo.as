package com.taomee.seer2.app.processor.activity.mascot {
import com.taomee.seer2.app.inventory.ItemManager;

public class MascotTeamInfo {


    public var mapId:uint;

    public var id:uint;

    public var blood:uint;

    public var status:uint;

    public function MascotTeamInfo() {
        super();
    }

    public static function getItem():uint {
        if (ItemManager.getSpecialItem(500508) != null) {
            return 1;
        }
        if (ItemManager.getSpecialItem(500509) != null) {
            return 2;
        }
        if (ItemManager.getSpecialItem(500510) != null) {
            return 3;
        }
        return 0;
    }
}
}
