package com.taomee.seer2.app.net {
import com.taomee.seer2.app.manager.StatisticsManager2;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.log.Logger;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.net.TcpSocket;
import com.taomee.seer2.core.net.message.Message;
import com.taomee.seer2.core.net.message.RequestPacker;
import com.taomee.seer2.core.net.message.ResponseParser;

import flash.events.DataEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.ByteArray;
import flash.utils.Endian;

import org.taomee.ds.HashMap;

public class Connection {

    public static const TEL:uint = 0;

    public static const CNC:uint = 1;

    public static var netType:uint;

    private static var _endian:String = Endian.LITTLE_ENDIAN;

    private static var _userId:int;

    private static var _socket:TcpSocket;

    private static var _logger:Logger;

    private static var _blockedMap:HashMap = new HashMap();

    private static var _messageDispatcher:EventDispatcher = new EventDispatcher();

    private static var _errorDispatcher:EventDispatcher = new EventDispatcher();

    {
        initialize();
    }

    public function Connection() {
        super();
    }

    private static function initialize():void {
        _logger = Logger.getLogger("Connection");
        _socket = new TcpSocket();
        _socket.endian = _endian;
        _socket.addEventListener(Event.CLOSE, onSocketClose);
        _socket.addEventListener(DataEvent.DATA, onSocketData);
    }

    public static function set endian(param1:String):void {
        _endian = param1;
        _socket.endian = _endian;
    }

    public static function get endian():String {
        return _endian;
    }

    public static function setUserId(param1:int):void {
        _userId = param1;
    }

    public static function setGameId(param1:int):void {
        StatisticsManager2.setup(param1);
    }

    public static function connect(param1:String, param2:int):void {
        _socket.connect(param1, param2);
    }

    private static function onSocketClose(param1:Event):void {
        var evt:Event = param1;
        _logger.error("断开连接！");
        try {
            AlertManager.showAlert("客户端和服务器连接已断开！", refreshPage);
        } catch (e:Error) {
            _logger.error("UI 还未起来");
        }
    }

    private static function refreshPage():void {
        if (ClientConfig.isDebug == false) {
            navigateToURL(new URLRequest("javascript:location.reload();"), "_self");
        }
    }

    private static function onSocketData(param1:DataEvent):void {
        var _loc3_:Message = null;
        var _loc2_:Vector.<Message> = _socket.getMessageQueue();
        while (_loc2_.length > 0) {
            _loc3_ = _loc2_.shift();
            if (_blockedMap.containsKey(_loc3_.commandId) == true) {
                blockMessage(_loc3_);
            } else {
                handleMessage(_loc3_);
            }
        }
    }

    private static function blockMessage(param1:Message):void {
        var _loc2_:BlockedCommandStructure = null;
        var _loc3_:Vector.<Message> = null;
        if (_blockedMap.containsKey(param1.commandId) == true) {
            _loc2_ = _blockedMap.getValue(param1.commandId);
            _loc3_ = _loc2_.messageVec;
            _loc3_.push(param1);
        }
    }

    private static function handleMessage(param1:Message):void {
        if (param1.statusCode != 0) {
            _logger.error("S2C: " + Command.findDescriptionById(param1.commandId) + " Error Code: " + param1.statusCode + " " + ErrorMap.findErrorMessage(param1.statusCode));
            if (_errorDispatcher.hasEventListener(param1.commandId.toString())) {
                _errorDispatcher.dispatchEvent(new MessageEvent(param1.commandId.toString(), param1));
            } else {
                ErrorMap.parseStatusCode(param1.statusCode);
            }
        } else {
            _logger.info("S2C: " + Command.findDescriptionById(param1.commandId) + " dataLength: " + param1.getRawData().length);
            _messageDispatcher.dispatchEvent(new MessageEvent(param1.commandId.toString(), param1));
        }
    }

    public static function blockCommand(param1:Command):void {
        var _loc3_:BlockedCommandStructure = null;
        var _loc2_:uint = param1.id;
        if (_blockedMap.containsKey(_loc2_) == false) {
            _loc3_ = new BlockedCommandStructure();
            _blockedMap.add(_loc2_, _loc3_);
        }
    }

    public static function releaseCommand(param1:Command):void {
        var _loc3_:BlockedCommandStructure = null;
        var _loc4_:Vector.<Array> = null;
        var _loc5_:Array = null;
        var _loc6_:Vector.<Message> = null;
        var _loc7_:Message = null;
        var _loc2_:uint = param1.id;
        if (_blockedMap.containsKey(_loc2_) == true) {
            _loc3_ = _blockedMap.remove(_loc2_);
            _loc4_ = _loc3_.requestArgs;
            for each(_loc5_ in _loc4_) {
                send(param1, _loc5_);
            }
            _loc6_ = _loc3_.messageVec;
            for each(_loc7_ in _loc6_) {
                handleMessage(_loc7_);
            }
        }
    }

    public static function send(param1:Command, ...rest):void {
        var _loc3_:BlockedCommandStructure = null;
        var _loc4_:Vector.<Array> = null;
        var _loc5_:ByteArray = null;
        if (_blockedMap.containsKey(param1.id)) {
            _loc3_ = _blockedMap.getValue(param1.id);
            (_loc4_ = _loc3_.requestArgs).push(rest);
        } else {
            _loc5_ = RequestPacker.pack(_userId, param1.id, rest, _endian);
            _socket.send(_loc5_);
            _logger.info("C2S: " + Command.findDescriptionById(param1.id) + " dataLength: " + (_loc5_.length - Message.HEAD_LENGTH));
        }
    }

    public static function close():void {
        _socket.close();
        _logger.info("Easy~ 客户端主动断开连接");
    }

    public static function addEventListener(param1:String, param2:Function):void {
        _socket.addEventListener(param1, param2);
    }

    public static function removeEventListener(param1:String, param2:Function):void {
        _socket.removeEventListener(param1, param2);
    }

    public static function addCommandMessageParser(param1:Command, param2:Class):void {
        ResponseParser.addRule(param1.id, param2);
    }

    public static function removeCommandMessageParser(param1:Command):void {
        ResponseParser.removeRule(param1.id);
    }

    public static function addErrorHandler(param1:Command, param2:Function):void {
        _errorDispatcher.addEventListener(param1.id.toString(), param2);
    }

    public static function removeErrorHandler(param1:Command, param2:Function):void {
        _errorDispatcher.removeEventListener(param1.id.toString(), param2);
    }

    public static function addCommandListener(param1:Command, param2:Function):void {
        _messageDispatcher.addEventListener(param1.id.toString(), param2);
    }

    public static function hasCommadnListener(param1:Command):Boolean {
        return _messageDispatcher.hasEventListener(param1.id.toString());
    }

    public static function removeCommandListener(param1:Command, param2:Function):void {
        _messageDispatcher.removeEventListener(param1.id.toString(), param2);
    }
}
}

import com.taomee.seer2.core.net.message.Message;

class BlockedCommandStructure {


    public var requestArgs:Vector.<Array>;

    public var messageVec:Vector.<Message>;

    public function BlockedCommandStructure() {
        super();
        this.requestArgs = new Vector.<Array>();
        this.messageVec = new Vector.<Message>();
    }
}
