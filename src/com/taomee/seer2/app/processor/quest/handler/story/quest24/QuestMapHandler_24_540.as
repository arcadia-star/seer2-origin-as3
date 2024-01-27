package com.taomee.seer2.app.processor.quest.handler.story.quest24 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_24_540 extends QuestMapHandler {


    private var _mc_1:MovieClip;

    public function QuestMapHandler_24_540(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initMc1();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initMc2();
        }
    }

    private function initMc1():void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function initMc2():void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onClick2);
    }

    private function onClick2(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(444, "目之魂", [[0, "命运之人啊……我知道你有很多疑问……灵魂故乡……能源之树……以及，我究竟是谁……"]], ["疑问多了去了！"], [function ():void {
            initQuest1();
        }]);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        ItemManager.requestItemList(function ():void {
            if (ItemManager.getItemQuantityByReferenceId(400215) >= 1) {
                NpcDialog.show(444, "目之魂", [[0, "命运之人啊……我知道你有很多疑问……灵魂故乡……能源之树……以及，我究竟是谁……"]], ["疑问多了去了！"], [function ():void {
                    if (QuestManager.isCanAccepted(_quest.id)) {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                        QuestManager.accept(_quest.id);
                    }
                }]);
            } else {
                NpcDialog.show(444, "目之魂", [[0, "你……并不知道我的过去……只有拥有记忆碎片的人……"]], ["（……）"], [function ():void {
                }]);
            }
        });
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initQuest1();
        }
    }

    private function initQuest1():void {
        NpcDialog.show(444, "目之魂", [[0, "你还记得那个回忆碎片吗？其实……现在我还能维持这个形象在你面前……仅仅是因为那个碎片……"]], ["咦？我不明白……"], [function ():void {
            NpcDialog.show(444, "目之魂", [[0, "握紧碎片……回忆起你我曾经并肩奋战的往事吧……"]], ["曾经……"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("24_0"), function ():void {
                    NpcDialog.show(444, "目之魂", [[0, "如果我曾经的使命是考验……那么，接下来我要做的一切，就是相信……请相信你自己……也相信我一直都会在你身边……"]], ["目之魂……"], [function ():void {
                        NpcDialog.show(444, "目之魂", [[0, "那么……再会吧……"]], ["等等……！！"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                            QuestManager.completeStep(_quest.id, 1);
                        }]);
                    }]);
                }, false);
            }]);
        }]);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        DisplayUtil.removeForParent(this._mc_1);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
    }
}
}
