package com.taomee.seer2.app.processor.quest.handler.main.quest6 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_6_123 extends QuestMapHandler {


    private var _stepAnimation6:MovieClip;

    private var _hotZone:MovieClip;

    private var _clickArea1:MovieClip;

    private var _clickArea2:MovieClip;

    public function QuestMapHandler_6_123(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(5)) && !_quest.isStepCompete(6)) {
            this.processStep6();
        }
    }

    private function processStep6():void {
        this._stepAnimation6 = _map.content["quest_6_6"];
        MovieClipUtil.playMc(this._stepAnimation6, "startShow", "endShow", function ():void {
            DialogPanel.showForSimple(11, "多罗", [[4, "老大！你殿后！我们先去异蘑谷看看哦！"]], "（一会在那里会合！）", function ():void {
                _hotZone = _stepAnimation6["hotZone"];
                _hotZone.buttonMode = true;
                _hotZone.addEventListener(MouseEvent.CLICK, onClickHotZone);
            });
        }, true);
    }

    private function onClickHotZone(param1:MouseEvent):void {
        this._hotZone.buttonMode = false;
        this._hotZone.removeEventListener(MouseEvent.CLICK, this.onClickHotZone);
        this._hotZone = null;
        this.chooseHotArea();
    }

    private function chooseHotArea():void {
        MovieClipUtil.playMc(this._stepAnimation6, "startChoose", "endChoose", function ():void {
            _clickArea1 = _stepAnimation6["hotZone_1"];
            _clickArea2 = _stepAnimation6["hotZone_2"];
            _clickArea1.addEventListener(MouseEvent.CLICK, onBtn1ClickHandler);
            _clickArea2.addEventListener(MouseEvent.CLICK, onBtn2ClickHandler);
        }, true);
    }

    private function onBtn1ClickHandler(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.clearHotArea();
        MovieClipUtil.playMc(this._stepAnimation6, "startHotArea1", "endHotArea1", function ():void {
            chooseHotArea();
        }, true);
    }

    private function onBtn2ClickHandler(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.clearHotArea();
        MovieClipUtil.playMc(this._stepAnimation6, "startHotArea2", "endHotArea2", function ():void {
            QuestManager.completeStep(_quest.id, 6);
            _processor.showMouseHintAt(-20, 360);
        }, true);
    }

    private function clearHotArea():void {
        this._clickArea1.removeEventListener(MouseEvent.CLICK, this.onBtn1ClickHandler);
        this._clickArea2.removeEventListener(MouseEvent.CLICK, this.onBtn2ClickHandler);
        this._clickArea1 = null;
        this._clickArea2 = null;
    }

    override public function processMapDispose():void {
        if (this._hotZone) {
            this._hotZone.removeEventListener(MouseEvent.CLICK, this.onClickHotZone);
        }
        if (this._clickArea1) {
            this._clickArea1.removeEventListener(MouseEvent.CLICK, this.onBtn1ClickHandler);
            this._clickArea2.removeEventListener(MouseEvent.CLICK, this.onBtn2ClickHandler);
        }
    }
}
}
