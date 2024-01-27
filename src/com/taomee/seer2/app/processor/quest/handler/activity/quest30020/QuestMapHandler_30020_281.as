package com.taomee.seer2.app.processor.quest.handler.activity.quest30020 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class QuestMapHandler_30020_281 extends QuestMapHandler {

    public static const SIGN:int = 19;

    private static var _isWildPet:Boolean = true;


    private var _npc:MovieClip;

    private var _correctIndex:int;

    private var _answerPanel:MovieClip;

    private var _finishMc:MovieClip;

    private var _timer:Timer;

    private var _blackFontMc:MovieClip;

    private var _isCapture:Boolean = false;

    private var _isDoCaptureOperation:Boolean = false;

    private var _hearFontMc:MovieClip;

    public function QuestMapHandler_30020_281(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.getQuest(30020).status == QuestStatus.ACCEPTABLE) {
            this.initListener();
        }
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this._isDoCaptureOperation) {
                if (this._isCapture) {
                    this.playFontMovie1();
                } else {
                    this.finishActivity();
                }
            }
        }
    }

    private function playFontMovie1():void {
        this._hearFontMc = _processor.resLib.getMovieClip("HearFont_30020");
        LayerManager.topLayer.addChild(this._hearFontMc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(this._hearFontMc, 0, this._hearFontMc.totalFrames - 1, function ():void {
            LayerManager.resetOperation();
            _hearFontMc.stop();
            DisplayObjectUtil.removeFromParent(_hearFontMc);
            finishActivity();
        });
    }

    private function finishActivity():void {
        this._isCapture = false;
        _isWildPet = true;
        this._isDoCaptureOperation = false;
        DisplayObjectUtil.removeFromParent(this._npc);
        this._finishMc = _processor.resLib.getMovieClip("HeadMc_30020");
        LayerManager.topLayer.addChild(this._finishMc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(this._finishMc, 0, this._finishMc.totalFrames - 1, function ():void {
            LayerManager.resetOperation();
            LayerManager.resetOperation();
            DisplayObjectUtil.removeFromParent(_finishMc);
        });
        this._npc = null;
        this._answerPanel = null;
        this._finishMc = null;
        this._timer = null;
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.startError);
    }

    private function initListener():void {
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onReceived);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
    }

    private function createTempoaryNpc():void {
        LayerManager.focusOnTopLayer();
        this._npc = _processor.resLib.getMovieClip("Npc_30020");
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            (this._npc["mc" + _loc1_] as MovieClip).stop();
            _loc1_++;
        }
        LayerManager.topLayer.addChild(this._npc);
        this.playTalk1();
    }

    private function playTalk1():void {
        var data:XML = new XML("<dialog npcId=\"500\" npcName=\"帕帕米拉\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[我伪装的这么好都能被你发现？咦...难道是我造型不够好吗？对了你说我染什么造型比较好看呢？]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[染发...囧]]></reply>" + "<reply action=\"close\" params=\"no\"><![CDATA[我觉得我还是不回答了]]></reply></branch>" + "</dialog>");
        var dialogDefinition:DialogDefinition = new DialogDefinition(data);
        DialogPanel.showForCommon(dialogDefinition, function (param1:String):void {
            var eventString:String = param1;
            if (eventString == "yes") {
                _blackFontMc = _processor.resLib.getMovieClip("BlackFont_30020");
                LayerManager.topLayer.addChild(_blackFontMc);
                MovieClipUtil.playMc(_blackFontMc, 0, _blackFontMc.totalFrames - 1, function ():void {
                    DisplayObjectUtil.removeFromParent(_blackFontMc);
                    playRandomMovie();
                });
            } else {
                finishActivity();
            }
        });
    }

    private function playRandomMovie():void {
        var _loc1_:int = int(Math.random() * 1000000 % 3);
        this._correctIndex = _loc1_;
        (this._npc["mc" + _loc1_] as MovieClip).gotoAndPlay(2);
        (this._npc["npc"] as MovieClip).addEventListener(MouseEvent.CLICK, this.beginAnswer);
        _processor.showMouseHintAt(560, 350);
    }

    private function beginAnswer(param1:MouseEvent):void {
        var _loc2_:int = 0;
        _processor.hideMouseClickHint();
        (this._npc["npc"] as MovieClip).removeEventListener(MouseEvent.CLICK, this.beginAnswer);
        this._answerPanel = _processor.resLib.getMovieClip("AnswerPanel");
        LayerManager.topLayer.addChild(this._answerPanel);
        _loc2_ = 0;
        while (_loc2_ < 3) {
            (this._answerPanel["answer" + _loc2_] as MovieClip).buttonMode = true;
            (this._answerPanel["answer" + _loc2_] as MovieClip).addEventListener(MouseEvent.CLICK, this.correctHandler);
            _loc2_++;
        }
    }

    private function correctHandler(param1:MouseEvent):void {
        if (!this._timer) {
            this._timer = new Timer(3000);
            this._timer.addEventListener(TimerEvent.TIMER, this.startFight);
        }
        var _loc2_:String = (param1.target as MovieClip).name;
        var _loc3_:int = parseInt(_loc2_.charAt(_loc2_.length - 1));
        if (_loc3_ == this._correctIndex) {
            this.removeAnswerBtn();
            (this._npc["npc"] as MovieClip).gotoAndStop(15);
            this._timer.reset();
            this._timer.start();
        } else {
            this.removeAnswerBtn();
            (this._npc["npc"] as MovieClip).gotoAndStop(35);
            this.playTalk2();
        }
    }

    private function removeAnswerBtn():void {
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            (this._answerPanel["answer" + _loc1_] as MovieClip).removeEventListener(MouseEvent.CLICK, this.correctHandler);
            DisplayObjectUtil.removeFromParent(this._answerPanel);
            _loc1_++;
        }
        _loc1_ = 0;
        while (_loc1_ < 3) {
            (this._npc["mc" + _loc1_] as MovieClip).stop();
            _loc1_++;
        }
    }

    private function playTalk2():void {
        var data:XML = new XML("<dialog npcId=\"500\" npcName=\"帕帕米拉\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[搞什么...好没有艺术气息哦！我的秀发...55555...\"伦家\"走了啦！]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[...(下次注意看看周围的色彩)]]></reply></branch>" + "</dialog>");
        var dialogDefinition:DialogDefinition = new DialogDefinition(data);
        DialogPanel.showForCommon(dialogDefinition, function ():void {
            finishActivity();
        });
    }

    private function startFight(param1:TimerEvent):void {
        this._timer.reset();
        DisplayObjectUtil.removeFromParent(this._npc);
        this._isDoCaptureOperation = true;
        LayerManager.resetOperation();
        FightManager.startFightWithWild(119);
        Connection.addCommandListener(CommandSet.FIGHT_CATCH_PET_1031, this.onCaptureComplete);
        FightManager.addEventListener(FightStartEvent.START_ERROR, this.startError);
    }

    private function startError(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.startError);
        this.finishActivity();
    }

    private function onCaptureComplete(param1:MessageEvent):void {
        var _loc2_:LittleEndianByteArray = param1.message.getRawData();
        _loc2_ = _loc2_.clone();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        if (_loc3_ > 0) {
            this._isCapture = true;
        }
    }

    private function onReceived(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onReceived);
        var _loc2_:LittleEndianByteArray = param1.message.getRawData();
        _loc2_ = _loc2_.clone();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        if (SIGN == _loc3_) {
            this.createTempoaryNpc();
        }
    }

    private function onMapSwitchComplete(param1:SceneEvent):void {
    }
}
}
