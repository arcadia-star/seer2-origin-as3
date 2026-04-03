package seer2.next.fight.ui.data {
public class EventData {
    public static const HP_INCREASE:int = 1;
    public static const HP_DECREASE:int = 2;
    public static const ITEM_HP:int = 3;
    public static const ITEM_ANGER:int = 4;
    public static const CATCH_FAILED:int = 5;
    public static const CATCH_SUCCESS:int = 6;
    public static const PET_EXCHANGE:int = 7;

    public var type:int;
    public var side:int;
    public var change:int;
    public var delay:int;

    public static function from(obj:Object):EventData {
        if (!obj) {
            return null;
        }
        var target:EventData = new EventData();
        target.type = obj.type;
        target.side = obj.side;
        target.change = obj.change;
        target.delay = obj.delay;
        return target;
    }

    public static function clone(obj:EventData):EventData {
        if (!obj) {
            return null;
        }
        var target:EventData = new EventData();
        target.type = obj.type;
        target.side = obj.side;
        target.change = obj.change;
        target.delay = obj.delay;
        return target;
    }
}
}
