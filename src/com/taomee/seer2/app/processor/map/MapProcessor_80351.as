package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_80351 extends MapProcessor {


    private var _captain:Mobile;

    public function MapProcessor_80351(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._captain = MobileManager.getMobile(80351, MobileType.NPC);
        this._captain.gotoAndStop(1);
        if (QuestManager.isComplete(83)) {
            AlertManager.showAlert("新手任务已完成");
            SceneManager.changeScene(SceneType.LOBBY, 70);
            return;
        }
        this._captain.addEventListener(MouseEvent.MOUSE_OVER, this.onCaptainOver);
        this._captain.addEventListener(MouseEvent.MOUSE_OUT, this.onCaptainOut);
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
}
}
