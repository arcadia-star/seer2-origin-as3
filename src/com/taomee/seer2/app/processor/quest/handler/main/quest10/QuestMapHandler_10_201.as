package com.taomee.seer2.app.processor.quest.handler.main.quest10 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_10;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10_201 extends QuestMapHandler {


    private var _stepAnimation1:MovieClip;

    public function QuestMapHandler_10_201(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._stepAnimation1 = _processor.getMcFromLib("mc_201_1");
        if (_quest.isStepCompletable(3)) {
            if (QuestProcessor_10(_processor).petStep == 2) {
                _map.content.addChild(this._stepAnimation1);
                MovieClipUtil.playMc(this._stepAnimation1, 1, this._stepAnimation1.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_stepAnimation1);
                    QuestProcessor_10(_processor).addPetStep();
                    _processor.showMouseHintAt(550, 250);
                }, true);
            } else if (QuestProcessor_10(_processor).petStep > 2) {
                _processor.showMouseHintAt(550, 250);
            }
        } else if (_quest.isStepCompletable(6)) {
            _processor.showMouseHintAt(850, 464);
        }
    }
}
}
