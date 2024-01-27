package com.taomee.seer2.app.processor.quest.handler.main.quest10 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.processor.quest.handler.main.QuestGame;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10_203 extends QuestMapHandler {


    private var _stepAnimation1:MovieClip;

    private var _stepAnimation2:MovieClip;

    private var _stepAnimation3:MovieClip;

    private var _stepClick_3_0:MovieClip;

    private var _stepAnimation4:MovieClip;

    private var _game:QuestGame;

    public function QuestMapHandler_10_203(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.extractAssets();
        if (_quest.isStepCompletable(4)) {
            this.processStep4();
        } else if (_quest.isStepCompletable(5)) {
            this.processStep5();
        } else if (_quest.isStepCompletable(6)) {
            _processor.showMouseHintAt(280, 50);
        }
    }

    private function extractAssets():void {
        this._stepAnimation1 = _processor.getMcFromLib("mc_203_1");
        this._stepAnimation2 = _processor.getMcFromLib("mc_203_2");
        this._stepAnimation3 = _processor.getMcFromLib("mc_203_3");
        this._stepClick_3_0 = this._stepAnimation3["click"];
        this._stepAnimation4 = _processor.getMcFromLib("mc_203_4");
        this._game = new QuestGame_10_203(_processor.resLib.getMovieClip("mc_203_5"), this.onGameHide);
    }

    private function processStep4():void {
        _map.content.addChild(this._stepAnimation1);
        MovieClipUtil.playMc(this._stepAnimation1, 1, this._stepAnimation1.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_stepAnimation1);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10_0"), 5, [[1, 0]], function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "多罗！原来你这么聪明！太棒了！终于有办法了！快把你们都伪装起来吧！"]], ["（伪装成什么呢？）"], [function ():void {
                    _game.show();
                }]);
            });
        }, true);
    }

    private function onGameHide(param1:Boolean):void {
        if (param1) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            QuestManager.completeStep(_quest.id, 4);
        }
    }

    private function onCompleteStep4(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            this.processStep5();
        }
    }

    private function processStep5():void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            _map.content.addChild(this._stepAnimation3);
            MovieClipUtil.playMc(this._stepAnimation3, 1, this._stepAnimation3.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(_stepAnimation3);
                _map.content.addChild(_stepAnimation4);
                MovieClipUtil.playMc(_stepAnimation4, 1, _stepAnimation4.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_stepAnimation4);
                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "可恶！又让他给逃了！！！！先回去看看洛水吧！不知道她醒来吗！"]], [" 水脉氏族主城"], [function ():void {
                        _processor.showMouseHintAt(280, 50);
                        QuestManager.completeStep(_quest.id, 5);
                    }]);
                }, true);
            }, true);
        } else {
            _map.content.addChild(this._stepAnimation2);
            MovieClipUtil.playMc(this._stepAnimation2, 1, this._stepAnimation2.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(_stepAnimation2);
                showFightFlag();
            });
        }
    }

    private function showFightFlag():void {
        this._stepAnimation3.gotoAndStop(1);
        _map.content.addChild(this._stepAnimation3);
        this._stepClick_3_0.addEventListener(MouseEvent.CLICK, this.onClickStepAnimation3);
        _processor.showMouseHintAt(380, 220);
        DisplayObjectUtil.enableButtonMode(this._stepClick_3_0);
    }

    private function onClickStepAnimation3(param1:MouseEvent):void {
        this._stepClick_3_0.removeEventListener(MouseEvent.CLICK, this.onClickStepAnimation3);
        _processor.hideMouseClickHint();
        DisplayObjectUtil.disableButtonMode(this._stepClick_3_0);
        FightManager.startFightWithWild(10, null, this.showFightFlag);
    }

    override public function processMapDispose():void {
        this._game.dispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
        this._stepClick_3_0.removeEventListener(MouseEvent.CLICK, this.onClickStepAnimation3);
        super.processMapDispose();
    }
}
}
