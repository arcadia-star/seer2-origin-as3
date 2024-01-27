package com.taomee.seer2.app.processor.map.diceThing.chance {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class ChanceThing extends BaseDiceThing {


    private var cardMc:MovieClip;

    private var okBtn:SimpleButton;

    public function ChanceThing(param1:DiceThingInfo) {
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
        this.cardMc.x = 120 - (1200 - LayerManager.stage.stageWidth) / 2;
        this.cardMc.y = 50 - (660 - LayerManager.stage.stageHeight) / 2;
        SceneManager.active.mapModel.front.addChild(this.cardMc);
        this.cardMc.mouseEnabled = false;
        this.cardMc.mouseChildren = false;
        MovieClipUtil.playMc(this.cardMc, 1, this.cardMc.totalFrames, function ():void {
            cardMc.mouseEnabled = true;
            cardMc.mouseChildren = true;
            okBtn = cardMc["okBtn"];
            okBtn.addEventListener(MouseEvent.CLICK, setUpGame);
        });
    }

    protected function setUpGame(param1:MouseEvent):void {
        DisplayObjectUtil.removeFromParent(this.cardMc);
        this.okBtn.removeEventListener(MouseEvent.CLICK, this.setUpGame);
    }

    override public function dispose():void {
        super.dispose();
        if (this.cardMc) {
            this.cardMc.stop();
            this.cardMc = null;
        }
        if (this.okBtn) {
            this.okBtn.removeEventListener(MouseEvent.CLICK, this.setUpGame);
            this.okBtn = null;
        }
    }
}
}
