package com.taomee.seer2.app.processor.quest.handler.story.quest55 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_55_850 extends QuestMapHandler {


    public function QuestMapHandler_55_850(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(_quest.id)) {
            DialogPanel.addCloseEventListener(this.onCustomReply);
        }
    }

    private function onCustomReply(param1:DialogCloseEvent):void {
        DialogPanel.removeCloseEventListener(this.onCustomReply);
        if (param1.params == "55_0") {
            this.playSceneMovie();
        }
    }

    private function playSceneMovie():void {
        var mc:MovieClip = null;
        mc = _processor.resLib.getMovieClip("LightCross");
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            LayerManager.resetOperation();
            LayerManager.topLayer.removeChild(mc);
            QuestManager.addEventListener(QuestEvent.ACCEPT, acceptHandler);
            QuestManager.accept(_quest.id);
        });
    }

    private function acceptHandler(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.acceptHandler);
            SceneManager.changeScene(SceneType.LOBBY, 880);
        }
    }
}
}
