package com.taomee.seer2.app.processor.quest.handler.branch.quest10182 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10182_840 extends QuestMapHandler {


    private var _chips:MovieClip;

    private var _surpriseMark:AcceptableMark;

    public function QuestMapHandler_10182_840(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initChips();
        }
    }

    private function initChips():void {
        this._chips = _processor.resLib.getMovieClip("mc1");
        _map.content.addChild(this._chips);
        this._chips.buttonMode = true;
        this._chips.addEventListener(MouseEvent.CLICK, this.onPickUpHandler);
        if (this._surpriseMark == null) {
            this._surpriseMark = new AcceptableMark();
        }
        this._surpriseMark.x = 604;
        this._surpriseMark.y = 370;
        SceneManager.active.mapModel.content.addChild(this._surpriseMark);
    }

    private function onPickUpHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "哈哈，又找到了一个纸片，赶紧打开看看撒旦的故事。"]], ["拼拼纸片"], [function ():void {
            ModuleManager.addEventListener("SadanPuzzleGameTwoPanel", "PuzzleGameTwoSuccess", onSucessPuzzlePanel);
            ModuleManager.toggleModule(URLUtil.getAppModule("SadanPuzzleGameTwoPanel"), "正在打开面板...");
        }]);
    }

    private function onSucessPuzzlePanel(param1:ModuleEvent):void {
        var evr:ModuleEvent = param1;
        ModuleManager.removeEventListener("SadanPuzzleGameTwoPanel", "PuzzleGameTwoSuccess", this.onSucessPuzzlePanel);
        if (this._chips) {
            DisplayUtil.removeForParent(this._chips);
        }
        if (this._surpriseMark) {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
        }
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10182_1"), function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "撒旦就这样被带走了？接下来的撒旦会发生什么呢？不行，我还得继续找下去，一定要探个究竟。"]], ["走，继续寻找。"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteOneHandler);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        }, true, false, 2);
    }

    private function onCompleteOneHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteOneHandler);
        SceneManager.changeScene(SceneType.LOBBY, 40);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._chips) {
            DisplayUtil.removeForParent(this._chips);
        }
        if (this._surpriseMark) {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteOneHandler);
    }
}
}
