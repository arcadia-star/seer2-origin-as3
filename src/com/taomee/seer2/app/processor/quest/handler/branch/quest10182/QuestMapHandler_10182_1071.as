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

public class QuestMapHandler_10182_1071 extends QuestMapHandler {


    private var _chips:MovieClip;

    private var _surpriseMark:AcceptableMark;

    public function QuestMapHandler_10182_1071(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initChips();
        }
    }

    private function initChips():void {
        this._chips = _processor.resLib.getMovieClip("mc0");
        _map.content.addChild(this._chips);
        this._chips.buttonMode = true;
        this._chips.addEventListener(MouseEvent.CLICK, this.onPickUpHandler);
        if (this._surpriseMark == null) {
            this._surpriseMark = new AcceptableMark();
        }
        this._surpriseMark.x = 855;
        this._surpriseMark.y = 431;
        SceneManager.active.mapModel.content.addChild(this._surpriseMark);
    }

    private function onPickUpHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "好奇怪的纸片，七零八落的，捡起来拼拼看。"]], ["拼起来看看。"], [function ():void {
            ModuleManager.addEventListener("SadanPuzzleGameOnePanel", "PuzzleGameOneSuccess", onSucessPuzzlePanel);
            ModuleManager.toggleModule(URLUtil.getAppModule("SadanPuzzleGameOnePanel"), "正在打开面板...");
        }]);
    }

    private function onSucessPuzzlePanel(param1:ModuleEvent):void {
        var evr:ModuleEvent = param1;
        ModuleManager.removeEventListener("SadanPuzzleGameOnePanel", "PuzzleGameOneSuccess", this.onSucessPuzzlePanel);
        if (this._chips) {
            DisplayUtil.removeForParent(this._chips);
        }
        if (this._surpriseMark) {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
        }
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10182_0"), function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "啊哦。碎纸片的故事就讲到了这里，看来故事还没有结束啊，我应该继续去找找。"]], [" 去别的地方看看。"], [function ():void {
                QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                QuestManager.accept(_quest.id);
            }]);
        }, true, false, 2);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 840);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._chips) {
            DisplayUtil.removeForParent(this._chips);
        }
        if (this._surpriseMark) {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
    }
}
}
