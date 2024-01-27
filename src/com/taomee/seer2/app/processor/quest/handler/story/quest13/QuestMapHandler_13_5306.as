package com.taomee.seer2.app.processor.quest.handler.story.quest13 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_13_5306 extends QuestMapHandler {


    private var _mc_9:MovieClip;

    public function QuestMapHandler_13_5306(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.addMouseClickHint();
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4)) {
            this.initMC();
        }
    }

    private function initMC():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("13_1"), function ():void {
            _mc_9 = _processor.resLib.getMovieClip("mc_9");
            _mc_9.x = 663;
            _mc_9.y = 440;
            _map.front.addChild(_mc_9);
            MovieClipUtil.playMc(_mc_9, 1, _mc_9.totalFrames, function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "怎么办……怎么办……先找到那个捣蛋鬼再说！这件事可不得了……"]], ["（难道在实验禁地？去看看吧！）"], [function ():void {
                    QuestManager.completeStep(_quest.id, 4);
                    if (!QuestManager.isCompletable(_quest.id)) {
                        _processor.showMouseHintAt(826, 471);
                    }
                }]);
            }, true);
        });
    }

    private function addMouseClickHint():void {
        if (QuestManager.isStepComplete(_quest.id, 4) && !QuestManager.isCompletable(_quest.id)) {
            _processor.showMouseHintAt(826, 471);
        }
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        if (this._mc_9) {
            if (this._mc_9.parent) {
                _map.front.removeChild(this._mc_9);
            }
        }
    }
}
}
