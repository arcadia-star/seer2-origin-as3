package com.taomee.seer2.app.processor.quest.handler.branch.quest10130 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10130_230 extends QuestMapHandler {


    private var _mc_5:MovieClip;

    private var _dialog5:MovieClip;

    private var _zhi:MovieClip;

    public function QuestMapHandler_10130_230(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.playAnimation();
        }
    }

    private function playAnimation():void {
        this._mc_5 = _processor.resLib.getMovieClip("step5");
        LayerManager.topLayer.addChild(this._mc_5);
        MovieClipUtil.playMc(this._mc_5, 2, this._mc_5.totalFrames, function ():void {
            _processor.showMouseHintAt(410, 456);
            _zhi = _processor.resLib.getMovieClip("zhi5");
            _map.content.addChild(_zhi);
            _zhi.buttonMode = true;
            _zhi.addEventListener(MouseEvent.CLICK, onZhi);
        }, true);
    }

    private function onZhi(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        _processor.hideMouseClickHint();
        DisplayUtil.removeForParent(this._zhi);
        this._dialog5 = _processor.resLib.getMovieClip("dialog5");
        LayerManager.topLayer.addChild(this._dialog5);
        MovieClipUtil.playMc(this._dialog5, 2, this._dialog5.totalFrames, function ():void {
            DisplayUtil.removeForParent(_dialog5);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(_quest.id, 5);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        _processor.showMouseHintAt(401, 225);
        this._mc_5.buttonMode = true;
        this._mc_5.addEventListener(MouseEvent.CLICK, this.onGoto);
    }

    private function onGoto(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 340);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        _processor.hideMouseClickHint();
        DisplayUtil.removeForParent(this._zhi);
        DisplayUtil.removeForParent(this._mc_5);
        DisplayUtil.removeForParent(this._dialog5);
        this._mc_5 = null;
        this._zhi = null;
        this._dialog5 = null;
    }
}
}
