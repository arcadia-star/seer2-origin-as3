package com.taomee.seer2.app.processor.quest.handler.story.quest45 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_45_590 extends QuestMapHandler {


    private var fourArms:MovieClip;

    public function QuestMapHandler_45_590(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        this.fourArms = _processor.resLib.getMovieClip("FourArms");
        _map.front.addChild(this.fourArms);
        MovieClipUtil.playMc(this.fourArms, 1, this.fourArms.totalFrames, function ():void {
            NpcDialog.show(114, "蒂芙伦", [[2, "你！你最好不要接近王座……！！"]], [" ？？？我好像听见了什么……"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("45_1"), function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                    QuestManager.completeStep(_quest.id, 2);
                }, true, false, 2);
            }]);
        }, true);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 45) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            if (this.fourArms) {
                if (_map.front.contains(this.fourArms)) {
                    _map.front.removeChild(this.fourArms);
                }
            }
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.fourArms) {
            if (_map.front.contains(this.fourArms)) {
                _map.front.removeChild(this.fourArms);
            }
        }
        super.processMapDispose();
    }
}
}
