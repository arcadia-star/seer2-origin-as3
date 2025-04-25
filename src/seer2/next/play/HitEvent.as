package seer2.next.play {
import flash.events.Event;

public class HitEvent extends Event {
    public var data:HitData;

    public function HitEvent(param1:String, hitData:HitData, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this.data = hitData;
    }
}
}
