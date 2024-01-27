package com.taomee.seer2.app.processor.map.diceThing.lucky {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class LuckyThing extends BaseDiceThing {


    private var okBtn:SimpleButton;

    private var cardMc:MovieClip;

    public function LuckyThing(param1:DiceThingInfo) {
        super(param1);
    }

    override public function setUpThing():void {
        if (thingInfo.isMee) {
            QueueLoader.load(URLUtil.getRes("map/dice/card/" + thingInfo.type + "Mee_" + thingInfo.id + ".swf"), LoadType.SWF, this.onLoadeComplete);
        } else {
            QueueLoader.load(URLUtil.getRes("map/dice/card/" + thingInfo.type + "_" + thingInfo.id + ".swf"), LoadType.SWF, this.onLoadeComplete);
        }
    }

    private function onLoadeComplete(param1:ContentInfo):void {
        var infos:ContentInfo = param1;
        this.cardMc = (infos.content as MovieClip).getChildAt(0) as MovieClip;
        this.cardMc.gotoAndStop(1);
        this.cardMc.mouseEnabled = false;
        this.cardMc.mouseChildren = false;
        SceneManager.active.mapModel.front.addChild(this.cardMc);
        this.cardMc.width = 1200;
        this.cardMc.height = 1170;
        MovieClipUtil.playMc(this.cardMc, 1, this.cardMc.totalFrames, function ():void {
            cardMc.mouseEnabled = true;
            cardMc.mouseChildren = true;
            okBtn = cardMc["okBtn"];
            okBtn.addEventListener(MouseEvent.CLICK, overThing);
        });
    }

    protected function overThing(param1:MouseEvent):void {
        this.okBtn.removeEventListener(MouseEvent.CLICK, this.overThing);
        DisplayObjectUtil.removeFromParent(this.cardMc);
    }

    override public function dispose():void {
        super.dispose();
        if (this.cardMc) {
            this.cardMc.stop();
            this.cardMc = null;
        }
        if (this.okBtn) {
            this.okBtn.removeEventListener(MouseEvent.CLICK, this.overThing);
            this.okBtn = null;
        }
    }
}
}
