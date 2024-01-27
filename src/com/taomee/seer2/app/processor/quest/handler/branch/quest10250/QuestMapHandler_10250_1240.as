package com.taomee.seer2.app.processor.quest.handler.branch.quest10250 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class QuestMapHandler_10250_1240 extends QuestMapHandler {


    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_10250_1240(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(10250)) {
            this.initAccept();
        }
        if (QuestManager.isAccepted(10250) && QuestManager.isComplete(10250) == false) {
            if (QuestManager.isStepComplete(10250, 1) == false) {
                this.initStep1();
            }
            if (QuestManager.isStepComplete(10250, 5) && QuestManager.isStepComplete(10250, 6) == false) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (DialogPanelEventData(evt.content).params == "10250_6") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            DayLimitManager.getDoCount(1583, function (param1:int):void {
                var count:int = param1;
                if (count < 2) {
                    NpcDialog.show(324, "白雪公主", [[0, "我能把他们复原，不过能力有限，每天只能够恢复2颗蚀之珠。"]], ["那我们快开始吧！（交出蚀之碎片）"], [function ():void {
                        SwapManager.swapItem(3654, 1, function (param1:IDataInput):void {
                            new SwapInfo(param1);
                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunSecond_1"), toReplay);
                        });
                    }]);
                } else {
                    NpcDialog.show(324, "白雪公主", [[0, "我的力量已经耗尽，明天才能恢复。"]], ["那我明天再来。"], [function ():void {
                    }]);
                }
            });
        }
    }

    private function toReplay():void {
        var num1:int = ItemManager.getSpecialItem(605392) != null ? int(ItemManager.getSpecialItem(605392).quantity) : 0;
        if (num1 >= 8) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunSecond_2"), function ():void {
                SwapManager.swapItem(3655, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    QuestManager.completeStep(10250, 6);
                    ModuleManager.showAppModule("ShiHunBeastPanel", "2");
                });
            });
        } else {
            ModuleManager.showAppModule("ShiHunBeastPanel", "2");
        }
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 10250) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        NpcDialog.show(324, "白雪公主", [[0, "蚀魂兽已经隐居了许多年，我的父辈都没有见过本族的守护魂兽。如今，它突然出现，也许是遇到危险了！不管怎样，只有找到蚀魂兽，我们才能知道原因。 "]], ["我们该去哪找蚀魂兽呢？"], [function ():void {
            NpcDialog.show(324, "白雪公主", [[0, "传说蚀魂兽一直隐居在虫林仙境之中，但是它将入口封闭了起来，打开入口需要激活8颗蚀之珠。 "]], ["蚀之珠在哪？我这就去拿！"], [function ():void {
                NpcDialog.show(324, "白雪公主", [[0, "蚀魂兽不想让人找到自己，所以将蚀之珠藏在了某些精灵石像里。而我并不知道这些石像现在在哪。也许，氏族的其他人会知道吧。你可以去后花园问问匹喏曹。"]], ["没问题！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                    QuestManager.completeStep(questID, 1);
                }]);
            }]);
        }]);
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == questID && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 251;
            this._mouseHint.y = 519;
            _map.front.addChild(this._mouseHint);
        }
    }
}
}
