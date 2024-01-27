package com.taomee.seer2.app.processor.quest.handler.story.quest44 {
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

public class QuestMapHandler_44_800 extends QuestMapHandler {


    public function QuestMapHandler_44_800(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "playComic44") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            this.playComic();
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }

    private function playComic():void {
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("44_0"), 2, [[1, 0]], function ():void {
            NpcDialog.show(475, "费德提克", [[2, "哟呵呵呵——当年应该仔细听主人的讲解的。不过，除了想念主人，满月的时候还有更可怕的事情！"]], [" 啥？！难道是月夜狼人？"], [function ():void {
                NpcDialog.show(475, "费德提克", [[2, "能源之树的第三层，也就是这片原野的上方，是一个叫做脉流之瀑的地方……据说那里也有个和我一样的守门人。"]], [" 他是月夜狼人？？"], [function ():void {
                    NpcDialog.show(475, "费德提克", [[2, "咳，不是，其实我没有见过他！我的心中只有乌鸦！不过，你可以去看看……"]], [" 太好奇了，我一定要去！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                        QuestManager.accept(_quest.id);
                    }]);
                }]);
            }]);
        });
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 44) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY, 810);
        }
    }
}
}
