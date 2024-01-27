package com.taomee.seer2.app.processor.quest.handler.activity.quest30014 {
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
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_30014_770 extends QuestMapHandler {


    private var _npc:MovieClip;

    public function QuestMapHandler_30014_770(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && false == QuestManager.isStepComplete(_quest.id, 2)) {
            this.createTemporaryNpc();
        }
    }

    private function createTemporaryNpc():void {
        this._npc = _processor.resLib.getMovieClip("CloudEtes_30014");
        this._npc.buttonMode = true;
        _processor.mapModel.front.addChild(this._npc);
        this._npc.addEventListener(MouseEvent.CLICK, this.playMovie);
        _processor.showMouseHintAt(500, 230);
    }

    private function playMovie(param1:MouseEvent):void {
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        _processor.mapModel.front.removeChild(this._npc);
        _processor.hideMouseClickHint();
        mc = _processor.resLib.getMovieClip("EtesTalkDialog");
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            LayerManager.resetOperation();
            LayerManager.topLayer.removeChild(mc);
            showDialog(null);
        });
    }

    private function showDialog(param1:Event):void {
        var event:Event = param1;
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "看来这次真的要大乱斗了！为什么明明是手足却要自相残杀呢...另外几个伊特呢？"]], ["（他们似乎都集合在沙爪氏族）"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Complete);
            QuestManager.completeStep(_quest.id, 2);
        }]);
    }

    private function onStep2Complete(param1:Event):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        SceneManager.changeScene(SceneType.LOBBY, 320);
    }
}
}
