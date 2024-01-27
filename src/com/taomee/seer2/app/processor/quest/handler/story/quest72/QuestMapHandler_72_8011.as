package com.taomee.seer2.app.processor.quest.handler.story.quest72 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.processor.quest.handler.story.quest68.QuestPlayMC;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_72_8011 extends QuestMapHandler {

    private static var isOpen:Boolean;


    private var _mc1:MovieClip;

    public function QuestMapHandler_72_8011(param1:QuestProcessor) {
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
                    DisplayUtil.removeForParent(_mc1);
                    var _loc1_:Object = new Object();
                    _loc1_.isNew = 1;
                    ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"), "正在打开...", _loc1_);
                });
            }, true);
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc1);
        isOpen = false;
        super.processMapDispose();
    }
}
}
