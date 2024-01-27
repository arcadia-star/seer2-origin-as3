package com.taomee.seer2.app.processor.activity.miKaAct {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;
import org.taomee.utils.Tick;

public class MiKaFindProcessHandle {

    private static const DAY_LIST:Array = [1624];

    private static const MAP_LIST:Vector.<int> = Vector.<int>([590, 550, 640, 620, 540]);

    private static const POS_CANDLE:Vector.<Point> = Vector.<Point>([new Point(200, 200), new Point(200, 200), new Point(520, 198), new Point(200, 200), new Point(200, 200)]);

    private static const POS_GUIDE:Vector.<Point> = Vector.<Point>([new Point(295, 243), new Point(300, 243), new Point(615, 240), new Point(300, 240), new Point(310, 237)]);

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([3716]);

    private static const FIGHT_INDEX:int = 236;


    private var _map:MapModel;

    private var _candleMc:MovieClip;

    private var _resLib:ApplicationDomain;

    private var _questIndex:int = 0;

    private var _progressBar:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function MiKaFindProcessHandle(param1:MapModel) {
        var map:MapModel = param1;
        super();
        this._map = map;
        if (this.isActTime()) {
            this.getURL(function ():void {
                initSet();
                update();
            });
        }
    }

    private function getURL(param1:Function = null):void {
        var callBack:Function = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("miKaFindAct/miKaFindActRes1"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            if (null != callBack) {
                callBack();
            }
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function isActTime():Boolean {
        var _loc1_:Boolean = false;
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (DateUtil.isInTime(new Date(2014, 11, 26), new Date(2015, 0, 8, 23, 59, 59))) {
            if (_loc2_.hours == 13) {
                _loc1_ = true;
            } else {
                _loc1_ = false;
            }
        }
        return _loc1_;
    }

    private function initSet():void {
        this._questIndex = MAP_LIST.indexOf(this._map.id);
    }

    private function update():void {
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var flag:Boolean = false;
            var flag2:Boolean = false;
            var info:DayLimitListInfo = param1;
            if (_questIndex > 0) {
                flag = Boolean(BitUtil.getBit(info.getCount(DAY_LIST[0]), _questIndex - 1));
                flag2 = Boolean(BitUtil.getBit(info.getCount(DAY_LIST[0]), _questIndex));
                if (flag && !flag2) {
                    initQuestUI();
                }
                if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
                    if (!flag && !flag2) {
                        TweenNano.delayedCall(2, function ():void {
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                        });
                    }
                }
            } else {
                flag = Boolean(BitUtil.getBit(info.getCount(DAY_LIST[0]), _questIndex));
                if (!flag) {
                    initQuestUI();
                }
            }
            if (BitUtil.getBit(info.getCount(DAY_LIST[0]), _questIndex)) {
                if (_candleMc == null) {
                    _candleMc = getMovie("Candle_10142");
                }
                if (_candleMc.parent == null) {
                    LayerManager.uiLayer.addChild(_candleMc);
                    _candleMc.x = POS_CANDLE[_questIndex].x;
                    _candleMc.y = POS_CANDLE[_questIndex].y;
                }
                _candleMc["progressBar"].visible = false;
                _candleMc.buttonMode = false;
                _candleMc.removeEventListener(MouseEvent.CLICK, startFireup);
                _candleMc.gotoAndStop(2);
            }
        });
    }

    private function startMcTimer():void {
        Tick.instance.addRender(this.onPlayProgress, 500);
    }

    private function onPlayProgress(param1:int):void {
        var param:int = param1;
        if (this._progressBar.currentFrame < this._progressBar.totalFrames) {
            this._progressBar.nextFrame();
        } else {
            Tick.instance.removeRender(this.onPlayProgress);
            this._candleMc.gotoAndStop(2);
            this._candleMc["progressBar"].visible = false;
            LayerManager.resetOperation();
            if (this._questIndex != 4) {
                SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    ModuleManager.toggleModule(URLUtil.getAppModule("TorchRelayPanel"), "……");
                }, null, new SpecialInfo(1, this._questIndex));
            } else {
                this.playFullMovie();
            }
        }
    }

    private function initQuestUI():void {
        this._candleMc = this.getMovie("Candle_10142");
        LayerManager.uiLayer.addChild(this._candleMc);
        this._candleMc.addEventListener(MouseEvent.CLICK, this.startFireup);
        this._candleMc.buttonMode = true;
        this._candleMc.x = POS_CANDLE[this._questIndex].x;
        this._candleMc.y = POS_CANDLE[this._questIndex].y;
        this.showGuide();
        this._progressBar = this._candleMc["progressBar"]["progressbar"];
        this._candleMc["progressBar"].visible = false;
    }

    private function startFireup(param1:MouseEvent):void {
        this._candleMc.removeEventListener(MouseEvent.CLICK, this.startFireup);
        this.hideMouseClickHint();
        LayerManager.focusOnTopLayer();
        this._candleMc["progressBar"].visible = true;
        this._progressBar.gotoAndStop(1);
        this.startMcTimer();
    }

    private function showMouseHintAt(param1:Number, param2:Number):void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = param1;
        this._mouseHint.y = param2;
        this._map.front.addChild(this._mouseHint);
    }

    private function hideMouseClickHint():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
    }

    private function showGuide():void {
        this.showMouseHintAt(POS_GUIDE[this._questIndex].x, POS_GUIDE[this._questIndex].y);
    }

    private function playFullMovie():void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("miKaFindAct/MiKaFindAct1"), function ():void {
            DisplayUtil.removeForParent(_candleMc);
            if (Boolean(_map) && Boolean(_map.content["mikaNpc"])) {
                (_map.content["mikaNpc"] as MovieClip).visible = true;
            }
            if (Boolean(_map) && Boolean(_map.content["mikaNpc"])) {
                (_map.content["mikaNpc"] as MovieClip).visible = true;
                (_map.content["mikaNpc"] as MovieClip).buttonMode = true;
                (_map.content["mikaNpc"] as MovieClip).filters = [];
                (_map.content["mikaNpc"] as MovieClip).addEventListener(MouseEvent.CLICK, mikaFight);
            }
        });
    }

    private function mikaFight(param1:MouseEvent):void {
        FightManager.startFightWithWild(FIGHT_INDEX);
    }

    public function dispose():void {
        if (this._candleMc) {
            DisplayUtil.removeForParent(this._candleMc);
            this._candleMc = null;
        }
        Tick.instance.removeRender(this.onPlayProgress);
        if (Boolean(this._map) && Boolean(this._map.content["mikaNpc"])) {
            (this._map.content["mikaNpc"] as MovieClip).removeEventListener(MouseEvent.CLICK, this.mikaFight);
        }
    }
}
}
