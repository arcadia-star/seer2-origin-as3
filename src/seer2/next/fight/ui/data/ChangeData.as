package seer2.next.fight.ui.data {
public class ChangeData {
    public static const DEFAULT:int = 0;
    public static const REPLACE:int = 1;
    public static const MORPH:int = 2;

    public var left:int;
    public var right:int;

    public static function from(obj:Object):ChangeData {
        if (!obj) {
            return null;
        }
        var target:ChangeData = new ChangeData();
        target.left = obj.left;
        target.right = obj.right;
        return target;
    }

    public static function clone(obj:ChangeData):ChangeData {
        if (!obj) {
            return null;
        }
        var target:ChangeData = new ChangeData();
        target.left = obj.left;
        target.right = obj.right;
        return target;
    }
}
}
