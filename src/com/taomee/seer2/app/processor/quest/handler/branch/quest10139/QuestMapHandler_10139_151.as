package com.taomee.seer2.app.processor.quest.handler.branch.quest10139 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10139_151 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_10139_151(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.addFlower();
        }
    }

    private function addFlower():void {
        this._mc_0 = _processor.resLib.getMovieClip("flower1");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onClickFlowerHandler);
    }

    private function onClickFlowerHandler(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "哈哈，草目花被我找到了，赶快回去找神目酋长吧！"]], ["Go！go！go！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Handler);
            QuestManager.completeStep(_quest.id, 2);
        }]);
    }

    private function onStep2Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Handler);
        SceneManager.changeScene(SceneType.LOBBY, 110);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Handler);
    }
}
}
