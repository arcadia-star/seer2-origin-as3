package seer2.next.fight.ui.data {
public class MoveData {
    public var side:int;
    public var skill:String;
    public var category:String;
    public var damage:int;
    public var critical:int;
    public var miss:int;
    public var rate:int;
    public var soundUrl:String;
    public var effectUrl:String;

    public static function from(obj:Object):MoveData {
        if (!obj) {
            return null;
        }
        var target:MoveData = new MoveData();
        target.side = obj.side;
        target.skill = obj.skill;
        target.category = obj.category;
        target.damage = obj.damage;
        target.critical = obj.critical;
        target.miss = obj.miss;
        target.rate = obj.rate;
        target.soundUrl = obj.soundUrl;
        target.effectUrl = obj.effectUrl;
        return target;
    }

    public static function clone(obj:MoveData):MoveData {
        if (!obj) {
            return null;
        }
        var target:MoveData = new MoveData();
        target.side = obj.side;
        target.skill = obj.skill;
        target.category = obj.category;
        target.damage = obj.damage;
        target.critical = obj.critical;
        target.miss = obj.miss;
        target.rate = obj.rate;
        target.soundUrl = obj.soundUrl;
        target.effectUrl = obj.effectUrl;
        return target;
    }
}
}
