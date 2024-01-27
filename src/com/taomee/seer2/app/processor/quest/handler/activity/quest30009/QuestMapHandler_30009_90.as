package com.taomee.seer2.app.processor.quest.handler.activity.quest30009 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_30009_90 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _markMc:MouseClickHintSprite;

    public function QuestMapHandler_30009_90(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.intMc();
        }
    }

    private function intMc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30009_0"), 1, [[1, 0]], function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Complete);
                QuestManager.completeStep(_quest.id, 1);
            });
        }, true);
    }

    private function onStep1Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
        this._markMc = new MouseClickHintSprite();
        _map.front.addChild(this._markMc);
        this._markMc.x = 78;
        this._markMc.y = 399;
    }

    override public function processMapDispose():void {
        this._mc_0 = null;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
    }
}
}
