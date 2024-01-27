package com.taomee.seer2.app.processor.quest.handler.story.quest71 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.ResContentLibrary;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_71_20 extends QuestMapHandler {

    private static var isOpen:Boolean;


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    public function QuestMapHandler_71_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isOpen) {
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false && QuestProcessor_68.questStatus == _quest.id) {
            isOpen = true;
            this.startAggraisal();
        }
    }

    private function startAggraisal():void {
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        LayerManager.topLayer.addChild(this._mc1);
        ResContentLibrary.setScaleValue(this._mc1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc1);
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(71, 1);
        }, true);
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        DisplayUtil.removeForParent(this._mc1);
        ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"), "正在打开...");
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        DisplayUtil.removeForParent(this._mc1);
        super.processMapDispose();
        isOpen = false;
    }
}
}
