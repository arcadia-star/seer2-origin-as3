package seer2.next.fight.ui.data {
import seer2.next.fight.*;

public class FrameData {
    public var data:ArenaData;

    public var move:MoveData;
    public var change:ChangeData;
    public var event:EventData;
    public var start:StartData;
    public var end:EndData

    public var sleep:int;
    public var logs:Vector.<String>;

    public static function from(obj:Object):FrameData {
        var target:FrameData = new FrameData();
        target.data = ArenaData.from(obj.data);
        target.move = MoveData.from(obj.move);
        target.change = ChangeData.from(obj.change);
        target.event = EventData.from(obj.event);
        target.start = StartData.from(obj.start);
        target.end = EndData.from(obj.end);
        target.sleep = obj.sleep;
        target.logs = transString(obj.logs);
        return target;
    }

    public static function clone(obj:FrameData):FrameData {
        var target:FrameData = new FrameData();
        target.data = ArenaData.clone(obj.data);
        target.move = MoveData.clone(obj.move);
        target.change = ChangeData.clone(obj.change);
        target.event = EventData.clone(obj.event);
        target.start = StartData.clone(obj.start);
        target.end = EndData.clone(obj.end);
        target.sleep = obj.sleep;
        target.logs = cloneString(obj.logs);
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
