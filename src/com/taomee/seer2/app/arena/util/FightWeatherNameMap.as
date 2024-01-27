package com.taomee.seer2.app.arena.util {
import org.taomee.ds.HashMap;

public class FightWeatherNameMap {

    private static var _map:HashMap;


    public function FightWeatherNameMap() {
        super();
    }

    private static function initialize():void {
        _map = new HashMap();
        _map.add(1, "晴天 加成属性：草 光");
        _map.add(2, "雨天 加成属性：水");
        _map.add(3, "炎热 加成属性：火");
        _map.add(4, "暴风雪 加成属性：冰");
        _map.add(5, "沙尘暴 加成属性：沙漠");
        _map.add(6, "地震 加成属性：地面");
        _map.add(7, "雷暴天 加成属性：电");
        _map.add(8, "飓风 加成属性：飞行 风");
        _map.add(9, "夜幕 加成属性：暗影 特质");
        _map.add(10, "异空间 加成属性：超能 神秘");
        _map.add(11, "古战场 加成属性：战斗 龙 上古");
        _map.add(12, "虫群 加成属性：虫");
        _map.add(13, "星移 降低双方50点全能力值");
        _map.add(14, "三级星移 降低双方200点全能力值");
        _map.add(15, "二级星移 降低双方100点全能力值");
        _map.add(17, "强震 加成属性：地面");
        _map.add(18, "黄沙暴 加成属性：沙漠");
        _map.add(20, "MAX星移 降低双方333点全能力值");
        _map.add(23, "烈日 加成属性：光");
        _map.add(24, "星域 每回合特质系精灵恢复25点体力 非特质系精灵失去25点体力");
    }

    public static function getWeatherNameByCode(param1:uint):String {
        if (_map == null) {
            initialize();
        }
        if (_map.containsKey(param1) == true) {
            return _map.getValue(param1);
        }
        return "未设置";
    }
}
}
