package com.taomee.seer2.app.processor.quest.handler.branch.quest10183 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10183_50000 extends QuestMapHandler {


    private var _ligthMc:MovieClip;

    private const POS:Vector.<int> = Vector.<int>([313, 238]);

    public function QuestMapHandler_10183_50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.handle1();
        } else if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.handle2();
        }
    }

    private function handle1():void {
        this._ligthMc = _processor.resLib.getMovieClip("npc");
        this._ligthMc.x = this.POS[0];
        this._ligthMc.y = this.POS[1];
        this._ligthMc["mark"].visible = true;
        this._ligthMc.buttonMode = true;
        _map.content.addChild(this._ligthMc);
        this._ligthMc.addEventListener(MouseEvent.CLICK, this.onMcClick);
    }

    private function onMcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._ligthMc.removeEventListener(MouseEvent.CLICK, this.onMcClick);
        DisplayUtil.removeForParent(this._ligthMc);
        QuestManager.accept(_quest.id);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10183_0"), function ():void {
            _ligthMc.removeEventListener(MouseEvent.CLICK, onMcClick);
            NpcDialog.show(400, "赛尔", [[0, "纸条上写着模糊4个字“神之猎手”，背面还画着一幅地图，难道梦中看到的东西是真的？"]], ["赶快去看看吧！"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneComplete);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        }, true, true, 2);
    }

    private function onStepOneComplete(param1:QuestEvent):void {
        this.disPose();
        SceneManager.changeScene(SceneType.LOBBY, 740);
    }

    private function handle2():void {
        this._ligthMc = _processor.resLib.getMovieClip("npc");
        this._ligthMc.x = this.POS[0];
        this._ligthMc.y = this.POS[1];
        this._ligthMc["mark"].visible = true;
        this._ligthMc.buttonMode = true;
        _map.content.addChild(this._ligthMc);
        this._ligthMc.addEventListener(MouseEvent.CLICK, this.onMcClick1);
    }

    private function onMcClick1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(400, "赛尔", [[0, "纸条上写着模糊4个字“神之猎手”，背面还画着一幅地图，难道梦中的看到的东西是真的？"]], ["赶快去看看吧！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneComplete);
            QuestManager.completeStep(_quest.id, 1);
            disPose();
            SceneManager.changeScene(SceneType.LOBBY, 740);
        }]);
    }

    private function disPose():void {
        if (this._ligthMc) {
            this._ligthMc.removeEventListener(MouseEvent.CLICK, this.onMcClick);
            this._ligthMc.removeEventListener(MouseEvent.CLICK, this.onMcClick1);
            DisplayUtil.removeForParent(this._ligthMc);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneComplete);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        this.disPose();
    }
}
}
