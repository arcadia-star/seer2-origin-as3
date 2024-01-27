package com.taomee.seer2.app.processor.quest.handler.branch.quest10137 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10137_133 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_10137_133(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 5) && QuestManager.isStepComplete(_quest.id, 6) == false) {
            this.addMan();
        }
    }

    private function addMan():void {
        _processor.showMouseHintAt(172, 339);
        this._mc_0 = _processor.resLib.getMovieClip("man");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onPlayFullHandler);
    }

    private function onPlayFullHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10137_1"), function ():void {
            addNewMan();
        }, false, false, 2);
    }

    private function addNewMan():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("man1");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onManTalkHandler);
    }

    private function onManTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(168, "安德", [[0, "我永远活在黑暗的世界里，是你让我重拾了色彩！谢谢！如果你愿意和我一起完成这个八音盒，我想我将把它作为礼物赠送给你！"]], ["（好耶YE！）"], [function ():void {
            SoundManager.enabled = false;
            ModuleManager.toggleModule(URLUtil.getAppModule("MusicBoxPanel"), "正在打开面板...");
            ModuleManager.addEventListener("MusicBoxPanel", "MusicBoxRight", onRightHandler);
        }]);
    }

    private function onRightHandler(param1:ModuleEvent):void {
        var evt:ModuleEvent = param1;
        SoundManager.enabled = true;
        NpcDialog.show(168, "安德", [[0, "好！就是这个！音乐可以让人忘记忧伤！我就把它送给你吧！"]], ["忧伤？送给兰德去吧！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep6Handler);
            QuestManager.completeStep(_quest.id, 6);
        }]);
    }

    private function onStep6Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep6Handler);
        SceneManager.changeScene(SceneType.LOBBY, 320);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep6Handler);
    }
}
}
