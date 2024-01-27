package org.taomee.bean {
import flash.events.Event;
import flash.events.ProgressEvent;

public class BeanEvent extends Event {

    public static const OPEN:String = Event.OPEN;

    public static const COMPLETE:String = Event.COMPLETE;

    public static const PROGRESS:String = ProgressEvent.PROGRESS;


    private var _id:String;

    public function BeanEvent(param1:String, param2:String) {
        super(param1);
        this._id = param2;
    }

    public function get id():String {
        return this._id;
    }
}
}
