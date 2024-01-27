package com.taomee.seer2.app.processor.quest.handler.main.quest81 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_81_10 extends QuestMapHandler {


    public function QuestMapHandler_81_10(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(questID)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep();
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 5) && !QuestManager.isStepComplete(questID, 6)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep1);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "81_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
            QuestManager.accept(_quest.id);
        }
    }

    private function onStep1(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "81_5_0") {
            if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 5) && !QuestManager.isStepComplete(questID, 6)) {
                this.initStep2();
            }
        }
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep();
        }
    }

    private function onComplete(param1:QuestEvent):void {
        MobileManager.showMoileVec(MobileType.NPC);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 60);
    }

    private function onComplete1(param1:QuestEvent):void {
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete1);
        SceneManager.changeScene(SceneType.COPY, 80343);
    }

    private function initStep():void {
        NpcDialog.show(400, "小赛尔", [[0, "我们到了南半球，先去了虫群氏族，然后终于找到了超能氏族，在那里……"]], ["…小赛尔把前因后果告诉船长…"], [function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "最后，在我们帮助超能氏族寻找能量碎片的时候，意外的碰到了小梦，也意外的发现，能量碎片或许就是传说中的“永恒能源”！"]], [" ！！"], [function ():void {
                NpcDialog.show(400, "小赛尔", [[0, "超能氏族的朋友们感谢我们对他们的帮助，所以将一部分碎片赠送给了我们，让我们去拯救自己的家园。"]], [" …"], [function ():void {
                    initContinue();
                }]);
            }]);
        }]);
    }

    private function initContinue():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("81_0"), function ():void {
            initStep1();
        });
    }

    private function initStep1():void {
        MovieClipUtil.playHahaTalk(URLUtil.getQuestAnimation("81/quest81Animation1"), 4, [770, 475], function ():void {
            NpcDialog.show(1, "船长辛迪", [[0, "永恒能源，永恒能源啊！没想到，真的找到了永恒能源！地球、我们的家园地球，有救了！"]], ["嗯！"], [function ():void {
                NpcDialog.show(1, "船长辛迪", [[0, "但是，赛尔号2飞船现在还被阿卡迪亚星吸引着，暂时无法脱离。那么，这个艰巨的任务就得交给你们了。小赛尔，你们有没有信心和勇气，将“永恒能源”带回地球？"]], ["有！"], [function ():void {
                    NpcDialog.show(11, "多罗", [[0, "船长你放心吧！我们一定可以将它带回地球、拯救我们的家园的！"]], ["是的！"], [function ():void {
                        NpcDialog.show(10, "巴蒂", [[0, "船长，既然赛尔号2无法返航，那么我们该怎样前往地球呢？"]], [" 还有其他的飞船吗？"], [function ():void {
                            NpcDialog.show(1, "船长辛迪", [[0, "嗯，你们可以乘坐“诺亚方舟”号飞船重返地球。这艘飞船原本是为了躲避未知的大灾难而建造的，没想到可以在这里发挥作用。"]], [" …"], [function ():void {
                                NpcDialog.show(1, "船长辛迪", [[0, "这是我的精灵“雷霆”，它原本是盘踞于阿卡迪亚星上的一道闪电，偶然的情况下我收服、驯化了它。它的实力很强，但是之前，它为了救我而受了伤，沉睡了很长一段时间。"]], [" …"], [function ():void {
                                    NpcDialog.show(1, "船长辛迪", [[0, "前方道路上有太多的未知凶险，虽然雷霆的实力还没有完全恢复，但有了它的帮助和护卫，你们想必会安全一些。"]], [" 谢谢船长！"], [function ():void {
                                        NpcDialog.show(1, "船长辛迪", [[0, "去和赛尔号2上的各位船员告个别吧，大家的祝福，想必也能够给你们带来帮助和快乐。"]], ["（前往教官室）"], [function ():void {
                                            initContinues();
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        });
    }

    private function initContinues():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        QuestManager.completeStep(questID, 1);
    }

    private function initStep2():void {
        this.initContinue1();
    }

    private function initContinue1():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onComplete1);
        QuestManager.completeStep(questID, 6);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }
}
}
