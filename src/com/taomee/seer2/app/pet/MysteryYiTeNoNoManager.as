package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;

public class MysteryYiTeNoNoManager {

    private static const npcID:int = 0;

    private static const mapIDlist:Array = [40, 50, 60, 80];

    private static const mapProbability:Number = 0.5;

    private static const npcPostion:Array = [new Point(200, 200), new Point(200, 200), new Point(200, 200), new Point(200, 200)];

    private static var libs:ResourceLibrary;

    private static const resPath:Array = ["nonoZaChangZi/10004", "nonoZaChangZi/10005", "nonoZaChangZi/10006", "nonoZaChangZi/10008"];

    private static const TIMES:int = 20;

    public static var hasNoNoAppearTime:int = 0;

    private static var hitNoNoLibs:ResourceLibrary;

    private static var nono:MysteryNoNo;

    private static const mapPostion:Array = [new Point(650, 145), new Point(655, 133), new Point(650, 145), new Point(650, 145)];


    public function MysteryYiTeNoNoManager() {
        super();
    }

    public static function setup():void {
        DayLimitManager.getDoCount(633, function (param1:uint):void {
            var _loc2_:int = TIMES - param1;
            hasNoNoAppearTime = param1;
            if (_loc2_ >= 1) {
                SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
            }
        });
    }

    private static function onComplete(param1:SceneEvent):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        if (SceneManager.active) {
            _loc2_ = int(SceneManager.active.mapID);
            _loc3_ = mapIDlist.indexOf(_loc2_);
            if (_loc3_ != -1) {
                if (Boolean(nono) && Boolean(nono.parent)) {
                    nono.parent.removeChild(nono);
                    nono = null;
                }
                if ((_loc4_ = Math.random()) < mapProbability) {
                    StatisticsManager.sendNovice(StatisticsManager.ui_interact_398);
                    hasNoNoAppearTime += 1;
                    if (hasNoNoAppearTime == TIMES) {
                        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
                    }
                    QueueLoader.load(URLUtil.getActivityAnimation(resPath[_loc3_]), LoadType.DOMAIN, onLoadComplete);
                }
            }
        }
    }

    private static function onLoadComplete(param1:ContentInfo):void {
        var mc1:MovieClip = null;
        var mc2:MovieClip = null;
        var info:ContentInfo = param1;
        var _resLib:ResourceLibrary = new ResourceLibrary(info.content);
        mc1 = _resLib.getMovieClip("nono");
        mc2 = _resLib.getMovieClip("baodating");
        SceneManager.active.mapModel.front.addChild(mc1);
        SceneManager.active.mapModel.front.addChild(mc2);
        LayerManager.focusOnTopLayer();
        mc1.gotoAndPlay(2);
        MovieClipUtil.playMc(mc2, 1, mc2.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(mc1);
            DisplayObjectUtil.removeFromParent(mc2);
            mc1 = null;
            mc2 = null;
            LayerManager.resetOperation();
            addInteractiveObj();
        });
    }

    private static function addInteractiveObj():void {
        if (!hitNoNoLibs) {
            QueueLoader.load(URLUtil.getActivityAnimation("nonoZaChangZi/dianjinono"), LoadType.DOMAIN, onLoadNoNoComplete);
        } else {
            createNono();
        }
    }

    private static function onLoadNoNoComplete(param1:ContentInfo):void {
        hitNoNoLibs = new ResourceLibrary(param1.content);
        createNono();
    }

    private static function createNono():void {
        nono = new MysteryNoNo(hitNoNoLibs);
        SceneManager.active.mapModel.front.addChild(nono);
        var _loc1_:int = mapIDlist.indexOf(SceneManager.active.mapID);
        nono.x = mapPostion[_loc1_].x;
        nono.y = mapPostion[_loc1_].y;
        nono.addEventListener(MysteryNoNo.CLICKED_TEN_TIME, removeNoNo);
    }

    private static function removeNoNo(param1:Event):void {
        if (SceneManager.active) {
            nono.removeEventListener(MysteryNoNo.CLICKED_TEN_TIME, removeNoNo);
            DisplayObjectUtil.removeFromParent(nono);
            nono.dispose();
            nono = null;
            QueueLoader.load(URLUtil.getActivityAnimation("nonoZaChangZi/nonodisappear"), LoadType.DOMAIN, onLoadDisappear);
        }
    }

    private static function onLoadDisappear(param1:ContentInfo):void {
        var mc:MovieClip = null;
        var info:ContentInfo = param1;
        var _resLib:ResourceLibrary = new ResourceLibrary(info.content);
        mc = _resLib.getMovieClip("disappear");
        SceneManager.active.mapModel.front.addChild(mc);
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            mc.stop();
            DisplayObjectUtil.removeFromParent(mc);
            mc = null;
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, onGetRewardSuccess);
            Connection.send(CommandSet.DIGGER_MINE_1060, 227);
        });
    }

    private static function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, onGetRewardSuccess);
        var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
        _loc2_.showResult(true);
    }
}
}
