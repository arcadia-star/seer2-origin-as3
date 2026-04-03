package seer2.next.fight.ui.data {
public class EndData {
    public var winner:int;
    public var alert:int;

    public static function from(obj:Object):EndData {
        if (!obj) {
            return null;
        }
        var target:EndData = new EndData();
        target.winner = obj.winner;
        target.alert = obj.alert;
        return target;
    }

    public static function clone(obj:EndData):EndData {
        if (!obj) {
            return null;
        }
        var target:EndData = new EndData();
        target.winner = obj.winner;
        target.alert = obj.alert;
        return target;
    }
}
}
