package com.taomee.seer2.app.processor.map.diceThing.box {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.utils.IDataInput;

public class JiaBaiLieBoxThing extends BaseDiceThing {


    protected var parse1060:Parser_1060;

    public function JiaBaiLieBoxThing(param1:DiceThingInfo) {
        super(param1);
    }

    override public function setUpThing():void {
        Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult);
        Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.send(CommandSet.DIGGER_MINE_1060, thingInfo.strikeId);
    }

    private function onGerRewardError(param1:MessageEvent):void {
        this.getSuccess();
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult);
    }

    protected function showResult(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult);
        var _loc2_:IDataInput = param1.message.getRawData();
        this.parse1060 = new Parser_1060(_loc2_);
        QueueLoader.load(URLUtil.getActivityFullScreen("openBox"), LoadType.SWF, this.onComplete);
    }

    protected function onComplete(param1:ContentInfo):void {
        var mc:MovieClip = null;
        var info:ContentInfo = param1;
        mc = info.content["box"] as MovieClip;
        LayerManager.topLayer.addChild(mc);
        MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(mc);
            parse1060.showResult(true, getSuccess);
        });
    }

    protected function getSuccess():void {
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult);
    }
}
}
