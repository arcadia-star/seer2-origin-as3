package com.taomee.seer2.app.processor.quest.handler.main.quest31 {
import com.taomee.seer2.app.guide.manager.GuideManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class ArrowsCompleteQuestNew {

    private static var _arrows:MovieClip;

    private static var _cookback:Function;


    public function ArrowsCompleteQuestNew() {
        super();
    }

    public static function setupArrows(param1:Function = null):void {
        if (_arrows) {
            endArrows();
        }
        _cookback = param1;
        _arrows = UIManager.getMovieClip("Arrows_UI");
        _arrows.x = 831;
        _arrows.y = 471;
        LayerManager.stage.addChild(_arrows);
        initEvent();
    }

    private static function initEvent():void {
        _arrows.buttonMode = true;
    }

    public static function onArrows(param1:Function):void {
        _cookback = param1;
        if (QuestManager.isCanAccepted(53) || QuestManager.isAccepted(53)) {
            nextQuest(53);
            return;
        }
    }

    private static function nextQuest(param1:uint):void {
        if (QuestManager.isCanAccepted(param1)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(param1);
        }
        if (QuestManager.isStepComplete(param1, 1) == false) {
            if (param1 == 31) {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            } else if (param1 == 53) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            }
            QuestManager.completeStep(param1, 1);
        }
        if (QuestManager.isStepComplete(param1, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(param1, 2);
        }
        if (QuestManager.isStepComplete(param1, 3) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(param1, 3);
        }
        if (QuestManager.isStepComplete(param1, 4) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(param1, 4);
        }
        if (QuestManager.isStepComplete(param1, 5) == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(param1, 5);
        }
    }

    private static function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, onAccept);
        nextQuest(param1.questId);
    }

    private static function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
        nextQuest(param1.questId);
    }

    private static function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, onStepComplete);
        GuideManager.instance.pause();
        endArrows();
        if (param1.questId == 53) {
        }
    }

    public static function endArrows():void {
        if (_cookback != null) {
            _cookback();
            _cookback = null;
        }
        if (_arrows) {
            _arrows.removeEventListener(MouseEvent.CLICK, onArrows);
            DisplayUtil.removeForParent(_arrows);
            _arrows = null;
        }
    }
}
}
