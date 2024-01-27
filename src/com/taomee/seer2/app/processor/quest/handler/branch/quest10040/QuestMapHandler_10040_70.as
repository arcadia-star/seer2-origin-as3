package com.taomee.seer2.app.processor.quest.handler.branch.quest10040 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10040_70 extends QuestMapHandler {


    private var _giftMc:MovieClip;

    private var _screenMc:MovieClip;

    private var _screenClickCount:int;

    private var _isFocusTopLayer:Boolean;

    public function QuestMapHandler_10040_70(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            return;
        }
        if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (_quest.isStepCompletable(1)) {
                this.processStep1();
            }
        }
        this._isFocusTopLayer = false;
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        if (this._giftMc) {
            TooltipManager.remove(this._giftMc);
            this._giftMc.removeEventListener(MouseEvent.CLICK, this.onGiftMcClick);
        }
        if (this._screenMc) {
            this._screenMc.removeEventListener(MouseEvent.CLICK, this.onScreenMcClick);
            this._screenMc.removeEventListener(Event.ENTER_FRAME, this.onScreenEnterFrame);
        }
        if (this._isFocusTopLayer) {
            LayerManager.resetOperation();
            this._isFocusTopLayer = false;
        }
        super.processMapDispose();
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            this.processStep1();
        }
    }

    private function processStep1():void {
        this._giftMc = _processor.resLib.getMovieClip("giftMc");
        _map.content.addChild(this._giftMc);
        this._giftMc.buttonMode = true;
        TooltipManager.addCommonTip(this._giftMc, "圣诞神秘礼物盒");
        this._giftMc.addEventListener(MouseEvent.CLICK, this.onGiftMcClick);
    }

    private function onGiftMcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        MovieClipUtil.getSwfContent(URLUtil.getQuestFullScreenAnimation("10040_0"), function (param1:MovieClip):void {
            _screenClickCount = 0;
            _screenMc = param1;
            _screenMc.gotoAndPlay("first");
            _screenMc.addEventListener(MouseEvent.CLICK, onScreenMcClick);
            _screenMc.addEventListener(Event.ENTER_FRAME, onScreenEnterFrame);
            DisplayObjectUtil.disableButtonMode(_screenMc);
            _isFocusTopLayer = true;
            LayerManager.focusOnTopLayer();
            LayerManager.topLayer.addChild(_screenMc);
        }, " 加载全屏资源");
    }

    private function onScreenMcClick(param1:MouseEvent):void {
        ++this._screenClickCount;
        this._screenMc.play();
        DisplayObjectUtil.disableButtonMode(this._screenMc);
    }

    private function onScreenEnterFrame(param1:Event):void {
        if (this._screenClickCount == 0 && this._screenMc.currentLabel == "second") {
            DisplayObjectUtil.enableButtonMode(this._screenMc);
            this._screenMc.stop();
        } else if (this._screenClickCount == 1 && this._screenMc.currentLabel == "third") {
            DisplayObjectUtil.enableButtonMode(this._screenMc);
            this._screenMc.stop();
        } else if (this._screenClickCount == 2 && this._screenMc.currentFrame == this._screenMc.totalFrames) {
            this._screenMc.stop();
            DisplayObjectUtil.removeFromParent(this._screenMc);
            this._isFocusTopLayer = false;
            LayerManager.resetOperation();
            QuestManager.completeStep(_quest.id, 1);
            SceneManager.changeScene(SceneType.LOBBY, 8022);
        }
    }
}
}
