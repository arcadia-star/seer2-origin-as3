package seer2.next.play {
import flash.events.DataEvent;

public class HitData {
    public var seq:int;
    public var total:int;

    public static function default1():HitData {
        var hitData:HitData = new HitData();
        hitData.seq = 1;
        hitData.total = 1;
        return hitData;
    }

    public static function from(event:DataEvent):HitData {
        var json:Object = JSON.parse(event.data);
        var hitData:HitData = new HitData();
        hitData.seq = json.seq;
        hitData.total = json.total;
        return hitData;
    }

    public function last():Boolean {
        return this.seq === this.total;
    }

    public function first():Boolean {
        return this.seq === 1;
    }
}
}
