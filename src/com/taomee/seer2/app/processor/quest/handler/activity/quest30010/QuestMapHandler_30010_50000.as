package com.taomee.seer2.app.processor.quest.handler.activity.quest30010 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_30010_50000 extends QuestMapHandler {


    private var mikaMc:MovieClip;

    private var diaMc:MovieClip;

    public function QuestMapHandler_30010_50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1) && SceneManager.active && SceneManager.active.mapID == ActorManager.actorInfo.id) {
            this.playMikaMc();
        }
    }

    override public function processMapDispose():void {
        if (this.mikaMc) {
            _map.front.removeChild(this.mikaMc);
        }
        if (Boolean(this.diaMc) && Boolean(LayerManager.topLayer.contains(this.diaMc))) {
            LayerManager.topLayer.removeChild(this.diaMc);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep1);
        super.processMapDispose();
    }

    private function playMikaMc():void {
        this.mikaMc = _processor.resLib.getMovieClip("mikaMc");
        this.mikaMc.x = 370;
        this.mikaMc.y = 315;
        _map.front.addChild(this.mikaMc);
        MovieClipUtil.playMc(this.mikaMc, 1, this.mikaMc.totalFrames, function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "米……咔……米米米……咔？难道是我眼花了？"]], ["没可能啊……我真的有看到！"], [function ():void {
                diaMc = _processor.resLib.getMovieClip("Dia30010_0");
                LayerManager.topLayer.addChild(diaMc);
                MovieClipUtil.playMc(diaMc, 1, diaMc.totalFrames, function ():void {
                    LayerManager.topLayer.removeChild(diaMc);
                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "先不管米咔了……救人要紧……"]], ["（赶往地月氏族主城）"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep1);
                        QuestManager.completeStep(_quest.id, 1);
                    }]);
                }, true);
            }]);
        }, true);
    }

    private function completeStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep1);
            SceneManager.changeScene(SceneType.LOBBY, 470);
        }
    }
}
}
