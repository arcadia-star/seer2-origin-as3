package com.taomee.seer2.app.quest {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.quest.animation.QuestCompleteAnimation;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.system.ApplicationDomain;

import org.taomee.ds.HashMap;

public class QuestProcessManager {

    private static var _completeAnimation:QuestCompleteAnimation;

    private static var _notShowAnimationArr:Array = [1, 2, 4];

    private static var _map:HashMap;


    public function QuestProcessManager() {
        super();
    }

    public static function setup():void {
        QuestManager.addEventListener(QuestEvent.INIT, onQuestInit);
    }

    private static function onQuestInit(param1:QuestEvent):void {
        _map = new HashMap();
        QuestManager.removeEventListener(QuestEvent.INIT, onQuestInit);
        QuestManager.addEventListener(QuestEvent.ACCEPT, onQuestChange);
        QuestManager.addEventListener(QuestEvent.ABORT, onQuestChange);
        QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, onMapDispose);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapComplete);
        updateProcessor();
    }

    private static function onQuestComplete(param1:QuestEvent):void {
        updateProcessor();
        if (_completeAnimation == null) {
            _completeAnimation = new QuestCompleteAnimation();
        }
        if (_notShowAnimationArr.indexOf(param1.questId) == -1) {
            _completeAnimation.play();
        }
    }

    private static function onQuestChange(param1:QuestEvent):void {
        updateProcessor();
    }

    private static function updateProcessor():void {
        var _loc2_:QuestProcessor = null;
        var _loc3_:Quest = null;
        var _loc4_:int = 0;
        var _loc1_:Vector.<Quest> = QuestManager.getQuestListByStatus(QuestStatus.ACCEPTABLE).concat(QuestManager.getQuestListByStatus(QuestStatus.IN_PROGRESS));
        for each(_loc3_ in _loc1_) {
            if (!_map.containsKey(_loc3_.id)) {
                _loc2_ = createProcessor(_loc3_);
                _loc2_.init();
                _map.add(_loc3_.id, _loc2_);
            }
        }
        for each(_loc4_ in _map.getKeys()) {
            if (!containsQuestId(_loc1_, _loc4_)) {
                _loc2_ = _map.getValue(_loc4_);
                _loc2_.dispose();
                _map.remove(_loc4_);
            }
        }
    }

    private static function containsQuestId(param1:Vector.<Quest>, param2:int):Boolean {
        var _loc3_:Quest = null;
        for each(_loc3_ in param1) {
            if (_loc3_.id == param2) {
                return true;
            }
        }
        return false;
    }

    private static function createProcessor(param1:Quest):QuestProcessor {
        var _loc2_:Class = null;
        try {
            _loc2_ = ApplicationDomain.currentDomain.getDefinition("com.taomee.seer2.app.processor.quest.QuestProcessor_" + param1.id) as Class;
        } catch (e:Error) {
        }
        if (_loc2_ == null) {
            return new QuestProcessor(param1);
        }
        return QuestProcessor(new _loc2_(param1));
    }

    private static function onMapComplete(param1:SceneEvent):void {
        var _loc2_:int = 0;
        for each(_loc2_ in _map.getKeys()) {
            if (QuestManager.getQuest(_loc2_).getRelatedMapIds().indexOf(SceneManager.active.mapResourceID) != -1) {
                (_map.getValue(_loc2_) as QuestProcessor).processMapComplete();
            }
        }
    }

    private static function onMapDispose(param1:SceneEvent):void {
        var _loc2_:QuestProcessor = null;
        if (SceneManager.active == null) {
            return;
        }
        for each(_loc2_ in _map.getValues()) {
            _loc2_.processMapDispose();
        }
    }
}
}
