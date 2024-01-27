package com.taomee.seer2.app.processor.quest.handler.story.quest13 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;

import flash.display.MovieClip;

public class QuestMapHandler_13_5106 extends QuestMapHandler {


    private var _mc_8:MovieClip;

    public function QuestMapHandler_13_5106(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.addMouseClickHint();
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.initMC();
        }
    }

    private function initMC():void {
        this._mc_8 = _processor.resLib.getMovieClip("mc_8");
        this._mc_8.x = 441;
        this._mc_8.y = 308;
        _map.front.addChild(this._mc_8);
        MovieClipUtil.playMc(this._mc_8, 1, this._mc_8.totalFrames, function ():void {
            QuestManager.completeStep(_quest.id, 3);
            if (!QuestManager.isCompletable(_quest.id)) {
                _processor.showMouseHintAt(113, 277);
            }
        }, true);
    }

    private function addMouseClickHint():void {
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isCompletable(_quest.id)) {
            _processor.showMouseHintAt(113, 277);
        }
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        if (this._mc_8) {
            if (this._mc_8.parent) {
                _map.front.removeChild(this._mc_8);
            }
        }
    }
}
}
