package com.taomee.seer2.app.processor.quest.handler.branch.quest10223 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10223_80154 extends QuestMapHandler {


    private var _mc0:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_10223_80154(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10223) && QuestManager.isStepComplete(10223, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc0 = _processor.resLib.getMovieClip("mc0");
        _map.front.addChild(this._mc0);
        MovieClipUtil.playMc(this._mc0, 2, this._mc0.totalFrames, function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(10223, 1);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 142);
    }

    override public function processMapDispose():void {
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc0);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
