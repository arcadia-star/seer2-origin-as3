package com.taomee.seer2.core.quest {
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.quest.buffer.QuestClientBuffer;
import com.taomee.seer2.core.quest.buffer.QuestServerBuffer;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.constant.QuestStepStatus;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.quest.data.QuestDefinition;
import com.taomee.seer2.core.quest.data.QuestStepDefinition;
import com.taomee.seer2.core.quest.data.TargetDefinition;
import com.taomee.seer2.core.utils.DateUtil;

public class Quest {

    private static const SERVER_BUFFER_LENGTH:int = 20;

    private static const CLIENT_BUFFER_LENGTH:int = 44;


    private var _id:int;

    private var _name:String;

    private var _des:String;

    private var _type:uint;

    private var _needMark:Boolean;

    private var _autoNext:Boolean;

    private var _trackable:Boolean;

    private var _relatedMapIds:Vector.<int>;

    private var _acceptMapId:int;

    private var _onlineTime:Date;

    private var _isLastComplete:Boolean;

    private var _prerequisite:QuestPrerequisite;

    private var _acceptDialog:DialogDefinition;

    public var acceptNpcId:int;

    private var _stepVec:Vector.<QuestStep>;

    private var _status:int;

    private var _serverBuffer:QuestServerBuffer;

    private var _clientBuffer:QuestClientBuffer;

    private var _monLvlUp:String;

    private var _isShow:Boolean;

    public function Quest(param1:QuestDefinition) {
        super();
        this.parseDefinition(param1);
        this._status = QuestStatus.NONE;
    }

    public function get clientBuffer():QuestClientBuffer {
        return this._clientBuffer;
    }

    public function parseDefinition(param1:QuestDefinition):void {
        var _loc2_:QuestStepDefinition = null;
        this._id = param1.id;
        this._name = param1.name;
        this._type = param1.type;
        this._monLvlUp = param1.monLvlUp;
        this._isShow = param1.isShow;
        this._prerequisite = new QuestPrerequisite(param1.prerequisiteDefinition);
        this._acceptDialog = param1.acceptDialog;
        this.acceptNpcId = param1.acceptNpcId;
        if (this.acceptNpcId == 0 && Boolean(this._acceptDialog)) {
            this.acceptNpcId = this._acceptDialog.npcId;
        }
        this._autoNext = param1.autoNext;
        this._needMark = param1.needAcceptMark;
        this._des = param1.des;
        this._onlineTime = DateUtil.parse(param1.onlineTime);
        this._stepVec = new Vector.<QuestStep>();
        for each(_loc2_ in param1.stepDefinitionVec) {
            this._stepVec.push(new QuestStep(this, _loc2_));
        }
        this._relatedMapIds = param1.relatedMapIds;
        this._acceptMapId = param1.acceptMapId;
    }

    public function setBuffer(param1:LittleEndianByteArray = null):void {
        if (param1 == null) {
            param1 = new LittleEndianByteArray();
            param1.length = SERVER_BUFFER_LENGTH + CLIENT_BUFFER_LENGTH;
        }
        this._serverBuffer = new QuestServerBuffer(param1);
        this._clientBuffer = new QuestClientBuffer(param1);
    }

    public function generateStepBuffer(param1:int, param2:Boolean):LittleEndianByteArray {
        var _loc3_:QuestClientBuffer = new QuestClientBuffer(this._clientBuffer.pack());
        if (param2) {
            _loc3_.setStepStatus(param1, QuestStepStatus.COMPLETE);
        } else {
            _loc3_.setStepStatus(param1, QuestStepStatus.UNCOMPLETE);
        }
        var _loc4_:LittleEndianByteArray = new LittleEndianByteArray();
        var _loc5_:* = this.getStep(param1).outcome != null;
        var _loc6_:int = param2 && _loc5_ ? 1 : 0;
        _loc4_.writeByte(_loc6_);
        _loc4_.writeBytes(_loc3_.pack(), 0);
        return _loc4_;
    }

    public function updateStepStatus(param1:int, param2:Boolean):void {
        if (param2) {
            this._clientBuffer.setStepStatus(param1, QuestStepStatus.COMPLETE);
        } else {
            this._clientBuffer.setStepStatus(param1, QuestStepStatus.UNCOMPLETE);
        }
    }

    public function setStepData(param1:int, param2:int, param3:int):void {
        this._clientBuffer.setStepData(param1, param2, param3);
    }

    public function getStepData(param1:int, param2:int):int {
        return this._clientBuffer.getStepData(param1, param2);
    }

    public function isStepCompletable(param1:int):Boolean {
        if (this._status != QuestStatus.IN_PROGRESS) {
            return false;
        }
        var _loc2_:int = 1;
        while (_loc2_ < param1) {
            if (!this.isStepCompete(_loc2_)) {
                return false;
            }
            _loc2_++;
        }
        return !this.isStepCompete(param1);
    }

    public function isStepCompete(param1:int):Boolean {
        var _loc2_:* = false;
        if (this._status == QuestStatus.IN_PROGRESS) {
            _loc2_ = this._clientBuffer.getStepStatus(param1) == QuestStepStatus.COMPLETE;
            if (this._stepVec.length == param1) {
                _loc2_ = false;
            }
        } else if (this._status == QuestStatus.COMPLETE) {
            _loc2_ = true;
        }
        return _loc2_;
    }

    public function verifyPrerequisite():Boolean {
        return this._prerequisite.verifyPrerequisite();
    }

    public function get id():int {
        return this._id;
    }

    public function get name():String {
        return this._name;
    }

    public function get type():uint {
        return this._type;
    }

    public function get trackable():Boolean {
        return this._trackable;
    }

    public function set status(param1:int):void {
        this._status = param1;
    }

    public function get status():int {
        return this._status;
    }

    public function get acceptDialog():DialogDefinition {
        return this._acceptDialog;
    }

    public function get needAcceptMark():Boolean {
        return this._needMark;
    }

    public function get autoNext():Boolean {
        return this._autoNext;
    }

    public function get des():String {
        return this._des;
    }

    public function get monLvlUp():String {
        return this._monLvlUp;
    }

    public function get isShow():Boolean {
        return this._isShow;
    }

    public function get isLastComplete():Boolean {
        return this._isLastComplete;
    }

    public function set isLastComplete(param1:Boolean):void {
        this._isLastComplete = param1;
    }

    public function getCurrentNpcIdVec():Vector.<int> {
        var _loc2_:QuestStep = null;
        var _loc1_:Vector.<int> = new Vector.<int>();
        if (this.status == QuestStatus.ACCEPTABLE) {
            _loc1_.push(this.acceptNpcId);
        } else if (this.status == QuestStatus.IN_PROGRESS) {
            for each(_loc2_ in this.getCurrentStepVec()) {
                _loc1_.push(_loc2_.relatedNpcId);
            }
        }
        return _loc1_;
    }

    public function getCurrentStepVec():Vector.<QuestStep> {
        var _loc2_:QuestStep = null;
        var _loc1_:Vector.<QuestStep> = new Vector.<QuestStep>();
        for each(_loc2_ in this._stepVec) {
            if (this.isStepOpen(_loc2_.id)) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getQuestDialogDefintion(param1:int):DialogDefinition {
        if (param1 < 0 || param1 > this._stepVec.length) {
            return null;
        }
        if (param1 == 0) {
            return this._acceptDialog;
        }
        return this.getStep(param1).dialog;
    }

    public function getQuestTargetDefinition(param1:int):TargetDefinition {
        if (param1 < 0 || param1 > this._stepVec.length) {
            return null;
        }
        return this.getStep(param1).target;
    }

    public function isStepOpen(param1:int):Boolean {
        if (param1 <= 0 || param1 > this._stepVec.length) {
            return false;
        }
        return this.isStepCompletable(param1);
    }

    public function getRelatedMapIds():Vector.<int> {
        return this._relatedMapIds;
    }

    public function getAcceptMapId():int {
        return this._acceptMapId;
    }

    public function getCurrentOrNextStep():QuestStep {
        var _loc1_:int = 1;
        while (_loc1_ <= this.getStepVec().length) {
            if (!this.isStepCompete(_loc1_)) {
                break;
            }
            _loc1_++;
        }
        return this.getStep(_loc1_);
    }

    public function get isNewOnline():Boolean {
        var _loc1_:Boolean = false;
        if (this._onlineTime == null) {
            return false;
        }
        return (new Date().getTime() - this._onlineTime.getTime()) / (DateUtil.MILLISECONDS_PER_SECOND * DateUtil.SECONDS_PER_DAY) < 7;
    }

    public function get isInTime():Boolean {
        var _loc1_:uint = TimeManager.getServerTime();
        if (!this._onlineTime || _loc1_ * 1000 > this._onlineTime.getTime()) {
            return true;
        }
        return false;
    }

    public function getStep(param1:int):QuestStep {
        return this._stepVec[param1 - 1];
    }

    public function getStepVec():Vector.<QuestStep> {
        return this._stepVec;
    }

    public function getStepCount():uint {
        if (this._stepVec == null) {
            return 0;
        }
        return this._stepVec.length;
    }
}
}
