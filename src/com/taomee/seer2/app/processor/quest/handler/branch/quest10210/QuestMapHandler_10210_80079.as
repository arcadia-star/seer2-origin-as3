package com.taomee.seer2.app.processor.quest.handler.branch.quest10210 {
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10210_80079 extends QuestMapHandler {


    private var _mc3:MovieClip;

    public function QuestMapHandler_10210_80079(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(10210, 2) && QuestManager.isStepComplete(10210, 3) == false) {
            this.initQuest3();
        }
    }

    private function initQuest3():void {
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        this._mc3.buttonMode = true;
        _map.front.addChild(this._mc3);
        this._mc3.addEventListener(MouseEvent.CLICK, this.onMC3);
    }

    private function onMC3(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10210_2"), function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(10210, 3);
        }, true, true, 2);
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ServerMessager.addMessage("获得了材料A");
        SceneManager.changeScene(SceneType.LOBBY, 3811);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        super.processMapDispose();
        if (this._mc3) {
            this._mc3.removeEventListener(MouseEvent.CLICK, this.onMC3);
            DisplayUtil.removeForParent(this._mc3);
        }
    }
}
}
