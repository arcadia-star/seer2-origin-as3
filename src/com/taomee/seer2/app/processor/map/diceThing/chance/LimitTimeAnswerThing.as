package com.taomee.seer2.app.processor.map.diceThing.chance {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
import com.taomee.seer2.app.utils.NumDisplayUtil;
import com.taomee.seer2.core.module.Module;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.SyncEvent;

import org.taomee.utils.Tick;

public class LimitTimeAnswerThing extends ChanceThing {


    private var time:int = 60;

    private var timeMc:Sprite;

    private var module:Module;

    public function LimitTimeAnswerThing(param1:DiceThingInfo) {
        super(param1);
    }

    override protected function setUpGame(param1:MouseEvent):void {
        super.setUpGame(param1);
        ModuleManager.toggleModule(URLUtil.getAppModule("SeerIIAnswerPanel"));
        ModuleManager.addEventListener("SeerIIAnswerPanel", ModuleEvent.SHOW, this.showComplete);
    }

    private function showComplete(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("SeerIIAnswerPanel", ModuleEvent.SHOW, this.showComplete);
        this.module = ModuleManager.getModule("SeerIIAnswerPanel").module;
        this.module["closeBtn"].visible = false;
        this.module.addEventListener("seerii_anwser_over", this.overAnswer);
    }

    private function overAnswer(param1:SyncEvent):void {
        var _loc2_:int = int(param1.changeList[0]);
        eventInfo.rightNum = _loc2_ * 10;
        if (_loc2_ >= 10) {
            eventInfo.moveTile = 2;
        } else if (_loc2_ >= 5) {
            eventInfo.moveTile = 1;
        } else {
            eventInfo.moveTile = 0;
        }
        this.module.removeEventListener("seerii_anwser_over", this.overAnswer);
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
        this.dispose();
    }

    private function startTime():void {
        this.timeMc = NumDisplayUtil.getNumDisplay(this.time, "UI_NumberCoin", 14);
        LayerManager.topLayer.addChild(this.timeMc);
        Tick.instance.addRender(this.timeRender, 1000);
    }

    private function timeRender(param1:int):void {
        if (this.timeMc) {
            DisplayObjectUtil.removeFromParent(this.timeMc);
        }
        --this.time;
        this.timeMc = NumDisplayUtil.getNumDisplay(this.time, "UI_NumberCoin", 14);
        LayerManager.topLayer.addChild(this.timeMc);
        if (this.time == 0) {
            Tick.instance.removeRender(this.timeRender);
            if (this.module) {
                ModuleManager.closeForInstance(this.module);
            }
            DisplayObjectUtil.removeFromParent(this.timeMc);
        }
    }

    override public function dispose():void {
        super.dispose();
        Tick.instance.removeRender(this.timeRender);
        ModuleManager.removeEventListener("SeerIIAnswerPanel", ModuleEvent.SHOW, this.showComplete);
        this.module.removeEventListener("seerii_anwser_over", this.overAnswer);
    }
}
}
