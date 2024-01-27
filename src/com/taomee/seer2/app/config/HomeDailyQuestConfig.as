package com.taomee.seer2.app.config {
import com.taomee.seer2.app.home.dailyQuest.HomeDailyCategory;
import com.taomee.seer2.app.home.dailyQuest.HomeDailyQuest;

import org.taomee.ds.HashMap;

public class HomeDailyQuestConfig {

    private static var _map:HashMap = new HashMap();

    {
        initialize();
    }

    public function HomeDailyQuestConfig() {
        super();
    }

    private static function initialize():void {
        var _loc1_:HomeDailyCategory = null;
        var _loc2_:HomeDailyQuest = null;
        var _loc3_:Array = null;
        _loc1_ = new HomeDailyCategory(1, "小游戏");
        _loc2_ = new HomeDailyQuest(1000001, "精灵连连看", "通过精灵连连看第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000002, "智慧连珠", "通过智慧连珠第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000003, "奇妙的宝石", "通过奇妙的宝石第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000004, "爱上捉迷藏", "通过爱上捉迷藏第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000005, "飞檐走壁", "通过飞檐走壁第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000006, "火箭小岩浮", "通过火箭小岩浮第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000007, "绚丽的火花", "通过绚丽的火花第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(1000008, "汤尼站稳", "通过汤尼站稳第2关", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 1,
            "count": 100,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc1_ = new HomeDailyCategory(2, "打BOSS");
        _loc2_ = new HomeDailyQuest(2000017, "SPT任务", "击败1次布鲁托", 2);
        _loc3_ = [];
        _loc3_.push({
            "id": 200213,
            "count": 1,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(2, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc1_ = new HomeDailyCategory(3, "门战");
        _loc2_ = new HomeDailyQuest(3000002, "试炼之战", "参与3次试炼之战普通模式", 4);
        _loc3_ = [];
        _loc3_.push({
            "id": 15,
            "count": 15,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(4, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(3000003, "试炼之战", "参与3次试炼之战50V50模式", 4);
        _loc3_ = [];
        _loc3_.push({
            "id": 15,
            "count": 15,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(4, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc1_ = new HomeDailyCategory(4, "小屋对战");
        _loc2_ = new HomeDailyQuest(4000001, "小屋对战", "挑战2次好友小屋里的精灵", 3);
        _loc3_ = [];
        _loc3_.push({
            "id": 200213,
            "count": 1,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(3, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc1_ = new HomeDailyCategory(5, "收集材料");
        _loc2_ = new HomeDailyQuest(5000013, "水珠", "前往荆棘林打败小小葵，获得3个水珠", 4);
        _loc3_ = [];
        _loc3_.push({
            "id": 200213,
            "count": 1,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(4, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(5000032, "闪光的石头", "前往幻空通道打败尤尼，获得3个闪光的石头", 4);
        _loc3_ = [];
        _loc3_.push({
            "id": 200213,
            "count": 1,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(4, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(5000039, "炙热岩浆", "前往赤炼山脉打败小赤豚，获得3个炙热岩浆", 4);
        _loc3_ = [];
        _loc3_.push({
            "id": 200213,
            "count": 1,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(4, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
        _loc2_ = new HomeDailyQuest(5000041, "珍珠粉末", "前往银脉山脊打败水墨点点，获得3个珍珠粉末", 4);
        _loc3_ = [];
        _loc3_.push({
            "id": 200213,
            "count": 1,
            "isPet": false,
            "isIncome": false
        });
        _loc2_.addStep(4, _loc3_);
        _loc1_.addQuest(_loc2_);
        _map.add(_loc2_.id, _loc2_);
    }

    public static function getDailyQuest(param1:int):HomeDailyQuest {
        return _map.getValue(param1);
    }
}
}
