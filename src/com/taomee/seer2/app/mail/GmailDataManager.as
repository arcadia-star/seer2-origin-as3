package com.taomee.seer2.app.mail {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.controls.ActorAvatarPanel;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.EventDispatcher;
import flash.utils.IDataInput;

public class GmailDataManager extends EventDispatcher {

    private static var _instance:GmailDataManager;


    private var dataList:Vector.<GmailDataObj>;

    private var _isSorting:Boolean;

    private var _sortType:int = 1;

    private var _initDataCompleted:Boolean;

    private var initOverFunc:Function;

    private var _waitList:Array;

    private var _isRequesting:Boolean = false;

    private var _successBack:Function;

    private var _requestId:int;

    public function GmailDataManager(param1:InterClass) {
        this._waitList = [];
        super();
    }

    public static function getInstance():GmailDataManager {
        if (_instance == null) {
            _instance = new GmailDataManager(new InterClass());
        }
        return _instance;
    }

    public function initMailData(param1:Function = null):void {
        this.initOverFunc = param1;
        this.dataList = new Vector.<GmailDataObj>();
        Connection.addCommandListener(CommandSet.GET_MAIL_LIST_DATA, this.onGetMailList);
        Connection.send(CommandSet.GET_MAIL_LIST_DATA, ActorManager.actorInfo.id);
    }

    public function updateMailNum():void {
        this.initMailData(function ():void {
            var _loc3_:int = 0;
            var _loc1_:int = 0;
            var _loc2_:Vector.<GmailDataObj> = GmailDataManager.getInstance().getAllData();
            if (Boolean(_loc2_) && _loc2_.length > 0) {
                _loc3_ = 0;
                while (_loc3_ < _loc2_.length) {
                    if (_loc2_[_loc3_].readSymble == false) {
                        _loc1_++;
                    }
                    _loc3_++;
                }
            }
            ActorAvatarPanel.getInstance().setMailStatus(_loc1_);
        });
    }

    private function onGetMailList(param1:MessageEvent):void {
        var _loc5_:GmailDataObj = null;
        var _loc6_:int = 0;
        Connection.removeCommandListener(CommandSet.GET_MAIL_LIST_DATA, this.onGetMailList);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            (_loc5_ = new GmailDataObj()).mailId = _loc2_.readUnsignedInt();
            _loc5_.rawSendTime = _loc2_.readUnsignedInt();
            _loc6_ = int(_loc2_.readUnsignedInt());
            _loc5_.readSymble = _loc6_ == 1 ? true : false;
            _loc5_.type = _loc2_.readUnsignedInt();
            _loc5_.attachmentSymble = _loc2_.readUnsignedInt() == 1;
            _loc5_.senderId = _loc2_.readUnsignedInt();
            _loc5_.senderName = _loc2_.readUTFBytes(_loc2_.readUnsignedInt());
            _loc5_.mailTitle = _loc2_.readUTFBytes(_loc2_.readUnsignedInt());
            this.dataList.push(_loc5_);
            _loc4_++;
        }
        this.sortByType(1, false);
        this._initDataCompleted = true;
        if (this.initOverFunc != null) {
            this.initOverFunc();
            this.initOverFunc = null;
        }
    }

    public function get initDataCompleted():Boolean {
        return this._initDataCompleted;
    }

    public function saveSingleData(param1:GmailDataObj):void {
        if (this.dataList == null) {
            this.dataList = new Vector.<GmailDataObj>();
        }
        this.dataList.unshift(param1);
    }

    public function getAllData():Vector.<GmailDataObj> {
        return this.dataList;
    }

    public function getMailDataById(param1:int):GmailDataObj {
        var _loc2_:int = 0;
        while (_loc2_ < this.dataList.length) {
            if (this.dataList[_loc2_].mailId == param1) {
                return this.dataList[_loc2_];
            }
            _loc2_++;
        }
        return null;
    }

    public function getFullInfoFromServer(param1:int, param2:Function):void {
        this._waitList.push({
            "id": param1,
            "success": param2
        });
        this.processNext();
    }

    private function processNext():void {
        var _loc1_:Object = null;
        if (this._waitList.length > 0 && this._isRequesting == false) {
            this._isRequesting = true;
            _loc1_ = this._waitList.shift();
            this._requestId = _loc1_.id;
            this._successBack = _loc1_.success;
            Connection.addCommandListener(CommandSet.GET_SINGLE_MAIL_DATA, this.onGetMailFullData);
            Connection.send(CommandSet.GET_SINGLE_MAIL_DATA, ActorManager.actorInfo.id, int(_loc1_.id));
        }
    }

    private function onGetMailFullData(param1:MessageEvent):void {
        var _loc6_:GmailAttachInfo = null;
        Connection.removeCommandListener(CommandSet.GET_SINGLE_MAIL_DATA, this.onGetMailFullData);
        var _loc2_:GmailDataObj = new GmailDataObj();
        var _loc3_:IDataInput = param1.message.getRawData();
        _loc2_.mailId = _loc3_.readUnsignedInt();
        _loc2_.rawSendTime = _loc3_.readUnsignedInt();
        _loc2_.type = _loc3_.readUnsignedInt();
        _loc2_.attachmentSymble = Boolean(_loc3_.readUnsignedInt());
        _loc2_.senderId = _loc3_.readUnsignedInt();
        _loc2_.senderName = _loc3_.readUTFBytes(_loc3_.readUnsignedInt());
        _loc2_.mailTitle = _loc3_.readUTFBytes(_loc3_.readUnsignedInt());
        _loc2_.contentTxt = _loc3_.readUTFBytes(_loc3_.readUnsignedInt());
        _loc2_.attachmentArray = [];
        var _loc4_:int = int(_loc3_.readUnsignedInt());
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            (_loc6_ = new GmailAttachInfo()).itemId = _loc3_.readUnsignedInt();
            _loc6_.count = _loc3_.readUnsignedInt();
            _loc6_.flag = _loc3_.readUnsignedInt();
            _loc3_.readUnsignedInt();
            _loc3_.readUnsignedInt();
            _loc2_.attachmentArray.push(_loc6_);
            _loc5_++;
        }
        _loc2_.readSymble = _loc3_.readUnsignedInt() == 1;
        this._successBack(_loc2_);
        this._successBack = null;
        this._isRequesting = false;
        this.processNext();
    }

    public function getMailPosition(param1:int):int {
        var _loc2_:int = 0;
        while (_loc2_ < this.dataList.length) {
            if (this.dataList[_loc2_].mailId == param1) {
                return _loc2_;
            }
            _loc2_++;
        }
        return -1;
    }

    public function getMailByPosition(param1:int):GmailDataObj {
        if (param1 <= this.dataList.length - 1) {
            return this.dataList[param1];
        }
        return null;
    }

    public function deleteMail(param1:Array):void {
        if (param1 == null || param1.length <= 0) {
            return;
        }
        var _loc2_:int = -1;
        var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc3_.writeUnsignedInt(ActorManager.actorInfo.id);
        _loc3_.writeUnsignedInt(param1.length);
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_.writeUnsignedInt(param1[_loc4_]);
            _loc4_++;
        }
        Connection.send(CommandSet.DELETE_MAIL_ON_SERVER, _loc3_);
    }

    public function sortByType(param1:int = 1, param2:Boolean = true):void {
        if (this._isSorting) {
            return;
        }
        this._isSorting = true;
        this._sortType = param1;
        switch (this._sortType) {
            case GmailConst.SORT_TIME_DOWN:
                this.dataList.sort(this.sortNewToOld);
                break;
            case GmailConst.SORT_TIME_UP:
                this.dataList.sort(this.sortOldToNew);
        }
        this._isSorting = false;
        if (param2 == true) {
            dispatchEvent(new GmailEvent(GmailEvent.MAIL_SORT_COMPLETED));
        }
    }

    private function sortNewToOld(param1:GmailDataObj, param2:GmailDataObj):int {
        if (param1.rawSendTime > param2.rawSendTime) {
            return -1;
        }
        if (param1.rawSendTime < param2.rawSendTime) {
            return 1;
        }
        return 0;
    }

    private function sortOldToNew(param1:GmailDataObj, param2:GmailDataObj):int {
        if (param1.rawSendTime > param2.rawSendTime) {
            return 1;
        }
        if (param1.rawSendTime < param2.rawSendTime) {
            return -1;
        }
        return 0;
    }
}
}

class InterClass {


    public function InterClass() {
        super();
    }
}
