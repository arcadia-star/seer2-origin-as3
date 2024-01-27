package com.taomee.seer2.app.config.info {
import com.taomee.seer2.app.config.DiceMapThingConfig;
import com.taomee.seer2.app.processor.map.diceThing.DiceThingType;

public class DiceMapTileInfo {


    public var seat:int;

    public var thingType:String;

    public var thingId:String;

    public var x:int;

    public var y:int;

    public function DiceMapTileInfo() {
        super();
    }

    public function get thingNum():int {
        var _loc1_:int = 0;
        switch (this.thingType) {
            case DiceThingType.LUCKY_THING:
                _loc1_ = DiceMapThingConfig.luckyThingNum;
                break;
            case DiceThingType.BOX_THING:
                _loc1_ = DiceMapThingConfig.boxThingNum;
                break;
            case DiceThingType.CHANCE_THING:
                _loc1_ = DiceMapThingConfig.chanceThingNum;
                break;
            case DiceThingType.ADDMONEY_THING:
                _loc1_ = DiceMapThingConfig.addMoneyThingNum;
                break;
            case DiceThingType.SUBMONEY_THING:
                _loc1_ = DiceMapThingConfig.subMoneyThingNum;
                break;
            case DiceThingType.FIGHT_THING:
                _loc1_ = DiceMapThingConfig.petFightThingNum;
                break;
            case DiceThingType.REVERSE_THING:
                _loc1_ = DiceMapThingConfig.reverseThingNum;
        }
        return _loc1_;
    }
}
}
