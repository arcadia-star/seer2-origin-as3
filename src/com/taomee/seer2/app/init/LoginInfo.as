package com.taomee.seer2.app.init {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.team.data.TeamMainInfo;
import com.taomee.seer2.core.manager.TimeManager;

import flash.utils.ByteArray;
import flash.utils.IDataInput;

public class LoginInfo {

    private static var _serverID:uint;

    private static var _onlineIP:String;

    private static var _onlinePort:uint;

    private static var _session:ByteArray;

    private static var _userData:IDataInput;

    private static var _account:uint;

    private static var _loginAccount:String;

    private static var _mapId:int;

    private static var _sceneId:int;

    private static var _userInfo:UserInfo;

    private static var _completeQuestIdVec:Vector.<int>;

    private static var _lastCompleteQuestIdVec:Vector.<int>;

    private static var _inProgressQuestIdVec:Vector.<int>;

    private static var _isShowLoginAwardPanel:uint;

    private static var _expiredEquipList:Array;

    private static var _gift_index:uint;

    private static var _onLineDays:uint;

    private static var _dayOneLogin:Boolean;

    private static var _summerRegistrationDays:uint;


    public function LoginInfo() {
        super();
    }

    public static function get onLineDays():uint {
        return _onLineDays;
    }

    public static function get giftIndex():uint {
        return _gift_index;
    }

    public static function get serverID():uint {
        return _serverID;
    }

    public static function get onlineIP():String {
        return _onlineIP;
    }

    public static function get onlinePort():uint {
        return _onlinePort;
    }

    public static function get session():ByteArray {
        return _session;
    }

    public static function get userData():IDataInput {
        return _userData;
    }

    public static function get account():uint {
        return _account;
    }

    public static function get mapId():int {
        return _mapId;
    }

    public static function get sceneId():int {
        return _sceneId;
    }

    public static function get userInfo():UserInfo {
        return _userInfo;
    }

    public static function get completeQuestIdVec():Vector.<int> {
        return _completeQuestIdVec;
    }

    public static function get lastCompleteQuestIdVec():Vector.<int> {
        return _lastCompleteQuestIdVec;
    }

    public static function get inProgressQuestIdVec():Vector.<int> {
        return _inProgressQuestIdVec;
    }

    public static function get isShowLoginAwardPanel():uint {
        return _isShowLoginAwardPanel;
    }

    public static function get expiredEquipList():Array {
        return _expiredEquipList;
    }

    public static function get summerRegistrationDays():uint {
        return _summerRegistrationDays;
    }

    public static function setFromBaseInfo(param1:Object):void {
        _session = param1.session;
        _serverID = param1.serverId;
        _onlineIP = param1.onlineServerIp;
        _onlinePort = param1.onlineServerPort;
        _userData = param1.userData;
        _account = param1.account;
        _loginAccount = param1.loginAccount;
    }

    public static function setFromOnline(param1:IDataInput):void {
        _userInfo = new UserInfo(param1);
        _userInfo.serverID = _serverID;
        _userInfo.sex = param1.readUnsignedByte();
        _userInfo.coins = param1.readUnsignedInt();
        _mapId = param1.readUnsignedInt();
        _sceneId = param1.readUnsignedInt();
        _userInfo.trainerScore = param1.readUnsignedInt();
        _userInfo.highestPetLevel = param1.readUnsignedByte();
        TimeManager.setupLogin(param1);
        parseQuestData(param1);
        PetInfoManager.setupPetInfoData(param1);
        _userInfo.setFollowingPetInfo(PetInfoManager.getFollowingPetInfo());
        _userInfo.setPetRidePetInfo(PetInfoManager.getPetRidingPetInfo());
        TimeManager.setupTime(param1);
        _isShowLoginAwardPanel = param1.readUnsignedInt();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        _userInfo.stateFlag = _loc2_ & 1;
        _userInfo.callerUserId = param1.readUnsignedInt();
        TeamMainInfo.readBaseInfo(_userInfo.teamInfo, param1);
        TeamMainInfo.readMoreInfo(_userInfo.teamInfo, param1);
        _userInfo.honorNum = param1.readUnsignedInt();
        _userInfo.vipInfo.readBase(param1);
        _userInfo.updateNonoInfo(param1);
        _userInfo.updateNonoTimeButler(param1);
        parseExpiredEquip(param1);
        _onLineDays = param1.readUnsignedInt();
        _gift_index = param1.readUnsignedInt();
        _summerRegistrationDays = param1.readUnsignedInt();
        var _loc3_:uint = uint(param1.readUnsignedInt());
        _userInfo.ip = param1.readUTFBytes(UserInfo.IP_ARRAY_LEN);
        _userInfo.isYearVip = param1.readUnsignedInt();
        if (_loc3_ != 0) {
            _userInfo.birthdayInfo.isOpen = true;
            _userInfo.birthdayInfo.year = uint(_loc3_ / 10000);
            _userInfo.birthdayInfo.month = uint(_loc3_ % 10000 / 100);
            _userInfo.birthdayInfo.day = _loc3_ % 100;
        }
    }

    private static function parseExpiredEquip(param1:IDataInput):void {
        _expiredEquipList = [];
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _expiredEquipList.push(param1.readUnsignedInt());
            _loc3_++;
        }
    }

    private static function parseQuestData(param1:IDataInput):void {
        _completeQuestIdVec = new Vector.<int>();
        _lastCompleteQuestIdVec = new Vector.<int>();
        _inProgressQuestIdVec = new Vector.<int>();
        var _loc2_:int = int(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _completeQuestIdVec.push(param1.readUnsignedInt());
            _loc3_++;
        }
        _loc2_ = int(param1.readUnsignedInt());
        _loc3_ = 0;
        while (_loc3_ < _loc2_) {
            _lastCompleteQuestIdVec.push(param1.readUnsignedInt());
            _loc3_++;
        }
        _loc2_ = int(param1.readUnsignedInt());
        _loc3_ = 0;
        while (_loc3_ < _loc2_) {
            _inProgressQuestIdVec.push(param1.readUnsignedInt());
            _loc3_++;
        }
    }

    public static function startCheckDayOneLogin():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.DAY_ONE_LOGIN, onGetServer);
    }

    private static function onGetServer(param1:ServerBuffer):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc2_.fullYear != param1.readDataAtPostionGetInt(0) || _loc2_.month != param1.readDataAtPostion(4) || _loc2_.date != param1.readDataAtPostion(5)) {
            _dayOneLogin = true;
            DayOneLoginUpdateBuffer.setServerBuffer();
        }
    }

    public static function get dayOneLogin():Boolean {
        return _dayOneLogin;
    }
}
}
