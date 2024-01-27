package com.taomee.seer2.app.processor.quest.handler.story.quest17 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_17_90 extends QuestMapHandler {


    private var _carpetMc:MovieClip;

    private var _carpetTrigger:MovieClip;

    public function QuestMapHandler_17_90(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.showMouse(309, 278);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this._carpetMc = _map.content["carpetMc"];
            this._carpetTrigger = _map.content["carpetTrigger"];
            this._carpetTrigger.addEventListener(MouseEvent.CLICK, this.onClick);
            this.showMouse(638, 349);
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this._carpetMc = _map.content["carpetMc"];
            this._carpetTrigger = _map.content["carpetTrigger"];
            this._carpetTrigger.addEventListener(MouseEvent.CLICK, this.onClick);
            this.showMouse(638, 349);
        }
    }

    private function onClick(param1:MouseEvent):void {
        this._carpetTrigger.removeEventListener(MouseEvent.CLICK, this.onClick);
        _processor.hideMouseClickHint();
        this._carpetMc.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event):void {
        if (this._carpetMc.currentFrame == this._carpetMc.totalFrames) {
            this._carpetMc.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.showMouse(519, 442);
        }
    }

    private function showMouse(param1:Number, param2:Number):void {
        _processor.showMouseHintAt(param1, param2);
    }

    override public function processMapDispose():void {
        if (this._carpetMc) {
            this._carpetMc.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
        this._carpetMc = null;
        if (this._carpetTrigger) {
            this._carpetTrigger.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._carpetTrigger = null;
        _processor.hideMouseClickHint();
    }
}
}
