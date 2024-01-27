package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.controls.widget.NonoInputFrameWidget;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_80491 extends MapProcessor {


    private var _captain:Mobile;

    private var _npc:MovieClip;

    public function MapProcessor_80491(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._captain = MobileManager.getMobile(80351, MobileType.NPC);
        if (this._captain) {
            this._captain.gotoAndStop(1);
            this._captain.addEventListener(MouseEvent.MOUSE_OVER, this.onCaptainOver);
            this._captain.addEventListener(MouseEvent.MOUSE_OUT, this.onCaptainOut);
        }
        this._npc = _map.content["npc"];
        this._npc.buttonMode = true;
        if (QuestManager.isComplete(99)) {
            AlertManager.showAlert("新手任务已完成");
            RightToolbarConter.instance.newPlayerShowFilter();
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
            ToolBar.getBtn(NonoInputFrameWidget.NONOINPUT).visible = true;
        }
    }

    private function onNpc(param1:MouseEvent):void {
        ModuleManager.showAppModule("NewPlayerProcessWayPanel");
    }

    private function onCaptainOver(param1:MouseEvent):void {
        this._captain.addEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
        this._captain.play();
    }

    private function onCaptainPlay(param1:Event):void {
        if (this._captain.currentFrameIndex == 3) {
            this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
            this._captain.gotoAndStop(3);
        }
    }

    private function onCaptainOut(param1:MouseEvent):void {
        if (this._captain) {
            this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
            this._captain.gotoAndStop(1);
        }
    }

    override public function dispose():void {
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc);
        if (this._captain) {
            this._captain.removeEventListener(MouseEvent.MOUSE_OVER, this.onCaptainOver);
            this._captain.removeEventListener(MouseEvent.MOUSE_OUT, this.onCaptainOut);
        }
        super.dispose();
    }
}
}
