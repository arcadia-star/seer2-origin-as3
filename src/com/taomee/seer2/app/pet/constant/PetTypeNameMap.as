package com.taomee.seer2.app.pet.constant {
import org.taomee.ds.HashMap;

public class PetTypeNameMap {

    private static var _map:HashMap;

    {
        initialize();
    }

    public function PetTypeNameMap() {
        super();
    }

    private static function initialize():void {
        _map = new HashMap();
        _map.add(1, "普通");
        _map.add(2, "草");
        _map.add(3, "水");
        _map.add(4, "火");
        _map.add(5, "风");
        _map.add(6, "虫");
        _map.add(7, "飞行");
        _map.add(8, "电");
        _map.add(9, "地面");
        _map.add(10, "冰");
        _map.add(11, "超能");
        _map.add(12, "光");
        _map.add(13, "暗影");
        _map.add(14, "战斗");
        _map.add(15, "龙");
        _map.add(16, "沙漠");
        _map.add(17, "神秘");
        _map.add(18, "特质");
        _map.add(19, "精灵王");
        _map.add(20, "上古");
        _map.add(21, "圣灵");
    }

    public static function getTypeName(param1:uint):String {
        if (_map.containsKey(param1) == true) {
            return _map.getValue(param1);
        }
        return "未知";
    }

    public static function getPetSex(param1:int):String {
        var _loc2_:String = "";
        switch (param1) {
            case 1:
                _loc2_ = "雄性";
                break;
            case 2:
                _loc2_ = "雌性";
                break;
            case 3:
                _loc2_ = "合体";
        }
        return _loc2_;
    }
}
}
