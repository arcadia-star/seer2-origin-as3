package com.taomee.seer2.app.miniGame {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferData;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.EventDispatcher;
import flash.utils.IDataInput;

public class MiniGameManager {

    private static var GAME_NUM:int = 43;

    private static var GAME_PLAYED:int = 4;

    private static var _gameStatusVec:Vector.<int>;

    private static var _gamePlayedVec:Vector.<int>;

    private static var _gameStatusFunc:Function;

    private static var _gamePlayedFunc:Function;

    private static var _position:int;

    private static var _value:int;

    private static var _gameId:int;

    private static var _moreGainCallBack:Function;

    private static var _eventDispatcher:EventDispatcher = new EventDispatcher();


    public function MiniGameManager() {
        super();
    }

    public static function getGameStatus(param1:Function = null):void {
        _gameStatusFunc = param1;
        if (_gameStatusVec == null) {
            _gameStatusVec = new Vector.<int>();
            ServerBufferManager.getServerBuffer(ServerBufferType.GAMESTATUS, onGetStatus);
            return;
        }
        if (_gameStatusFunc != null) {
            _gameStatusFunc();
        }
    }

    private static function onGetStatus(param1:ServerBuffer):void {
        var _loc2_:int = 0;
        while (_loc2_ < GAME_NUM) {
            _gameStatusVec[_loc2_] = param1.readDataAtPostion(_loc2_);
            _loc2_++;
        }
        if (_gameStatusFunc != null) {
            _gameStatusFunc();
        }
    }

    public static function updataGameStatus(param1:int, param2:int):void {
        _position = param1;
        _value = param2;
        if (_gameStatusVec == null) {
            getGameStatus(updataStatusToServer);
        } else {
            updataStatusToServer();
        }
    }

    private static function updataStatusToServer():void {
        if (_gameStatusVec[_position] != _value) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.GAMESTATUS, _position, _value);
            _gameStatusVec[_position] = _value;
        }
        if (_value == 1) {
            addPlayedGame(_position + 1);
        }
    }

    private static function addPlayedGame(param1:int):void {
        _gameId = param1;
        if (_gamePlayedVec == null) {
            getGamePlayed(updataGamePlayed);
        } else {
            updataGamePlayed();
        }
    }

    private static function updataGamePlayed():void {
        var _loc2_:int = 0;
        var _loc1_:int = 0;
        while (_loc1_ < _gamePlayedVec.length) {
            if (_gamePlayedVec[_loc1_] == _gameId) {
                if (_loc1_ == 0) {
                    return;
                }
                _loc2_ = _loc1_;
                while (_loc2_ > 0) {
                    _gamePlayedVec[_loc2_] = _gamePlayedVec[_loc2_ - 1];
                    _loc2_--;
                }
                _gamePlayedVec[0] = _gameId;
                updataPlayedToServer();
                return;
            }
            _loc1_++;
        }
        _gamePlayedVec.unshift(_gameId);
        while (_gamePlayedVec.length > 4) {
            _gamePlayedVec.pop();
        }
        updataPlayedToServer();
    }

    private static function updataPlayedToServer():void {
        var _loc3_:ServerBufferData = null;
        var _loc1_:Vector.<ServerBufferData> = new Vector.<ServerBufferData>();
        var _loc2_:int = 0;
        while (_loc2_ < GAME_PLAYED) {
            _loc3_ = new ServerBufferData(_loc2_, _gamePlayedVec[_loc2_]);
            _loc1_.push(_loc3_);
            _loc2_++;
        }
        ServerBufferManager.updateServerBufferGroup(ServerBufferType.GAMEPLAYED, _loc1_);
    }

    public static function getGamePlayed(param1:Function = null):void {
        _gamePlayedFunc = param1;
        if (_gamePlayedVec == null) {
            _gamePlayedVec = new Vector.<int>();
            ServerBufferManager.getServerBuffer(ServerBufferType.GAMEPLAYED, onGetPlayed);
            return;
        }
        if (_gamePlayedFunc != null) {
            _gamePlayedFunc();
        }
    }

    private static function onGetPlayed(param1:ServerBuffer):void {
        var _loc2_:int = 0;
        while (_loc2_ < GAME_PLAYED) {
            _gamePlayedVec[_loc2_] = param1.readDataAtPostion(_loc2_);
            _loc2_++;
        }
        if (_gamePlayedFunc != null) {
            _gamePlayedFunc();
        }
    }

    public static function getMoreGainGameIdVec(param1:Function):void {
        _moreGainCallBack = param1;
        Connection.addCommandListener(CommandSet.MINIGAME_MOREGAIN_1091, onGetMoreGainGameIdVec);
        Connection.send(CommandSet.MINIGAME_MOREGAIN_1091);
    }

    private static function onGetMoreGainGameIdVec(param1:MessageEvent):void {
        var _loc6_:uint = 0;
        var _loc2_:Vector.<int> = new Vector.<int>();
        Connection.removeCommandListener(CommandSet.MINIGAME_MOREGAIN_1091, onGetMoreGainGameIdVec);
        var _loc3_:IDataInput = param1.message.getRawData();
        var _loc4_:uint = uint(_loc3_.readUnsignedInt());
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = uint(_loc3_.readUnsignedInt());
            _loc2_.push(_loc6_);
            _loc5_++;
        }
        _moreGainCallBack(_loc2_);
    }

    public static function getGameStatusById(param1:int):int {
        if (_gameStatusVec != null) {
            if (_gameStatusVec.length == GAME_NUM) {
                return _gameStatusVec[param1 - 1];
            }
        }
        return 0;
    }

    public static function getGamePlayedVec():Vector.<int> {
        return _gamePlayedVec;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _eventDispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchDreamEvent(param1:String, param2:int, param3:MiniGameInfo = null):void {
        if (_eventDispatcher.hasEventListener(param1)) {
            _eventDispatcher.dispatchEvent(new MiniGameEvent(param1, param2, param3));
        }
    }
}
}
