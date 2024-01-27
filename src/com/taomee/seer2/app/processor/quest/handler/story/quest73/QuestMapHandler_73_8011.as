package com.taomee.seer2.app.processor.quest.handler.story.quest73 {
import com.taomee.seer2.app.controls.ToolbarEvent;
import com.taomee.seer2.app.controls.ToolbarEventDispatcher;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.processor.quest.handler.story.quest68.QuestPlayMC;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.ResContentLibrary;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_73_8011 extends QuestMapHandler {

    private static var isOpen:Boolean;


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    public function QuestMapHandler_73_8011(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isOpen) {
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false && QuestProcessor_68.questStatus == _quest.id) {
            isOpen = true;
            this._mc1 = _processor.resLib.getMovieClip("mc1");
            LayerManager.topLayer.addChild(this._mc1);
            MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
                QuestPlayMC.playMC(_mc1, function ():void {
                    next1();
                });
            }, true);
        }
    }

    private function next1():void {
        ToolbarEventDispatcher.addEventListener(ToolbarEvent.PAGE_CHANGE, this.onChange);
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        this._mc2.mouseChildren = false;
        this._mc2.mouseEnabled = false;
        ResContentLibrary.setScaleValue(this._mc2);
        LayerManager.topLayer.addChild(this._mc2);
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        ResContentLibrary.setScaleValue(this._mc3);
        this._mc3.mouseChildren = false;
        this._mc3.mouseEnabled = false;
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    private function onChange(param1:ToolbarEvent):void {
        if (param1.typeStr == "NonoInput") {
            if (param1.status) {
                DisplayUtil.removeForParent(this._mc2);
                LayerManager.topLayer.addChild(this._mc3);
            } else {
                DisplayUtil.removeForParent(this._mc3);
                LayerManager.topLayer.addChild(this._mc2);
            }
        } else if (param1.typeStr == "NewVipPanel") {
            ToolbarEventDispatcher.removeEventListener(ToolbarEvent.PAGE_CHANGE, this.onChange);
            DisplayUtil.removeForParent(this._mc2);
            DisplayUtil.removeForParent(this._mc3);
            this._mc4 = _processor.resLib.getMovieClip("mc4");
            LayerManager.topLayer.addChild(this._mc4);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 73) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            DisplayUtil.removeForParent(this._mc4);
            ToolbarEventDispatcher.removeEventListener(ToolbarEvent.PAGE_CHANGE, this.onChange);
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mc3);
        DisplayUtil.removeForParent(this._mc4);
        isOpen = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ToolbarEventDispatcher.removeEventListener(ToolbarEvent.PAGE_CHANGE, this.onChange);
        super.processMapDispose();
    }
}
}
