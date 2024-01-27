package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.geom.Point;

import org.taomee.utils.BitUtil;

public class QuestProcessor_7 extends QuestProcessor {

    private static const HAIMA_STEP_ID:int = 4;

    private static const HAIMA_STEP_INDEX:int = 0;

    private static const HAIMA_MAX_NUM:int = 5;


    private var _haimaPetVec:Vector.<Mobile>;

    public function QuestProcessor_7(param1:Quest) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this.initHaima();
    }

    private function initHaima():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        if (Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(5)) {
            this._haimaPetVec = new Vector.<Mobile>();
            _loc1_ = this.caculateHaimaCount();
            _loc2_ = 0;
            while (_loc2_ < _loc1_) {
                this.addHaimaPet();
                _loc2_++;
            }
            if (_loc1_ > 0) {
                ActorManager.getActor().blockFollowingPet = true;
            }
        }
    }

    private function addHaimaPet():void {
        var _loc1_:Mobile = new Mobile();
        _loc1_.resourceUrl = URLUtil.getPetSwf(41);
        this._haimaPetVec.push(_loc1_);
        ActorManager.getActor().addCarriedMobile(_loc1_, 50 + 30 * (this._haimaPetVec.length - 1));
        _loc1_.setPostion(new Point(ActorManager.getActor().x + 30, ActorManager.getActor().y));
    }

    public function disposeHaima():void {
        var _loc1_:int = int(this._haimaPetVec.length);
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            ActorManager.getActor().removeCarriedMobile(this._haimaPetVec[_loc2_]);
            this._haimaPetVec[_loc2_].dispose();
            _loc2_++;
        }
        ActorManager.getActor().blockFollowingPet = false;
    }

    public function isHaimaFound(param1:int):Boolean {
        var _loc2_:int = int(_quest.getStepData(HAIMA_STEP_ID, HAIMA_STEP_INDEX));
        return BitUtil.getBit(_quest.getStepData(HAIMA_STEP_ID, HAIMA_STEP_INDEX), param1);
    }

    public function setHaimaFlagServer(param1:int):void {
        var _loc2_:int = int(_quest.getStepData(HAIMA_STEP_ID, HAIMA_STEP_INDEX));
        _loc2_ = int(BitUtil.setBit(_loc2_, param1, true));
        _quest.setStepData(HAIMA_STEP_ID, HAIMA_STEP_INDEX, _loc2_);
        if (this.caculateHaimaCount() == HAIMA_MAX_NUM) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            QuestManager.completeStep(_quest.id, HAIMA_STEP_ID);
        } else {
            ServerMessager.addMessage("你还剩" + (HAIMA_MAX_NUM - this.caculateHaimaCount()) + "只小海马没有找到");
            QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBuffer);
            QuestManager.setStepBufferServer(_quest.id, HAIMA_STEP_ID);
        }
    }

    private function onCompleteStep4(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            this.addHaimaPet();
        }
    }

    private function onUpdateStepBuffer(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBuffer);
            if (this._haimaPetVec == null) {
                this.initHaima();
            } else {
                this.addHaimaPet();
            }
        }
    }

    private function caculateHaimaCount():int {
        var _loc1_:int = int(_quest.getStepData(HAIMA_STEP_ID, HAIMA_STEP_INDEX));
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        while (_loc3_ < 5) {
            if (BitUtil.getBit(_loc1_, _loc3_)) {
                _loc2_++;
            }
            _loc3_++;
        }
        return _loc2_;
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
