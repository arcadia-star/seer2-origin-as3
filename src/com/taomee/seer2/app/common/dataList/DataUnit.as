package com.taomee.seer2.app.common.dataList {
import com.taomee.seer2.app.net.Command;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.IDataInput;

public class DataUnit extends EventDispatcher {

    public static const EMPTY:String = "empty";

    public static const BUSY:String = "busy";

    public static const READY:String = "ready";


    private var _id:int;

    private var _cmd:Command;

    private var _status:String;

    public function DataUnit(param1:int, param2:Command) {
        super();
        this._id = param1;
        this._cmd = param2;
        this._status = EMPTY;
    }

    public function start():void {
        this._status = BUSY;
        Connection.addCommandListener(this._cmd, this.onSuccess);
        Connection.send(this._cmd, this._id);
    }

    private function onSuccess(param1:MessageEvent):void {
        Connection.removeCommandListener(this._cmd, this.onSuccess);
        this._status = READY;
        this.parseData(param1.message.getRawData());
        dispatchEvent(new Event(DataList.UNIT_READY));
    }

    protected function parseData(param1:IDataInput):void {
    }

    public function cancel():void {
        Connection.removeCommandListener(this._cmd, this.onSuccess);
        this._status = EMPTY;
    }

    public function get status():String {
        return this._status;
    }

    public function set status(param1:String):void {
        this._status = param1;
    }

    public function get id():int {
        return this._id;
    }

    public function get data():* {
        return null;
    }
}
}
