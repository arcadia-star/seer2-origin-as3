package com.taomee.seer2.app.processor.quest.handler.activity.quest30008 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_30008_110 extends QuestMapHandler {


    public function QuestMapHandler_30008_110(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "30008_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30008_0"), 2, [[1, 0]], function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "哇！真是太神奇了！ 我越听越兴奋哦！ 酋长你见过“美食神猪”吗？或者你知道有谁见过吗？"]], ["……"], [function ():void {
                    NpcDialog.show(16, "神目酋长", [[0, "水脉氏族的占卜婆婆就遇到过，而且她已经研究“美食神猪”好长时间了，你可以去问问。"]], ["嗯，我现在就去找她！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Handler);
                        QuestManager.completeStep(_quest.id, 1);
                    }]);
                }]);
            });
        }
    }

    private function onStep1Handler(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
            SceneManager.changeScene(SceneType.LOBBY, 213);
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
    }
}
}
