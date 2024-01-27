package com.taomee.seer2.app.processor.quest.handler.story.quest15 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_15_470 extends QuestMapHandler {


    private var _mc_5:MovieClip;

    private var _mc_6:MovieClip;

    public function QuestMapHandler_15_470(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.showAnimation();
        }
    }

    private function showAnimation():void {
        this._mc_5 = _processor.resLib.getMovieClip("mc_5");
        _map.front.addChild(this._mc_5);
        MovieClipUtil.playMc(this._mc_5, 2, this._mc_5.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc_5);
            _mc_5 = null;
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("15_0"), function ():void {
                _mc_6 = _processor.resLib.getMovieClip("mc_6");
                _map.front.addChild(_mc_6);
                MovieClipUtil.playMc(_mc_6, 2, _mc_6.totalFrames, function ():void {
                    DisplayUtil.removeForParent(_mc_6);
                    _mc_6 = null;
                    QuestManager.completeStep(_quest.id, 4);
                }, true);
            }, false);
        }, true);
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc_5);
        this._mc_5 = null;
        DisplayUtil.removeForParent(this._mc_6);
        this._mc_6 = null;
    }
}
}
