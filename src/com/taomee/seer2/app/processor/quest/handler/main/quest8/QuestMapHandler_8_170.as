package com.taomee.seer2.app.processor.quest.handler.main.quest8 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class QuestMapHandler_8_170 extends QuestMapHandler {


    private var _stepAnimation1:MovieClip;

    private var _stepArea1:MovieClip;

    private var _npcTalkContainer:MovieClip;

    private var _npcTalkContent:MovieClip;

    private var _npcTalkContentIndex:int;

    private var _npcTalkBtn:SimpleButton;

    private var _npcTalkBtnRightIndex:int;

    private var _npcTalkBtnIndex:int;

    public function QuestMapHandler_8_170(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.extractAssets();
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            this._stepAnimation1.gotoAndStop(2);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
        } else if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (!_quest.isStepCompete(1)) {
                this.processStep1();
            } else if (!_quest.isStepCompete(2)) {
                this.processStep2();
            } else if (!_quest.isStepCompete(3)) {
                this.processStep3();
            } else if (!_quest.isStepCompete(4)) {
                this.processStep4();
            }
            if (Boolean(_quest.isStepCompete(5)) && !_quest.isStepCompete(6)) {
                this.processStep6();
            }
            if (!_quest.isStepCompete(3)) {
                this._stepAnimation1.gotoAndStop(2);
            } else {
                this._stepAnimation1.gotoAndStop(this._stepAnimation1.totalFrames);
            }
        }
    }

    private function extractAssets():void {
        this._stepAnimation1 = _map.content["quest_8"];
        this._stepArea1 = this._stepAnimation1["click"];
    }

    private function onAcceptQuest(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
            this.processStep1();
        }
    }

    private function processStep1():void {
        DialogPanel.showForSimple(NpcUtil.getSeerNpcId(), "我", [[0, "大块头大哥请问……"]], "（好凶神恶煞的大块头）", function ():void {
            DialogPanel.showForSimple(25, "莱斯", [[4, "去去去！一边玩去！我可没功夫理你！"]], "（老虎不发威！当我病猫了！）", function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
                QuestManager.completeStep(_quest.id, 1);
            });
        });
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.processStep2();
        }
    }

    private function processStep2():void {
        _processor.showMouseHintOver(this._stepArea1);
        this._stepArea1.buttonMode = true;
        this._stepArea1.addEventListener(MouseEvent.CLICK, this.onClickStepArea1);
    }

    private function onClickStepArea1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._stepArea1.buttonMode = false;
        this._stepArea1.removeEventListener(MouseEvent.CLICK, this.onClickStepArea1);
        MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("8/fullScreen_0"), function ():void {
            _npcTalkBtn = UIManager.getButton("UI_NpcTalkBtn");
            _npcTalkBtn.x = 790;
            _npcTalkBtn.y = 522;
            UILoader.load(URLUtil.getQuestAnimation("8/npcTalk_0"), LoadType.SWF, onLoadNpcTalkComplete);
        });
    }

    private function onLoadNpcTalkComplete(param1:ContentInfo):void {
        this._npcTalkContainer = param1.content as MovieClip;
        LayerManager.focusOnTopLayer();
        LayerManager.topLayer.addChild(this._npcTalkContainer);
        this._npcTalkContentIndex = 1;
        this.playNpcTalk();
    }

    private function playNpcTalk():void {
        if (this._npcTalkContentIndex == 4) {
            DisplayObjectUtil.removeFromParent(this._npcTalkContainer);
            LayerManager.resetOperation();
            DialogPanel.showForSimple(25, "莱斯", [[4, "弟弟！你说那个被感染的小海马会逃到哪里去？抓它可有生命危险！"]], "嗯嗯？小海马？", function ():void {
                DialogPanel.showForSimple(26, "莱克", [[2, "想到还要去抓那个小海马我就头疼！真不知道小海马怎么会被感染的……"]], "（多罗似乎有话要说）", function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep2);
                    QuestManager.completeStep(_quest.id, 2);
                });
            });
        } else {
            switch (this._npcTalkContentIndex) {
                case 1:
                    this._npcTalkBtnRightIndex = 1;
                    break;
                case 2:
                    this._npcTalkBtnRightIndex = 3;
                    break;
                case 3:
                    this._npcTalkBtnRightIndex = 1;
            }
            MovieClipUtil.getChildList(this._npcTalkContainer, this._npcTalkContentIndex, [0], function (param1:Vector.<DisplayObject>):void {
                var children:Vector.<DisplayObject> = param1;
                _npcTalkContent = children[0] as MovieClip;
                MovieClipUtil.playMc(_npcTalkContent, 1, "choose", function ():void {
                    playNpcChoose(_npcTalkContent);
                });
            });
        }
    }

    private function playNpcChoose(param1:MovieClip):void {
        var mc:MovieClip = param1;
        MovieClipUtil.getChildList(mc, "choose", ["btn1", "btn2", "btn3"], function (param1:Vector.<DisplayObject>):void {
            var btn1:SimpleButton = null;
            var btn2:SimpleButton = null;
            var btn3:SimpleButton = null;
            var onClickBtn:Function = null;
            var children:Vector.<DisplayObject> = param1;
            onClickBtn = function (param1:MouseEvent):void {
                var evt:MouseEvent = param1;
                btn1.removeEventListener(MouseEvent.CLICK, onClickBtn);
                btn2.removeEventListener(MouseEvent.CLICK, onClickBtn);
                btn3.removeEventListener(MouseEvent.CLICK, onClickBtn);
                _npcTalkBtnIndex = int(evt.currentTarget.name.slice(3));
                MovieClipUtil.playMc(mc, "start" + _npcTalkBtnIndex, "mid" + _npcTalkBtnIndex, function ():void {
                    LayerManager.topLayer.addChild(_npcTalkBtn);
                    _npcTalkBtn.addEventListener(MouseEvent.CLICK, onClickNpcBtn1);
                });
            };
            btn1 = children[0] as SimpleButton;
            btn2 = children[1] as SimpleButton;
            btn3 = children[2] as SimpleButton;
            btn1.addEventListener(MouseEvent.CLICK, onClickBtn);
            btn2.addEventListener(MouseEvent.CLICK, onClickBtn);
            btn3.addEventListener(MouseEvent.CLICK, onClickBtn);
        });
    }

    private function onClickNpcBtn1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._npcTalkBtn);
        this._npcTalkBtn.removeEventListener(MouseEvent.CLICK, this.onClickNpcBtn1);
        MovieClipUtil.playMc(this._npcTalkContent, "mid" + this._npcTalkBtnIndex, "end" + this._npcTalkBtnIndex, function ():void {
            if (_npcTalkBtnIndex == _npcTalkBtnRightIndex) {
                ++_npcTalkContentIndex;
                playNpcTalk();
            } else {
                playNpcTalk();
            }
        });
    }

    private function onCompleteStep2(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            this.processStep3();
        }
    }

    private function processStep3():void {
        _processor.showMouseHintOver(this._stepArea1);
        this._stepArea1.buttonMode = true;
        this._stepArea1.addEventListener(MouseEvent.CLICK, this.onClickStepArea2);
    }

    private function onClickStepArea2(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._stepArea1.buttonMode = false;
        this._stepArea1.removeEventListener(MouseEvent.CLICK, this.onClickStepArea2);
        MovieClipUtil.playMc(this._stepAnimation1, 2, this._stepAnimation1.totalFrames, function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep3);
            QuestManager.completeStep(_quest.id, 3);
        }, true);
    }

    private function onCompleteStep3(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
            this.processStep4();
        }
    }

    private function processStep4():void {
        _processor.showMouseHintAt(36, 126);
    }

    private function processStep6():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("8/fullScreen_1"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep6);
            QuestManager.completeStep(_quest.id, 6);
        });
    }

    private function onCompleteStep6(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep6);
            SceneManager.changeScene(SceneType.LOBBY, 160);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
        if (this._npcTalkBtn) {
            this._npcTalkBtn.removeEventListener(MouseEvent.CLICK, this.onClickNpcBtn1);
        }
        if (this._stepArea1) {
            this._stepArea1.removeEventListener(MouseEvent.CLICK, this.onClickStepArea1);
            this._stepArea1.removeEventListener(MouseEvent.CLICK, this.onClickStepArea2);
        }
    }
}
}
