package com.taomee.seer2.app.processor.quest.handler.main.quest8 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;

import flash.display.MovieClip;

public class QuestMapHandler_8_201 extends QuestMapHandler {


    private var _stepAnimation:MovieClip;

    public function QuestMapHandler_8_201(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4)) {
            this.extractAssets();
            this.processStep4();
        }
    }

    private function extractAssets():void {
        this._stepAnimation = _map.content["quest_8"];
    }

    private function processStep4():void {
        DialogPanel.showForSimple(11, "多罗", [[4, "老大！我……我要先找到小海马！"]], "可是会有危险……", function ():void {
            MovieClipUtil.playMc(_stepAnimation, 2, _stepAnimation.totalFrames, function ():void {
                DialogPanel.showForSimple(NpcUtil.getSeerNpcId(), "我", [[0, "海……海马！！小海马！！！<font color=\'#ffcc00\'>（附近可能有进去的机关）</font>"]], "多罗你慢点！", function ():void {
                    QuestManager.completeStep(_quest.id, 4);
                });
            }, true);
        });
    }

    override public function processMapDispose():void {
    }
}
}
