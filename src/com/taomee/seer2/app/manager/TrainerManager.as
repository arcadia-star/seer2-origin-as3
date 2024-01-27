package com.taomee.seer2.app.manager {
import flash.events.Event;
import flash.events.EventDispatcher;

public class TrainerManager {

    public static const TASK_COMPLETE:String = "taskComplete";

    private static var _eventDispatcher:EventDispatcher = new EventDispatcher();

    public static var typeId:uint;

    public static var taskId:uint;

    public static var progress:uint;

    public static var isComplete:Boolean;


    public function TrainerManager() {
        super();
    }

    public static function dispatcheEvent(param1:uint, param2:uint, param3:uint, param4:uint):void {
        typeId = param1;
        taskId = param2;
        progress = param3;
        isComplete = param4 == 1;
        _eventDispatcher.dispatchEvent(new Event(TASK_COMPLETE));
    }

    public static function addEventListener(param1:Function):void {
        _eventDispatcher.addEventListener(TASK_COMPLETE, param1);
    }

    public static function removeEventListener(param1:Function):void {
        _eventDispatcher.removeEventListener(TASK_COMPLETE, param1);
    }
}
}
