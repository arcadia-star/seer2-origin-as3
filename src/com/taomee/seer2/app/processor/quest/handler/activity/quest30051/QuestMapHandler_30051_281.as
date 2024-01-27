package com.taomee.seer2.app.processor.quest.handler.activity.quest30051 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.filter.ColorFilter;

public class QuestMapHandler_30051_281 extends QuestMapHandler {


    private var sceneMc:MovieClip;

    public function QuestMapHandler_30051_281(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        MonsterManager.hideAllMonster();
        if (QuestManager.isCanAccepted(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
            QuestManager.accept(_quest.id);
        }
        if (isNeedCompleteStep(1)) {
            this.next1();
        }
        if (isNeedCompleteStep(2)) {
            this.initStep2();
        }
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        this.next1();
    }

    private function next1():void {
        ActorManager.showRemoteActor = false;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30051_0"), function ():void {
            ColorFilter.setGrayscale(LayerManager.mapLayer);
            if (sceneMc) {
                DisplayObjectUtil.removeFromParent(sceneMc);
            }
            sceneMc = _processor.resLib.getMovieClip("Mc_30051_0");
            _map.content.addChild(sceneMc);
            MovieClipUtil.playMc(sceneMc, 1, sceneMc.totalFrames, function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                QuestManager.completeStep(30051, 1);
            });
        });
    }

    private function onStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        if (param1.stepId == 1) {
            this.initStep2();
        }
        if (param1.stepId == 2) {
            SceneManager.changeScene(SceneType.LOBBY, 240);
        }
    }

    private function initStep2():void {
        if (this.sceneMc) {
            DisplayObjectUtil.removeFromParent(this.sceneMc);
        }
        if (LayerManager.mapLayer.filters.length == 0) {
            ColorFilter.setGrayscale(LayerManager.mapLayer);
        }
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30051_1"), function ():void {
            sceneMc = _processor.resLib.getMovieClip("Mc_30051_1");
            _map.content.addChild(sceneMc);
            MovieClipUtil.playMc(sceneMc, 1, sceneMc.totalFrames, function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                QuestManager.completeStep(30051, 2);
            });
        });
    }

    override public function processMapDispose():void {
        ActorManager.showRemoteActor = true;
        MonsterManager.showAllMonster();
        super.processMapDispose();
        LayerManager.mapLayer.filters = [];
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }
}
}
