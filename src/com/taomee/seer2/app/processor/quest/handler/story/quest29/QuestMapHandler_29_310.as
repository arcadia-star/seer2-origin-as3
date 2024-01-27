package com.taomee.seer2.app.processor.quest.handler.story.quest29 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_29_310 extends QuestMapHandler {


    private var _shaNpc:MovieClip;

    private var _fightMc:MovieClip;

    private var _npcLeave:MovieClip;

    private var _diNpcAnimation:MovieClip;

    private var _askMark:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_29_310(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && QuestManager.isComplete(28)) {
            this.addMouseHint(314, 213);
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.createInprogressNpc();
            this.addAskMark(this._shaNpc);
            if (_quest.getStepData(1, 0) == 0) {
                this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep1_0);
            } else {
                this._diNpcAnimation = _processor.resLib.getMovieClip("mc_1_2");
                this._diNpcAnimation.x = 502;
                this._diNpcAnimation.y = 380;
                _map.content.addChild(this._diNpcAnimation);
                this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep1_1);
            }
        } else if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            _processor.showMouseHintAt(314, 213);
        }
    }

    private function onShowDialogStep1_0(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this.clearAskMark();
        this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep1_0);
        NpcDialog.show(56, "神爪财团老板", [[0, "那些粗鬼难道除了动手就没有别的功能了吗？"]], ["那就不要动手啊……"], [function ():void {
            NpcDialog.show(56, "神爪财团老板", [[0, "我本来就不愿意动手，不然这么多年来我如此忍让是为了什么？"]], ["大老板英明！"], [function ():void {
                _shaNpc.visible = false;
                _fightMc = _processor.resLib.getMovieClip("mc_1_0");
                _map.front.addChild(_fightMc);
                MovieClipUtil.playMc(_fightMc, 1, _fightMc.totalFrames, function ():void {
                    _diNpcAnimation = _processor.resLib.getMovieClip("mc_1_2");
                    _diNpcAnimation.x = 502;
                    _diNpcAnimation.y = 380;
                    _map.content.addChild(_diNpcAnimation);
                    DisplayObjectUtil.removeFromParent(_fightMc);
                    _fightMc = null;
                    _shaNpc.visible = true;
                    _quest.setStepData(1, 0, 1);
                    QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, onUpdateStepBufferStep1_1);
                    QuestManager.setStepBufferServer(_quest.id, 1);
                }, true);
            }]);
        }]);
    }

    private function onUpdateStepBufferStep1_1(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep1_1);
            this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep1_1);
            this.showDialogStep1_1();
        }
    }

    private function onShowDialogStep1_1(param1:MouseEvent):void {
        this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep1_1);
        this.clearAskMark();
        this.showDialogStep1_1();
    }

    private function showDialogStep1_1():void {
        NpcDialog.show(56, "神爪财团老板", [[3, "粗鬼……你，你居然……！！！"]], ["哇……大老板！"], [function ():void {
            NpcDialog.show(55, "神月老大", [[1, "这样子，你是否就有理由和洒家决一死战了？？洒家就在三八跑道线的那一头等你！哈哈哈哈哈！！！"]], ["不对……这不对！！！"], [function ():void {
                NpcDialog.show(56, "神爪财团老板", [[3, "好……这是你逼我的……！这么多年来……我再也不愿意忍受你一分一秒了！！"]], ["（赶快跟去三八跑道线（地）！！）"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
                    QuestManager.completeStep(_quest.id, 1);
                }]);
            }]);
        }]);
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        if (evt.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.clearNpc();
            this.clearDiNpcAnimation();
            this._npcLeave = _processor.resLib.getMovieClip("mc_1_1");
            _map.content.addChild(this._npcLeave);
            MovieClipUtil.playMc(this._npcLeave, 1, this._npcLeave.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(_npcLeave);
                _npcLeave = null;
                _processor.showMouseHintAt(314, 213);
            }, true);
        }
    }

    private function createInprogressNpc():void {
        this._shaNpc = _processor.resLib.getMovieClip("npc_sha");
        this._shaNpc.x = 321;
        this._shaNpc.y = 319;
        _map.content.addChild(this._shaNpc);
        this._shaNpc.buttonMode = true;
    }

    private function addAskMark(param1:MovieClip):void {
        if (this._askMark == null) {
            this._askMark = _processor.resLib.getMovieClip("ask");
        }
        this._askMark.x = 0;
        this._askMark.y = -param1.height;
        param1.addChild(this._askMark);
    }

    private function clearNpc():void {
        if (this._shaNpc) {
            this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep1_1);
            this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep1_0);
            DisplayObjectUtil.removeFromParent(this._shaNpc);
            this._shaNpc = null;
        }
    }

    private function clearFightMc():void {
        if (this._fightMc) {
            DisplayObjectUtil.removeFromParent(this._fightMc);
            this._fightMc = null;
        }
    }

    private function clearNpcLeave():void {
        if (this._npcLeave) {
            DisplayObjectUtil.removeFromParent(this._npcLeave);
            this._npcLeave = null;
        }
    }

    private function clearDiNpcAnimation():void {
        if (this._diNpcAnimation) {
            DisplayObjectUtil.removeFromParent(this._diNpcAnimation);
            this._diNpcAnimation = null;
        }
    }

    private function clearAskMark():void {
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
            this._askMark = null;
        }
    }

    private function addMouseHint(param1:Number, param2:Number):void {
        if (this._mouseHint == null) {
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
            LayerManager.moduleLayer.addChild(this._mouseHint);
        } else {
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
        }
    }

    private function clearMouseHint():void {
        if (this._mouseHint) {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
            this._mouseHint = null;
        }
    }

    override public function processMapDispose():void {
        this.clearMouseHint();
        DisplayObjectUtil.removeFromParent(_processor.mouseHint);
        this.clearAskMark();
        this.clearDiNpcAnimation();
        this.clearFightMc();
        this.clearNpcLeave();
        this.clearNpc();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep1_1);
        super.processMapDispose();
    }
}
}
