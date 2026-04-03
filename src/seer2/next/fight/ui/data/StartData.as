package seer2.next.fight.ui.data {
public class StartData {
    public var urls:Vector.<String>;
    public var tips:Vector.<String>;

    public static function from(obj:Object):StartData {
        if (!obj) {
            return null;
        }
        var target:StartData = new StartData();
        target.urls = transString(obj.urls);
        target.tips = transString(obj.tips);
        return target;
    }

    public static function clone(obj:StartData):StartData {
        if (!obj) {
            return null;
        }
        var target:StartData = new StartData();
        target.urls = cloneString(obj.urls);
        target.tips = cloneString(obj.tips);
        return target;
    }

    private static function transString(array:Array):Vector.<String> {
        var res:Vector.<String> = new Vector.<String>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(array[i]);
        }
        return res;
    }

    private static function cloneString(array:Vector.<String>):Vector.<String> {
        var res:Vector.<String> = new Vector.<String>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(array[i]);
        }
        return res;
    }
}
}
