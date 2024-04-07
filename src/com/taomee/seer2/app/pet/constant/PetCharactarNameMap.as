package com.taomee.seer2.app.pet.constant {
import org.taomee.ds.HashMap;

public class PetCharactarNameMap {

    private static var _map:HashMap;

    private static var charactarArr:Array = [
                [1.1, 0.9, 1, 1, 1, 1],
                [1.1, 1, 0.9, 1, 1, 1],
                [1.1, 1, 1, 0.9, 1, 1],
                [1.1, 1, 1, 1, 0.9, 1],
                [0.9, 1.1, 1, 1, 1, 1],
                [1, 1.1, 0.9, 1, 1, 1],
                [1, 1.1, 1, 0.9, 1, 1],
                [1, 1.1, 1, 1, 0.9, 1],
                [0.9, 1, 1.1, 1, 1, 1],
                [1, 0.9, 1.1, 1, 1, 1],
                [1, 1, 1.1, 0.9, 1, 1],
                [1, 1, 1.1, 1, 0.9, 1],
                [0.9, 1, 1, 1.1, 1, 1],
                [1, 0.9, 1, 1.1, 1, 1],
                [1, 1, 0.9, 1.1, 1, 1],
                [1, 1, 1, 1.1, 0.9, 1],
                [0.9, 1, 1, 1, 1.1, 1],
                [1, 0.9, 1, 1, 1.1, 1],
                [1, 1, 0.9, 1, 1.1, 1],
                [1, 1, 1, 0.9, 1.1, 1],
                [1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 1],
                [1.1, 1.1, 0.9, 0.9, 1, 1],
                [1.1, 0.9, 1.1, 0.9, 1, 1],
                [1.1, 0.9, 0.9, 1.1, 1, 1],
                [1.1, 0.9, 1, 0.9, 1.1, 1],
                [0.9, 1.1, 1.1, 0.9, 1, 1],
                [0.9, 1.1, 0.9, 1.1, 1, 1],
                [0.9, 1.1, 0.9, 1, 1.1, 1],
                [0.9, 0.9, 1.1, 1.1, 1, 1],
                [1, 0.9, 1.1, 0.9, 1.1, 1],
                [0.9, 1, 0.9, 1.1, 1.1],
                1
            ]
    ;

    {
        initialize();
    }

    public function PetCharactarNameMap() {
        super();
    }

    private static function initialize():void {
        _map = new HashMap();
        _map.add(0, "孤独");
        _map.add(1, "固执");
        _map.add(2, "调皮");
        _map.add(3, "勇敢");
        _map.add(4, "大胆");
        _map.add(5, "顽皮");
        _map.add(6, "无虑");
        _map.add(7, "悠闲");
        _map.add(8, "保守");
        _map.add(9, "稳重");
        _map.add(10, "马虎");
        _map.add(11, "冷静");
        _map.add(12, "沉着");
        _map.add(13, "温顺");
        _map.add(14, "慎重");
        _map.add(15, "狂妄");
        _map.add(16, "胆小");
        _map.add(17, "急躁");
        _map.add(18, "开朗");
        _map.add(19, "天真");
        _map.add(20, "害羞");
        _map.add(21, "实干");
        _map.add(22, "坦率");
        _map.add(23, "浮躁");
        _map.add(24, "认真");
        _map.add(25, "孤傲");
        _map.add(26, "直率");
        _map.add(27, "古怪");
        _map.add(28, "狂野");
        _map.add(29, "清纯");
        _map.add(30, "温柔");
        _map.add(31, "活泼");
        _map.add(32, "仁慈");
        _map.add(33, "忧郁");
        _map.add(34, "可爱");
    }

    public static function getCharactarName(param1:uint):String {
        if (_map.containsKey(param1) == true) {
            return _map.getValue(param1);
        }
        return "未设置";
    }

    public static function getCharactarArr(param1:uint):Array {
        return charactarArr[param1];
    }
}
}
