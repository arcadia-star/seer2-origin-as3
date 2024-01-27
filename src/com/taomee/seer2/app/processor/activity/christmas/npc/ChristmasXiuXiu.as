package com.taomee.seer2.app.processor.activity.christmas.npc {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.christmas.IChristmasNpc;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;

public class ChristmasXiuXiu implements IChristmasNpc {

    private static const XIUXIU_COMPLETE:String = "xiuxiuComplete";


    private var _res:ResourceLibrary;

    private var _npc:Mobile;

    private var _mc:MovieClip;

    private var _timer:Timer;

    private var _timerMC:MovieClip;

    private var _xiuxiuMC:MovieClip;

    private var _xiuxiuStatus:int;

    private var _mouseCount:int;

    private var _thisMC:MovieClip;

    private var _myXiuxiuMC:MovieClip;

    private var _xiuxiuThisMC:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function ChristmasXiuXiu(param1:ResourceLibrary) {
        super();
        this._res = param1;
    }

    public function playAnimation():void {
        var url:String = String(URLUtil.getActivityAnimation("9/4"));
        MovieClipUtil.playFullScreen(url, function ():void {
            initMouse();
            initNpc();
        }, false);
    }

    private function initMouse():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 331;
        this._mouseHint.y = 295;
        LayerManager.topLayer.addChild(this._mouseHint);
    }

    public function initNpc():void {
        var _loc1_:XML = <npc id="426" resId="426" name="休咻" dir="1" width="25" height="50" pos="331,313"
                              actorPos="334,325" path="">
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[我的热情好似一把火！！！]]></HandlerShowNpcSlogan>
                </mouseOver>
            </eventHandler>
        </npc>;
        var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
        this._npc = MobileManager.createNpc(_loc2_);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
        this._xiuxiuStatus = 0;
        this.initEvent();
    }

    private function initEvent():void {
        this._timer = new Timer(1000, 10);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        NpcDialog.show(426, "休咻", [[0, "冷……冷冷冷……冷屎我了！我感觉我要成为冰棍休咻了！"]], ["来吧（帮它取暖）", "你乖，我一会再来！（不取暖）"], [function ():void {
            _npc.removeEventListener(MouseEvent.CLICK, onClick);
            var _loc1_:* = URLUtil.getActivityAnimation("9/xiuxiuAnimation");
            QueueLoader.load(_loc1_, LoadType.SWF, onTakePicLoaded);
        }]);
    }

    private function onTakePicLoaded(param1:ContentInfo):void {
        this._mc = param1.content as MovieClip;
        this._mc.x = this._npc.x - 100;
        this._mc.y = this._npc.y - 100;
        this._thisMC = this._mc["mc"];
        this._timerMC = this._thisMC["timerMC"];
        this._xiuxiuMC = this._thisMC["xiuxiuMC"];
        this._myXiuxiuMC = this._thisMC["myXiuxiuMC"];
        this._mouseCount = 0;
        this.processTakePic();
    }

    private function processTakePic():void {
        LayerManager.focusOnTopLayer();
        this._npc.visible = false;
        LayerManager.topLayer.addChild(this._mc);
        this._timer.start();
        this._xiuxiuMC.buttonMode = true;
        this._xiuxiuMC.addEventListener(MouseEvent.CLICK, this.onXiuXiu);
    }

    private function onXiuXiu(param1:MouseEvent):void {
        ++this._mouseCount;
        if (this._mouseCount == 10) {
            this._thisMC.gotoAndStop(2);
        }
        if (this._mouseCount == 20) {
            this._xiuxiuMC.removeEventListener(MouseEvent.CLICK, this.onXiuXiu);
            this._thisMC.addEventListener(XIUXIU_COMPLETE, this.onComplete);
            this._thisMC.gotoAndStop(3);
        }
    }

    private function onComplete(param1:Event):void {
        this._thisMC.removeEventListener(XIUXIU_COMPLETE, this.onComplete);
        this.win();
    }

    private function onTimer(param1:TimerEvent):void {
        this._timerMC.gotoAndStop(this._timer.currentCount + 1);
    }

    private function onTimerComplete(param1:TimerEvent):void {
        if (this._mouseCount < 20) {
            this.noWin();
        }
    }

    private function win():void {
        this._timer.stop();
        this.clearEvent();
        DisplayUtil.removeForParent(this._mc);
        LayerManager.resetOperation();
        this._xiuxiuThisMC = this._res.getMovieClip("xiuxiuComplete");
        LayerManager.topLayer.addChild(this._xiuxiuThisMC);
        this._xiuxiuThisMC.x = this._npc.x;
        this._xiuxiuThisMC.y = this._npc.y;
        this._npc.visible = false;
        InteractiveRewardManager.requestReward(55, function (param1:Parser_1060):void {
            var parser:Parser_1060 = param1;
            MovieClipUtil.playMc(_xiuxiuThisMC, 2, _xiuxiuThisMC.totalFrames, function ():void {
                if (parser.activityCount == 0) {
                    AlertManager.showAlert("哎哟！我们M5的礼物都被你拿光光了啦！明天再给你吧！");
                } else {
                    parser.showResult();
                }
                DisplayUtil.removeForParent(_xiuxiuThisMC);
            });
        });
    }

    private function noWin():void {
        this._timer.stop();
        this.clearEvent();
        DisplayUtil.removeForParent(this._mc);
        LayerManager.resetOperation();
        NpcDialog.show(426, "休咻", [[0, "看来……靠你是靠不住的了！好吧！！！我要自己燃烧……圣诞节代言人还等着我！！！！我的热情……好似……一把火……"]], ["热血男青年……"], [function ():void {
            _xiuxiuThisMC = _res.getMovieClip("xiuxiuComplete");
            LayerManager.topLayer.addChild(_xiuxiuThisMC);
            _xiuxiuThisMC.x = _npc.x;
            _xiuxiuThisMC.y = _npc.y;
            _npc.visible = false;
            MovieClipUtil.playMc(_xiuxiuThisMC, 2, _xiuxiuThisMC.totalFrames, function ():void {
                DisplayUtil.removeForParent(_xiuxiuThisMC);
            });
        }]);
    }

    private function clearEvent():void {
        if (this._xiuxiuMC) {
            this._xiuxiuMC.addEventListener(MouseEvent.CLICK, this.onXiuXiu);
        }
        if (this._timer) {
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        }
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = null;
        this.clearEvent();
        if (this._npc) {
            this._npc.visible = true;
            DisplayUtil.removeForParent(this._npc);
        }
        if (this._mc) {
            DisplayUtil.removeForParent(this._mc);
        }
        if (this._thisMC) {
            this._thisMC.removeEventListener(XIUXIU_COMPLETE, this.onComplete);
        }
        this._mc = null;
        this._npc = null;
        this._thisMC = null;
        var _loc1_:String = String(URLUtil.getActivityAnimation("9/xiuxiuAnimation"));
        QueueLoader.cancel(_loc1_, this.onTakePicLoaded);
        DisplayUtil.removeForParent(this._xiuxiuThisMC);
        this._xiuxiuThisMC = null;
    }
}
}
