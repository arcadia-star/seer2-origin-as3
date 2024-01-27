package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.controls.widget.core.IWidgetable;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class Newer30DayWidget extends Sprite implements IWidgetable {

    public static const Newer30Day:String = "Newer30Day";


    private var _mainUI:MovieClip;

    private const FOR_DAY:uint = 205176;

    public function Newer30DayWidget(param1:MovieClip) {
        var mc:MovieClip = param1;
        super();
        this._mainUI = mc;
        if (ActorManager.actorInfo.createTime >= new Date(2014, 8, 19).getTime() / 1000 && QuestManager.isFreshQuestComplete()) {
            ActiveCountManager.requestActiveCount(this.FOR_DAY, function (param1:uint, param2:uint):void {
                if (param2 < 30) {
                    addChild(_mainUI);
                    initMC();
                    initEventListener();
                }
            });
        } else {
            this._mainUI.visible = false;
        }
    }

    private function initEventListener():void {
        this._mainUI.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        ModuleManager.showAppModule("NewerSignPanel");
    }

    private function initMC():void {
        this._mainUI.buttonMode = true;
    }
}
}
