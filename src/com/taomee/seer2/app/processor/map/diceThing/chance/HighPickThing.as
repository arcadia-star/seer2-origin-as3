package com.taomee.seer2.app.processor.map.diceThing.chance {
import com.taomee.seer2.app.activity.processor.salungInvade.SalungHostageTarget;
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
import com.taomee.seer2.app.utils.NumDisplayUtil;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.SyncEvent;

import org.taomee.utils.Tick;

public class HighPickThing extends ChanceThing {


    private var gameMc:SalungHostageTarget;

    private var time:int = 20;

    private var timeMc:Sprite;

    public function HighPickThing(param1:DiceThingInfo) {
        super(param1);
    }

    override protected function setUpGame(param1:MouseEvent):void {
        super.setUpGame(param1);
        this.gameMc = new SalungHostageTarget();
        this.gameMc.hasWard = false;
        LayerManager.moduleLayer.addChild(this.gameMc);
        this.gameMc.addEventListener("closeGame", this.overGame);
    }

    private function startTime():void {
        this.timeMc = NumDisplayUtil.getNumDisplay(this.time, "UI_NumberCoin", 14);
        LayerManager.stage.addChild(this.timeMc);
        Tick.instance.addRender(this.timeRender, 1000);
    }

    private function timeRender(param1:int):void {
        if (this.timeMc) {
            DisplayObjectUtil.removeFromParent(this.timeMc);
        }
        --this.time;
        this.timeMc = NumDisplayUtil.getNumDisplay(this.time, "UI_NumberCoin", 14);
        if (this.time == 0) {
            Tick.instance.removeRender(this.timeRender);
            DisplayObjectUtil.removeFromParent(this.timeMc);
            this.gameMc.dispose();
        }
    }

    private function overGame(param1:SyncEvent):void {
        this.gameMc.removeEventListener("closeGame", this.overGame);
        DisplayObjectUtil.removeFromParent(this.gameMc);
        var _loc2_:int = 21 - param1.changeList[0];
        eventInfo.rightNum = _loc2_;
        if (_loc2_ >= 10) {
            eventInfo.moveTile = 2;
        } else if (_loc2_ >= 5) {
            eventInfo.moveTile = 1;
        } else {
            eventInfo.moveTile = 0;
        }
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
    }

    override public function dispose():void {
        super.dispose();
        this.gameMc.removeEventListener("closeGame", this.overGame);
        this.gameMc.dispose();
        this.gameMc = null;
        if (this.timeMc) {
            DisplayObjectUtil.removeFromParent(this.timeMc);
            this.timeMc = null;
        }
    }
}
}
