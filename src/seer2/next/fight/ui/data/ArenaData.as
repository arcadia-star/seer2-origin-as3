package seer2.next.fight.ui.data {
import seer2.next.fight.*;

public class ArenaData {
    public var left:TeamData;
    public var right:TeamData;
    public var round:int;
    public var mapSwf:String;
    public var mapSound:String;
    public var weatherIcon:String;
    public var weatherTips:String;

    public static function from(obj:Object):ArenaData {
        if (!obj) {
            return null;
        }
        var target:ArenaData = new ArenaData();
        target.left = TeamData.from(obj.left);
        target.right = TeamData.from(obj.right);
        target.round = obj.round;
        target.mapSwf = obj.mapSwf;
        target.mapSound = obj.mapSound;
        target.weatherIcon = obj.weatherIcon;
        target.weatherTips = obj.weatherTips;
        return target;
    }

    public static function clone(obj:ArenaData):ArenaData {
        if (!obj) {
            return null;
        }
        var target:ArenaData = new ArenaData();
        target.left = TeamData.clone(obj.left);
        target.right = TeamData.clone(obj.right);
        target.round = obj.round;
        target.mapSwf = obj.mapSwf;
        target.mapSound = obj.mapSound;
        target.weatherIcon = obj.weatherIcon;
        target.weatherTips = obj.weatherTips;
        return target;
    }
}
}
