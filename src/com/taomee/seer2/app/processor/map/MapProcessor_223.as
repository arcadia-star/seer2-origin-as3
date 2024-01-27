package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_223 extends DreamMapProcessor {


    private const DREAM_NPC_TYPE:uint = 418;

    private var _dialog:MovieClip;

    private var _hotArea:MovieClip;

    public function MapProcessor_223(param1:MapModel) {
        _taskId = 3;
        super(param1);
    }

    override public function init():void {
        super.init();
        this._hotArea = _map.content["hotArea"];
        this._dialog = _map.content["dialog"];
        DisplayObjectUtil.disableSprite(this._dialog);
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            this._dialog.visible = false;
            indicateLeaveDream();
        } else {
            this._dialog.addEventListener(Event.ENTER_FRAME, this.onDialogEnd);
            this._dialog.gotoAndPlay(1);
        }
    }

    private function onDialogEnd(param1:Event):void {
        if (this._dialog.currentFrameLabel == "fight") {
            this._dialog.removeEventListener(Event.ENTER_FRAME, this.onDialogEnd);
            this._hotArea.buttonMode = true;
            this._hotArea.addEventListener(MouseEvent.CLICK, this.onPetClick);
        }
    }

    private function onPetClick(param1:MouseEvent):void {
        DisplayObjectUtil.disableSprite(this._hotArea);
        this.startFight();
    }

    private function startFight():void {
        Connection.addErrorHandler(CommandSet.GET_DREAM_REWAED_1053, this.onGetDreamRewardError);
        Connection.addCommandListener(CommandSet.GET_DREAM_REWAED_1053, this.onMessage);
        Connection.send(CommandSet.GET_DREAM_REWAED_1053, this.DREAM_NPC_TYPE, _taskId);
    }

    private function onMessage(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.GET_DREAM_REWAED_1053, this.onGetDreamRewardError);
        Connection.removeCommandListener(CommandSet.GET_DREAM_REWAED_1053, this.onMessage);
        DreamManager.addDreamNum();
    }

    private function onGetDreamRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.GET_DREAM_REWAED_1053, this.onGetDreamRewardError);
        Connection.removeCommandListener(CommandSet.GET_DREAM_REWAED_1053, this.onMessage);
        if (param1.message.statusCode == 66) {
            AlertManager.showAlert("嘘，让它做个好梦吧！今天就别打扰喽！");
            DreamManager.addDreamNum(DreamManager.DREAM_LIMIT);
        } else {
            DisplayObjectUtil.enableSprite(this._hotArea);
        }
    }

    override public function dispose():void {
        this._hotArea.removeEventListener(MouseEvent.CLICK, this.onPetClick);
        this._hotArea = null;
        this._dialog.removeEventListener(Event.ENTER_FRAME, this.onDialogEnd);
        this._dialog = null;
        super.dispose();
    }
}
}
