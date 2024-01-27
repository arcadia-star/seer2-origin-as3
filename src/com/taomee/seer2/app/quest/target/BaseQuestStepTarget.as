package com.taomee.seer2.app.quest.target {
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.data.TargetDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class BaseQuestStepTarget {

    protected static const DEFAULT_INDEX:int = 0;


    protected var _quest:Quest;

    protected var _type:String;

    protected var _count:int;

    protected var _params:String;

    protected var _alert:String;

    protected var _transport:String;

    public function BaseQuestStepTarget(param1:Quest, param2:TargetDefinition) {
        super();
        this._quest = param1;
        this._type = param2.type;
        this._count = param2.count;
        this._params = param2.params;
        this._alert = param2.alert;
        this._transport = param2.transport;
    }

    public static function createTarget(param1:Quest, param2:TargetDefinition):BaseQuestStepTarget {
        var _loc3_:BaseQuestStepTarget = null;
        var _loc4_:String = String(param2.type);
        switch (_loc4_) {
            case _loc4_ = "mine":
                _loc3_ = new QuestStepTargetMine(param1, param2);
                break;
            case _loc4_ = "wild":
                _loc3_ = new QuestStepTargetFightWild(param1, param2);
                break;
            case _loc4_ = "sptBoss":
                _loc3_ = new QuestStepTargetSptBoss(param1, param2);
                break;
            case _loc4_ = "catch":
                _loc3_ = new QuestStepTargetCatchWild(param1, param2);
                break;
            case _loc4_ = "dailyWild":
                _loc3_ = new QuestStepTargetFightDailyWild(param1, param2);
        }
        return _loc3_;
    }

    public function start():void {
        QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onStepUpdateBuffer);
    }

    public function finish():void {
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onStepUpdateBuffer);
    }

    public function get leftCount():int {
        return this._count - this._quest.getStepData(this._quest.getCurrentOrNextStep().id, DEFAULT_INDEX);
    }

    public function get isFinish():Boolean {
        return this.leftCount <= 0;
    }

    protected function execute():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:String = null;
        if (this.isFinish == false) {
            _loc1_ = int(this._quest.getStepData(this._quest.getCurrentOrNextStep().id, DEFAULT_INDEX));
            _loc1_ += 1;
            this._quest.setStepData(this._quest.getCurrentOrNextStep().id, DEFAULT_INDEX, _loc1_);
            _loc2_ = this._count - _loc1_;
            if (this._alert != "" && _loc2_ > 0) {
                _loc3_ = this._alert.replace("{num}", _loc1_);
                _loc3_ = _loc3_.replace("{leftNum}", _loc2_);
                ServerMessager.addMessage(_loc3_);
            }
            QuestManager.setStepBufferServer(this._quest.id, this._quest.getCurrentOrNextStep().id);
        }
    }

    protected function completeStep():void {
    }

    private function onStepUpdateBuffer(param1:QuestEvent):void {
        if (this.isFinish) {
            this.finish();
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onCompleteStep);
            QuestManager.completeStep(this._quest.id, this._quest.getCurrentOrNextStep().id);
        }
    }

    protected function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == this._quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteStep);
            this.completeStep();
            if (param1.type == QuestEvent.STEP_COMPLETE) {
                ServerMessager.addMessage("当前任务步骤完成！");
            }
        }
    }
}
}
