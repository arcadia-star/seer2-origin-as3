package com.taomee.seer2.app.processor.quest.handler.branch.quest10191 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10191_980 extends CandlePelayHandler {


    public function QuestMapHandler_10191_980(param1:QuestProcessor) {
        super(param1);
        _questIndex = 12;
        _x = 659;
        _y = 429;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(641, 251);
    }

    override protected function getAward():void {
        this.playFullMovie();
    }

    private function playFullMovie():void {
        MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10191_1.swf"), function ():void {
            DisplayUtil.removeForParent(_candleMc);
            if (Boolean(_map) && Boolean(_map.content["mikaNpc"])) {
                (_map.content["mikaNpc"] as MovieClip).visible = true;
            }
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(_quest.id, 1);
        });
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
