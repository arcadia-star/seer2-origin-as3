package com.taomee.seer2.app.processor.quest.handler.branch.quest10126 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.home.garbage.HomeGarbage;
import com.taomee.seer2.app.home.garbage.HomeGarbageHelper;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10126_50000 extends QuestMapHandler {


    private var _resourceLoader:ResourceLibraryLoader;

    private var garbageNum:int;

    private var clearNum:int;

    private var _recycleMc:MovieClip;

    private var _resLib:ResourceLibrary;

    public function QuestMapHandler_10126_50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4) && Boolean(DateUtil.isInTime(new Date(2012, 8, 23, 23), new Date(2012, 8, 25, 23)))) {
            this.initStep4();
        }
    }

    private function initStep4():void {
        var _loc2_:DisplayObject = null;
        var _loc1_:int = 0;
        while (_loc1_ < _map.content.numChildren) {
            _loc2_ = _map.content.getChildAt(_loc1_);
            if (_loc2_ is HomeGarbage) {
                DisplayObjectUtil.removeFromParent(_loc2_);
            }
            _loc1_++;
        }
        this._resourceLoader = new ResourceLibraryLoader(URLUtil.getRes("common/home/garbage" + URLUtil.POSTFIX_SWF));
        this._resourceLoader.getLib(this.handlerGarbage);
    }

    private function handlerGarbage(param1:ResourceLibrary):void {
        var _loc3_:HomeGarbage = null;
        this._resLib = param1;
        this.garbageNum = Math.random() * 3 + 3;
        HomeGarbageHelper.prepare();
        var _loc2_:int = 0;
        while (_loc2_ < this.garbageNum) {
            _loc3_ = new HomeGarbage(HomeGarbageHelper.getGarbageData(), param1);
            _map.content.addChild(_loc3_);
            _loc3_.addEventListener(MouseEvent.CLICK, this.clearGarbage, false, 1000);
            _loc2_++;
        }
    }

    private function clearGarbage(param1:MouseEvent):void {
        var target:HomeGarbage = null;
        var event:MouseEvent = param1;
        event.stopImmediatePropagation();
        target = event.target as HomeGarbage;
        this._recycleMc = this._resLib.getMovieClip("recyle");
        target.addChild(this._recycleMc);
        MovieClipUtil.playMc(this._recycleMc, 1, this._recycleMc.totalFrames, function ():void {
            ++clearNum;
            DisplayObjectUtil.removeFromParent(target);
            if (clearNum == garbageNum) {
                NpcDialog.show(405, "阿宝", [[0, "打扫得好干净啊，哇哈哈，" + ActorManager.actorInfo.nick + "开心吧！"]], ["嗯嗯，谢谢阿宝。"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                    QuestManager.completeStep(_quest.id, 4);
                }]);
            }
        });
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            SceneManager.changeScene(SceneType.LOBBY, 70);
        }
    }
}
}
