package com.taomee.seer2.app.processor.quest.handler.story.quest69 {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.controls.widget.YueseNonoWidgetClick;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.processor.quest.handler.story.quest68.QuestPlayMC;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_69_20 extends QuestMapHandler {

    private static var isOpen:Boolean;


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    public function QuestMapHandler_69_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isOpen) {
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false && QuestProcessor_68.questStatus == _quest.id) {
            isOpen = true;
            ActiveCountManager.requestActiveCount(203857, function (param1:uint, param2:uint):void {
                var type:uint = param1;
                var count:uint = param2;
                if (count == 1) {
                    comQuest();
                } else {
                    _mc1 = _processor.resLib.getMovieClip("mc1");
                    LayerManager.topLayer.addChild(_mc1);
                    MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                        QuestPlayMC.playMC(_mc1, function ():void {
                            DisplayUtil.removeForParent(_mc1);
                            ModuleManager.addEventListener("MapPanel", ModuleEvent.SHOW, onModule);
                            ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO).visible = false;
                            _mc2 = _processor.resLib.getMovieClip("mc2");
                            LayerManager.topLayer.addChild(_mc2);
                        });
                    }, true);
                }
            });
        }
    }

    private function onModule(param1:ModuleEvent):void {
        if (param1.name == "MapPanel") {
            ModuleManager.removeEventListener("MapPanel", ModuleEvent.SHOW, this.onModule);
            DisplayUtil.removeForParent(this._mc2);
            ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO).visible = true;
        }
    }

    private function comQuest():void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(69, _quest.getCurrentOrNextStep().id);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        this.comQuest();
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"), "正在打开...");
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        isOpen = false;
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mc2);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }
}
}
