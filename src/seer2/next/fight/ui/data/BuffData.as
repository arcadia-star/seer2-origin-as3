package seer2.next.fight.ui.data {
public class BuffData {
    public var id:int;
    public var name:String;
    public var icon:String;
    public var tips:String;
    public var count:int;

    public static function from(obj:Object):BuffData {
        var target:BuffData = new BuffData();
        target.id = obj.id;
        target.name = obj.name;
        target.icon = obj.icon
        target.tips = obj.tips
        target.count = obj.count
        return target;
    }

    public static function clone(obj:BuffData):BuffData {
        var target:BuffData = new BuffData();
        target.id = obj.id;
        target.name = obj.name;
        target.icon = obj.icon
        target.tips = obj.tips
        target.count = obj.count
        return target;
    }
}
}
