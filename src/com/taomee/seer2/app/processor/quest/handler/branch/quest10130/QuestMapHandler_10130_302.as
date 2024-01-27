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

public class QuestMapHandler_10130_302 extends QuestMapHandler {


    private var _mc_3:MovieClip;

    private var _dialog3:MovieClip;

    private var _zhi:MovieClip;

    public function QuestMapHandler_10130_302(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.playAnimation();
        }
    }

    private function playAnimation():void {
        this._mc_3 = _processor.resLib.getMovieClip("step3");
        LayerManager.topLayer.addChild(this._mc_3);
        MovieClipUtil.playMc(this._mc_3, 2, this._mc_3.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc_3);
            _processor.showMouseHintAt(538, 453);
            _zhi = _processor.resLib.getMovieClip("zhi3");
            _map.content.addChild(_zhi);
            _zhi.buttonMode = true;
            _zhi.addEventListener(MouseEvent.CLICK, onZhi);
        }, true);
    }

    private function onZhi(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._zhi);
        _processor.hideMouseClickHint();
        this._dialog3 = _processor.resLib.getMovieClip("dialog3");
        LayerManager.topLayer.addChild(this._dialog3);
        MovieClipUtil.playMc(this._dialog3, 2, this._dialog3.totalFrames, function ():void {
            DisplayUtil.removeForParent(_dialog3);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(_quest.id, 3);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        _processor.showMouseHintAt(109, 104);
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._zhi);
        DisplayUtil.removeForParent(this._mc_3);
        DisplayUtil.removeForParent(this._dialog3);
        this._mc_3 = null;
        this._zhi = null;
        this._dialog3 = null;
    }
}
}
