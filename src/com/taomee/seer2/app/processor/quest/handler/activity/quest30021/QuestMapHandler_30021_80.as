package com.taomee.seer2.app.processor.quest.handler.activity.quest30021 {
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

public class QuestMapHandler_30021_80 extends QuestMapHandler {


    public function QuestMapHandler_30021_80(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onPlayFullMCHandler);
        }
    }

    private function onPlayFullMCHandler(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if ((evt.content as DialogPanelEventData).params == "30021_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onPlayFullMCHandler);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30021_0"), function ():void {
                NpcDialog.show(1001, "伊娃", [[0, "事情就是这样子了。有部分参赛者反应，一群“逆天”的神秘人正在争霸赛中横行霸道。"]], ["横行霸道？"], [function ():void {
                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30021_0"), 2, [[1, 0]], function ():void {
                        NpcDialog.show(1001, "伊娃", [[0, "我希望第七小队可以协助调查这件事情，维护我们公平和谐的比赛环境！能否帮忙询问一下其他两位队长，有没有什么线索？"]], ["包在我身上！（先去冰沁队吧！）"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                            QuestManager.accept(_quest.id);
                        }]);
                    });
                }]);
            }, true, false, 2);
        }
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 40);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
    }
}
}
