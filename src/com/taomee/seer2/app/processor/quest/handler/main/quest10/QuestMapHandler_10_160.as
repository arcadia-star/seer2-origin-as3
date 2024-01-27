package com.taomee.seer2.app.processor.quest.handler.main.quest10 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_10;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10_160 extends QuestMapHandler {


    private var _stepAnimation1:MovieClip;

    private var _stepAnimation2:MovieClip;

    private var _stepAnimation3:MovieClip;

    private var _stepAnimation4:MovieClip;

    private var _npc23:Mobile;

    private var _npc24:Mobile;

    public function QuestMapHandler_10_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.extractAssets();
        if (_quest.isStepCompletable(2)) {
            this._npc23.visible = false;
            this._npc24.visible = false;
            this.processStep2();
        } else if (_quest.isStepCompletable(3)) {
            this._npc23.visible = false;
            this._npc24.visible = false;
            this.processStep3();
        } else if (_quest.isStepCompletable(6)) {
            this.processStep6();
        }
    }

    private function extractAssets():void {
        this._stepAnimation1 = _processor.getMcFromLib("mc_160_1");
        this._stepAnimation2 = _processor.getMcFromLib("mc_160_2");
        this._stepAnimation3 = _processor.getMcFromLib("mc_160_3");
        this._stepAnimation4 = _processor.getMcFromLib("mc_160_4");
        this._npc23 = MobileManager.getMobile(23, MobileType.NPC);
        this._npc24 = MobileManager.getMobile(24, MobileType.NPC);
    }

    private function processStep2():void {
        _map.front.addChild(this._stepAnimation1);
        MovieClipUtil.playMc(this._stepAnimation1, 1, this._stepAnimation1.totalFrames, function ():void {
            NpcDialog.show(11, "多罗", [[0, "HOHO……原来……"]], ["（被巴蒂打断）"], [function ():void {
                NpcDialog.show(10, "巴蒂", [[3, "别以为人家跟你一样嗜睡！笨蛋！对了，队长！问题是不是出在梦境里？"]], [" 梦境？精灵？难道和精灵有关？"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep2);
                    QuestManager.completeStep(_quest.id, 2);
                }]);
            }]);
        }, true);
    }

    private function onCompleteStep2(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            this.processStep3();
        }
    }

    private function processStep3():void {
        if (QuestProcessor_10(_processor).petStep == 0) {
            _map.front.addChild(this._stepAnimation2);
            MovieClipUtil.playMc(this._stepAnimation2, 1, this._stepAnimation2.totalFrames, function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[4, "小小葵怎么会出现在这里！梦境精灵小小葵！问题就在这！快追上去！"]], [" （HOHO！我也还是很聪明的嘛！）"], [function ():void {
                    DisplayObjectUtil.removeFromParent(_stepAnimation2);
                    _map.content.addChild(_stepAnimation3);
                    MovieClipUtil.playMc(_stepAnimation3, 1, _stepAnimation3.totalFrames, function ():void {
                        DisplayObjectUtil.removeFromParent(_stepAnimation3);
                        QuestProcessor_10(_processor).addPetStep();
                        _processor.showMouseHintAt(-90, 460);
                    }, true);
                }]);
            }, true);
        } else if (QuestProcessor_10(_processor).petStep > 0) {
            _processor.showMouseHintAt(-90, 460);
        }
    }

    private function processStep6():void {
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED, this.onDialogClose);
    }

    private function onDialogClose(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "10_6") {
            DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED, this.onDialogClose);
            _map.content.addChild(this._stepAnimation4);
            this._stepAnimation4.addEventListener(MouseEvent.CLICK, this.onClickStepAnimation4);
            _processor.showMouseHintOver(this._stepAnimation4);
            DisplayObjectUtil.enableButtonMode(this._stepAnimation4);
        }
    }

    private function onClickStepAnimation4(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._stepAnimation4);
        DisplayObjectUtil.disableButtonMode(this._stepAnimation4);
        this._stepAnimation4.removeEventListener(MouseEvent.CLICK, this.onClickStepAnimation4);
        _processor.hideMouseClickHint();
        NpcDialog.show(14, "S", [[1, "走着瞧！你不会每次都这么幸运的！那个水系守护兽一定会是我的囊中之物！"]], ["S……是S！！！！"], [function ():void {
            QuestManager.completeStep(_quest.id, 6);
        }]);
    }

    override public function processMapDispose():void {
        if (this._npc23) {
            this._npc23.visible = true;
            this._npc24.visible = true;
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED, this.onDialogClose);
        this._stepAnimation4.removeEventListener(MouseEvent.CLICK, this.onClickStepAnimation4);
        super.processMapDispose();
    }
}
}
