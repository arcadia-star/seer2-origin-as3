package com.taomee.seer2.core.loader {
public class QueueLoader {

    private static var _impl:QueueLoaderImpl = new QueueLoaderImpl();


    public function QueueLoader() {
        super();
    }

    public static function get currentInfo():QueueInfo {
        return _impl.currentInfo;
    }

    public static function get waitList():Array {
        return _impl.waitList;
    }

    public static function load(param1:String, param2:String, param3:Function, param4:Function = null, param5:* = null, param6:int = 2, param7:Function = null, param8:Function = null, param9:Boolean = false):void {
        _impl.load(param1, param2, param3, param4, param5, param6, param7, param8, param9);
    }

    public static function addBef(param1:String, param2:String):void {
        _impl.addBef(param1, param2);
    }

    public static function hasCompleteHandlerFromData(param1:String, param2:String, param3:Function):Boolean {
        return _impl.hasCompleteHandlerFromData(param1, param2, param3);
    }

    public static function cancel(param1:String, param2:Function):void {
        _impl.cancel(param1, param2);
    }

    public static function cancelURL(param1:String):void {
        _impl.cancelURL(param1);
    }

    public static function cancelHandler(param1:Function):void {
        _impl.cancelHandler(param1);
    }

    public static function cancelData(param1:String, param2:*, param3:String = null):void {
        _impl.cancelData(param1, param2, param3);
    }

    public static function cancelAll():void {
        _impl.cancelAll();
    }

    public static function pause():void {
        _impl.pause();
    }

    public static function resume():void {
        _impl.resume();
    }
}
}
