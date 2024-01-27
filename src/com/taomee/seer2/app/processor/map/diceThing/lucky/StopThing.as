package com.taomee.seer2.app.processor.map.diceThing.lucky {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
import com.taomee.seer2.app.utils.NumDisplayUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.utils.Tick;

public class StopThing extends LuckyThing {


    private var stopTime:int;

    private var currentTime:int = 1;

    private var countDownSp:Sprite;

    private var timeMc:MovieClip;

    public function StopThing(param1:DiceThingInfo) {
        super(param1);
    }

    override protected function overThing(param1:MouseEvent):void {
        super.overThing(param1);
        this.playStopTime();
        this.stopTime = thingInfo.stopTime;
    }

    private function playStopTime():void {
        QueueLoader.load(URLUtil.getRes("map/dice/card/stopTime.swf"), LoadType.SWF, this.loadeComplete);
    }

    private function loadeComplete(param1:ContentInfo):void {
        this.timeMc = param1.content["mc"] as MovieClip;
        SceneManager.active.mapModel.front.addChild(this.timeMc);
        Tick.instance.addRender(this.changTime, 1000);
        this.countDownSp = NumDisplayUtil.getNumDisplay(this.currentTime, "UI_NumberCountDown", 28);
        this.countDownSp.scaleX = this.countDownSp.scaleY = 1.5;
        this.countDownSp.x = 475 - this.countDownSp.width / 2;
        this.countDownSp.y = 280;
        LayerManager.topLayer.addChild(this.countDownSp);
        SoundManager.play(URLUtil.getRes("map/dice/sound/countDown.mp3"));
    }

    private function changTime(param1:int):void {
        ++this.currentTime;
        if (this.currentTime <= this.stopTime) {
            SoundManager.play(URLUtil.getRes("map/dice/sound/countDown.mp3"));
        } else {
            SoundManager.play(URLUtil.getRes("map/dice/sound/zeroSound.mp3"));
        }
        if (this.countDownSp) {
            DisplayObjectUtil.removeFromParent(this.countDownSp);
        }
        this.countDownSp = NumDisplayUtil.getNumDisplay(this.currentTime, "UI_NumberCountDown", 28);
        this.countDownSp.scaleX = this.countDownSp.scaleY = 1.5;
        this.countDownSp.x = 475 - this.countDownSp.width / 2;
        this.countDownSp.y = 280;
        LayerManager.topLayer.addChild(this.countDownSp);
        if (this.currentTime > this.stopTime) {
            DisplayObjectUtil.removeFromParent(this.countDownSp);
            DisplayObjectUtil.removeFromParent(this.timeMc);
            Tick.instance.removeRender(this.changTime);
            this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
            this.dispose();
        }
    }

    override public function dispose():void {
        super.dispose();
        DisplayObjectUtil.removeFromParent(this.countDownSp);
        DisplayObjectUtil.removeFromParent(this.timeMc);
        Tick.instance.removeRender(this.changTime);
    }
}
}
