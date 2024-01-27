package com.taomee.seer2.app.processor.quest.handler.branch.quest10121 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class TorchRelayHandler extends QuestMapHandler {


    protected var _questIndex:int = 0;

    protected var _torchMc:MovieClip;

    protected var _x:int = 200;

    protected var _y:int = 200;

    private var _timer:Timer;

    private var _mcTimer:Timer;

    private var _progressBar:MovieClip;

    public function TorchRelayHandler(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.setup();
    }

    protected function setup():void {
        if (TorchRelayTime.isAppearTime()) {
            ServerBufferManager.getServerBuffer(ServerBufferType.TORCH_RELAY3, this.onGetQuestIndex);
        }
    }

    public function onGetQuestIndex(param1:ServerBuffer):void {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        if (this._questIndex > 1) {
            _loc2_ = uint(param1.readDataAtPostion(this._questIndex - 1));
            _loc3_ = uint(param1.readDataAtPostion(this._questIndex));
            if (1 == _loc2_ && 0 == _loc3_) {
                this.initQuestUI();
            }
        } else {
            _loc2_ = uint(param1.readDataAtPostion(this._questIndex));
            if (0 == _loc2_) {
                this.initQuestUI();
            }
        }
    }

    protected function startMcTimer():void {
        Tick.instance.addRender(this.onPlayProgress, 500);
    }

    private function onPlayProgress(param1:int):void {
        if (this._progressBar.currentFrame < this._progressBar.totalFrames) {
            this._progressBar.nextFrame();
        } else {
            Tick.instance.removeRender(this.onPlayProgress);
            this._torchMc["progressBar"].visible = false;
            this._torchMc.gotoAndStop(2);
            CandlePelayHandler.saveQuestIndex(this._questIndex, 1);
            LayerManager.resetOperation();
            this.getAward();
            ModuleManager.toggleModule(URLUtil.getAppModule("TorchRelayPanel"), "火炬手传递");
        }
    }

    protected function getAward():void {
    }

    protected function initQuestUI():void {
        this._torchMc = _processor.resLib.getMovieClip("Candle_10121");
        LayerManager.uiLayer.addChild(this._torchMc);
        this._torchMc.addEventListener(MouseEvent.CLICK, this.startFireup);
        this._torchMc.buttonMode = true;
        this._torchMc.x = 200;
        this._torchMc.y = 200;
        this.adjustPosition();
        this.showGuide();
        this._progressBar = this._torchMc["progressBar"]["progressbar"];
        this._torchMc["progressBar"].visible = false;
    }

    protected function startFireup(param1:MouseEvent):void {
        _processor.hideMouseClickHint();
        this._torchMc.removeEventListener(MouseEvent.CLICK, this.startFireup);
        this.adjustFireup();
        LayerManager.focusOnTopLayer();
        this._torchMc["progressBar"].visible = true;
        this._progressBar.gotoAndStop(1);
        this.startMcTimer();
    }

    protected function adjustFireup():void {
    }

    protected function showGuide():void {
        _processor.showMouseHintAt(200, 200);
    }

    protected function adjustPosition():void {
        this._torchMc.x = this._x;
        this._torchMc.y = this._y;
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._torchMc);
    }
}
}
