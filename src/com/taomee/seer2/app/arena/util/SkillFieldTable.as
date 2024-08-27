package com.taomee.seer2.app.arena.util {
import org.taomee.ds.HashMap;

public class SkillFieldTable {

    private static var _categoryMap:HashMap;

    private static var _typeMap:HashMap;

    {
        initialize();
    }

    public function SkillFieldTable() {
        super();
    }

    private static function initialize():void {
        _categoryMap = new HashMap();
        _categoryMap.add(1, "物理");
        _categoryMap.add(2, "特殊");
        _categoryMap.add(4, "属性");
        _categoryMap.add(8, "必杀");
        _typeMap = new HashMap();
        _typeMap.add(1, "普通");
        _typeMap.add(2, "草");
        _typeMap.add(3, "水");
        _typeMap.add(4, "火");
        _typeMap.add(5, "风");
        _typeMap.add(6, "虫");
        _typeMap.add(7, "飞行");
        _typeMap.add(8, "电");
        _typeMap.add(9, "地面");
        _typeMap.add(10, "冰");
        _typeMap.add(11, "超能");
        _typeMap.add(12, "光");
        _typeMap.add(13, "暗影");
        _typeMap.add(14, "战斗");
        _typeMap.add(15, "龙");
        _typeMap.add(16, "沙漠");
        _typeMap.add(17, "神秘");
        _typeMap.add(18, "特质");
        _typeMap.add(19, "精灵王");
        _typeMap.add(20, "上古");
        _typeMap.add(21, "圣灵");
        _typeMap.add(22, "神迹");
        _typeMap.add(23, "神遁");
        _typeMap.add(24, "皮肤");
    }

    public static function getCategoryName(param1:int):String {
        return getString(_categoryMap, param1);
    }

    public static function getTypeName(param1:int):String {
        return getString(_typeMap, param1);
    }

    private static function getString(param1:HashMap, param2:int):String {
        if (param1.containsKey(param2)) {
            return param1.getValue(param2);
        }
        return "未设置";
    }
}
}
