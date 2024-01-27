package com.taomee.seer2.app.processor.quest.handler.story.quest44 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_44_810 extends QuestMapHandler {


    private var smearyPet:MovieClip;

    public function QuestMapHandler_44_810(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.battleResultHandler();
        }
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initStep2();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.initStep3();
        }
    }

    private function initStep3():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playFullAnimation);
    }

    private function initStep2():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playComic);
    }

    private function initStep1():void {
        this.smearyPet = _processor.resLib.getMovieClip("smearyPet");
        this.smearyPet.mouseEnabled = false;
        this._map.content.addChild(this.smearyPet);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onWhaleDia);
    }

    private function onWhaleDia(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "whaleDia44") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onWhaleDia);
            NpcDialog.show(482, "污染的蓝虎鲸", [[0, "污染……污染……进入黑暗吧……！！"]], [" 蓝虎鲸的样子不太对！！"], [function ():void {
                FightManager.startFightWithWild(92);
            }]);
        }
    }

    private function battleResultHandler():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("44_0"), function ():void {
            NpcDialog.show(481, "耐普图隆", [[0, "回去吧孩子们，回到那片宁静的水源去。无论多少次，我都会让你们恢复纯净，只要你们心中还有羁绊……"]], [" 精灵被污染，好像在水脉氏族也发生过。"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete1);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        });
    }

    private function onStepComplete1(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            this._map.content.removeChild(this.smearyPet);
            this.smearyPet = null;
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete1);
            this.initStep2();
        }
    }

    private function playFullAnimation(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "playAnimation44_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playFullAnimation);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("44_1"), function ():void {
                NpcDialog.show(481, "耐普图隆", [[0, "也许我们可以试着将星球的未来托付给你们。爱丽斯，你也赞成我这样做吧？能够让我们从黑暗中挣扎出来的，是羁绊——"]], [" 我会努力的！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                    QuestManager.completeStep(_quest.id, 3);
                }]);
            });
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 44) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function playComic(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "playComic44_810_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playComic);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("44_1"), 3, [[1, 0]], function ():void {
                NpcDialog.show(481, "耐普图隆", [[0, "据说，水脉的族人吞下了那颗果实，变成了守护整个氏族的脉灵兽。"]], [" 嗯……洛水也守护着它呢。"], [function ():void {
                    NpcDialog.show(481, "耐普图隆", [[0, "你知道那里发生的事情？洛水是谁？爱丽斯还好吗？"]], [" 将自己在水脉氏族的经历告诉耐普图隆"], [function ():void {
                        NpcDialog.show(481, "耐普图隆", [[1, "太好了……爱丽斯，我们天各一方，却一直共同努力着。"]], [" 实在是太好了。"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete2);
                            QuestManager.completeStep(_quest.id, 2);
                        }]);
                    }]);
                }]);
            });
        }
    }

    private function onStepComplete2(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
            this.initStep3();
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onWhaleDia);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playFullAnimation);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playComic);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.smearyPet) {
            if (this._map.content.contains(this.smearyPet)) {
                this._map.content.removeChild(this.smearyPet);
                this.smearyPet = null;
            }
        }
        super.processMapDispose();
    }
}
}
