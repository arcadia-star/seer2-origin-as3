package com.taomee.seer2.app.processor.quest.handler.main.quest4 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_4_133 extends QuestMapHandler {


    private var _leaf133:MovieClip;

    private var _quest4Step8Animation133:MovieClip;

    public function QuestMapHandler_4_133(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.isStepCompete(6)) {
            if (!_quest.isStepCompete(7)) {
                this.processStep7();
            } else if (!_quest.isStepCompete(8)) {
                this.processStep8();
            } else if (!_quest.isStepCompete(9)) {
                this.processStep9();
            }
        }
    }

    private function processStep7():void {
        DialogPanel.showForSimple(400, "我", [[0, "特鲁伊……特鲁伊……你听的到我在叫你吗？"]], "到处找找……", function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete7);
            QuestManager.completeStep(_quest.id, 7);
        });
    }

    private function onStepComplete7(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete7);
            this.processStep8();
        }
    }

    private function processStep8():void {
        this._leaf133 = _map.libManager.getMovieClip("quest4Leaf");
        this._leaf133.gotoAndPlay(1);
        this._leaf133.x = 450;
        this._leaf133.y = 237;
        _map.front.addChild(this._leaf133);
        DisplayObjectUtil.enableButtonMode(this._leaf133);
        this._leaf133.addEventListener(MouseEvent.CLICK, this.onLeafClick);
        this._leaf133.addEventListener(MouseEvent.MOUSE_OVER, this.onLeafOver);
        this._leaf133.addEventListener(Event.ENTER_FRAME, this.onLeafEnterFrame);
    }

    private function onLeafClick(param1:MouseEvent):void {
        this._leaf133.gotoAndPlay("mouseClick");
        LayerManager.focusOnTopLayer();
        (SceneManager.active as LobbyScene).hideToolbar();
    }

    private function onLeafOver(param1:MouseEvent):void {
        this._leaf133.removeEventListener(MouseEvent.MOUSE_OVER, this.onLeafOver);
        this._leaf133.gotoAndPlay("mouseOver");
    }

    private function onLeafEnterFrame(param1:Event):void {
        if (this._leaf133.currentFrameLabel == "normalEnd") {
            this._leaf133.gotoAndPlay(1);
        } else if (this._leaf133.currentFrame == this._leaf133.totalFrames) {
            this._leaf133.removeEventListener(Event.ENTER_FRAME, this.onLeafEnterFrame);
            DisplayObjectUtil.removeFromParent(this._leaf133);
            this._quest4Step8Animation133 = _map.libManager.getMovieClip("TeruyBeCatchedMC");
            this._quest4Step8Animation133.x = 0;
            this._quest4Step8Animation133.y = 0;
            _map.front.addChild(this._quest4Step8Animation133);
            SoundManager.enabled = false;
            this._quest4Step8Animation133.play();
            this._quest4Step8Animation133.addEventListener(Event.ENTER_FRAME, this.onQuest4Step8AnimationEnd);
        }
    }

    private function onQuest4Step8AnimationEnd(param1:Event):void {
        if (this._quest4Step8Animation133.currentFrame == this._quest4Step8Animation133.totalFrames) {
            SoundManager.enabled = true;
            LayerManager.resetOperation();
            (SceneManager.active as LobbyScene).showToolbar();
            this._quest4Step8Animation133.removeEventListener(Event.ENTER_FRAME, this.onQuest4Step8AnimationEnd);
            DisplayObjectUtil.removeFromParent(this._quest4Step8Animation133);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete8);
            QuestManager.completeStep(_quest.id, 8);
        }
    }

    private function onStepComplete8(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete8);
            this.processStep9();
        }
    }

    private function processStep9():void {
        DialogPanel.showForSimple(400, "我", [[0, "糟糕……出事了！！！都怪我没保护好特鲁伊……快去告诉酋长！！"]], "返回权力之帐……", function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete9);
            QuestManager.completeStep(_quest.id, 9);
        });
    }

    private function onStepComplete9(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete9);
            SceneManager.changeScene(SceneType.LOBBY, 110);
        }
    }

    override public function processMapDispose():void {
        if (this._leaf133) {
            this._leaf133.removeEventListener(MouseEvent.CLICK, this.onLeafClick);
            this._leaf133.removeEventListener(MouseEvent.MOUSE_OVER, this.onLeafOver);
            this._leaf133.removeEventListener(Event.ENTER_FRAME, this.onLeafEnterFrame);
            DisplayObjectUtil.removeFromParent(this._leaf133);
            this._leaf133 = null;
        }
        if (this._quest4Step8Animation133) {
            this._quest4Step8Animation133.removeEventListener(Event.ENTER_FRAME, this.onQuest4Step8AnimationEnd);
            DisplayObjectUtil.removeFromParent(this._quest4Step8Animation133);
            this._quest4Step8Animation133 = null;
        }
        super.processMapDispose();
    }
}
}
