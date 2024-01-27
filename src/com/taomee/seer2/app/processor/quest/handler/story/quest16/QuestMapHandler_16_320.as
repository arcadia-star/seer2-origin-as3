package com.taomee.seer2.app.processor.quest.handler.story.quest16 {
import com.taomee.seer2.app.animationInteractive.Interactive_16;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_16_320 extends QuestMapHandler {


    private var _interactive_16:Interactive_16;

    private var _mc_6:MovieClip;

    public function QuestMapHandler_16_320(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.showMC6();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isComplete(_quest.id) == false) {
            this.addMouseClickHint();
        }
    }

    private function showMC6():void {
        this._mc_6 = _processor.resLib.getMovieClip("mc_6");
        _map.front.addChild(this._mc_6);
        this._mc_6.x = 597;
        this._mc_6.y = 227;
        this._mc_6.buttonMode = true;
        this._mc_6.addEventListener(MouseEvent.CLICK, this.onClickMC6);
    }

    private function onClickMC6(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(45, "吉吉导游", [[4, "我看到了！那个传说中浑身布条的怪物！！"]], ["你说话没有回音我还真不习惯……"], [function ():void {
            NpcDialog.show(45, "吉吉导游", [[4, "情急之下我抓了它一把，扯下了一些布条……一些布条……布条……希望对你有用！！"]], ["我看看？"], [function ():void {
                _interactive_16 = new Interactive_16();
                _interactive_16.setup("interactive_16", function (param1:Boolean):void {
                    var isSuccess:Boolean = param1;
                    if (isSuccess) {
                        NpcDialog.show(45, "吉吉导游", [[4, "这个是那个捣蛋鬼伊特吗……捣蛋鬼……伊特？！它们往淘米市场去了……了……了……"]], ["（是暗伊特！它果然四处捣乱！）"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStep);
                            QuestManager.completeStep(_quest.id, 2);
                        }]);
                    }
                });
            }]);
        }]);
    }

    private function onQuestStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        DisplayUtil.removeForParent(this._mc_6);
        this._mc_6 = null;
        this.addMouseClickHint();
    }

    private function addMouseClickHint():void {
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isCompletable(_quest.id)) {
            _processor.showMouseHintAt(805, 393);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        _processor.hideMouseClickHint();
        if (this._interactive_16) {
            this._interactive_16.dispose();
            this._interactive_16 = null;
        }
        DisplayUtil.removeForParent(this._mc_6);
        this._mc_6 = null;
    }
}
}
