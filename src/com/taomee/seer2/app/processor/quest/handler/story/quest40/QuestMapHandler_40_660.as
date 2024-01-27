package com.taomee.seer2.app.processor.quest.handler.story.quest40 {
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

public class QuestMapHandler_40_660 extends QuestMapHandler {


    public function QuestMapHandler_40_660(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "40_0") {
            this.processorStep0();
        }
    }

    private function processorStep0():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("40_0"), function ():void {
            NpcDialog.show(83, "萨伯尔兵团长", [[0, "但是对于我们来说，我们是飞翼氏族的守护者，我们必须保证岛内的秩序。也所以根本无法追随总兵团长而去。"]], ["但是，他当年不辞而别究竟是为什么呢？"], [function ():void {
                NpcDialog.show(83, "萨伯尔兵团长", [[0, "（低下头去，仿佛陷入了回忆之中……）"]], ["我自己去汲雨之岛找刚铎问！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                    QuestManager.accept(_quest.id);
                }]);
            }]);
        }, true, false, 2);
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        SceneManager.changeScene(SceneType.LOBBY, 760);
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
    }
}
}
