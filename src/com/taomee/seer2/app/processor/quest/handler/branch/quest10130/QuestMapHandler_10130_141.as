package com.taomee.seer2.app.processor.quest.handler.branch.quest10130 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10130_141 extends QuestMapHandler {


    private var _mc_2:MovieClip;

    private var _dialog2:MovieClip;

    private var _zhi:MovieClip;

    public function QuestMapHandler_10130_141(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.playAnimation();
        }
    }

    private function playAnimation():void {
        this._mc_2 = _processor.resLib.getMovieClip("step2");
        LayerManager.topLayer.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 2, this._mc_2.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc_2);
            _processor.showMouseHintAt(597, 434);
            _zhi = _processor.resLib.getMovieClip("zhi2");
            _map.content.addChild(_zhi);
            _zhi.buttonMode = true;
            _zhi.addEventListener(MouseEvent.CLICK, onZhi);
        }, true);
    }

    private function onZhi(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._zhi);
        _processor.hideMouseClickHint();
        this._dialog2 = _processor.resLib.getMovieClip("dialog2");
        LayerManager.topLayer.addChild(this._dialog2);
        MovieClipUtil.playMc(this._dialog2, 2, this._dialog2.totalFrames, function ():void {
            DisplayUtil.removeForParent(_dialog2);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(_quest.id, 2);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        _processor.showMouseHintAt(765, 449);
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._zhi);
        DisplayUtil.removeForParent(this._mc_2);
        DisplayUtil.removeForParent(this._dialog2);
        this._mc_2 = null;
        this._zhi = null;
        this._dialog2 = null;
    }
}
}
