package com.taomee.seer2.app.processor.quest.handler.branch.quest10220 {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

public class Quest10220Game {

    private static var _mc:MovieClip;

    private static var _closeBtn:SimpleButton;

    private static var _actor:MovieClip;

    private static var _count:int;

    private static var _complete:Function;


    public function Quest10220Game() {
        super();
    }

    public static function setMC(param1:MovieClip, param2:Function):void {
        _mc = param1;
        _complete = param2;
        _closeBtn = _mc["closeBtn"];
        _actor = _mc["actor"];
        _actor.gotoAndStop(1);
        _count = 0;
        LayerManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
        _closeBtn.addEventListener(MouseEvent.CLICK, onClose);
    }

    private static function onDown(param1:KeyboardEvent):void {
        if (param1.keyCode == 32) {
            ++_count;
            _actor.gotoAndStop(_count + 1);
            if (_count == 5) {
                onClose(null);
            }
        }
    }

    private static function onClose(param1:MouseEvent):void {
        LayerManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onDown);
        _closeBtn.removeEventListener(MouseEvent.CLICK, onClose);
        if (_count >= 5) {
            _complete(true);
        } else {
            _complete(false);
        }
        _mc.visible = false;
    }
}
}
