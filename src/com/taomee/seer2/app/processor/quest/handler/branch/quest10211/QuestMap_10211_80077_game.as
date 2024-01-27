package com.taomee.seer2.app.processor.quest.handler.branch.quest10211 {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class QuestMap_10211_80077_game extends Sprite {

    private static const target_id:int = 1;


    private var ui:MovieClip;

    private var closeBtn:SimpleButton;

    private var btnList:Vector.<SimpleButton>;

    private var lightMc:MovieClip;

    public function QuestMap_10211_80077_game(param1:MovieClip) {
        super();
        this.ui = param1;
        addChild(param1);
        this.init();
    }

    private function init():void {
        this.btnList = new Vector.<SimpleButton>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this.btnList.push(this.ui["btn" + _loc1_]);
            this.btnList[_loc1_].addEventListener(MouseEvent.CLICK, this.onClick);
            _loc1_++;
        }
        this.closeBtn = this.ui["closeBtn"];
        this.closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        this.lightMc = this.ui["lightMc"];
        this.lightMc.gotoAndStop(1);
        this.lightMc.visible = false;
    }

    private function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var index:int = this.btnList.indexOf(e.currentTarget as SimpleButton);
        if (index == target_id) {
            this.lightMc.visible = true;
            this.btnList[target_id].visible = false;
            MovieClipUtil.playMc(this.lightMc, 1, this.lightMc.totalFrames, function ():void {
                QuestManager.completeStep(10211, 3);
                dispose();
            });
        } else {
            AlertManager.showAlert("你选择的图形不正确哦");
        }
    }

    private function onClose(param1:MouseEvent):void {
        DisplayObjectUtil.removeFromParent(this);
        this.dispose();
    }

    private function dispose():void {
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this.btnList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onClick);
            _loc1_++;
        }
        this.closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
        this.lightMc.stop();
    }
}
}
