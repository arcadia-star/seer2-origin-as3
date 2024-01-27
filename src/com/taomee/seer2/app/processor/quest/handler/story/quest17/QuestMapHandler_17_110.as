package com.taomee.seer2.app.processor.quest.handler.story.quest17 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_17_110 extends QuestMapHandler {


    public function QuestMapHandler_17_110(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var event:DialogCloseEvent = param1;
        if (event.params == "17_2") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.completeStep(_quest.id, 3);
        }
        if (event.params == "17_4") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("17_1"), function ():void {
                NpcDialog.show(16, "酋长", [[4, "冰沁氏族有危难！这一切一定是萨伦帝国……！"]], ["酋长，你也看到了……？"], [function ():void {
                    var data:* = new XML("<dialog npcId=\"16\" npcName=\"酋长\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[是的。冰沁氏族向来不与外界联系……这不是一封普通的信件，是一封求援信！]]></node>" + "<node emotion=\"0\"><![CDATA[小赛尔，我还无法预知星球的北方究竟发生什么……但你必须做好完全的准备。战斗……就要开始了！]]></node>" + "<reply action=\"\"><![CDATA[嗯！我知道了！！]]></reply></branch>" + "</dialog>");
                    var dialogDefinition:* = new DialogDefinition(data);
                    DialogPanel.showForCommon(dialogDefinition, function ():void {
                        QuestManager.completeStep(_quest.id, 5);
                    });
                }]);
            });
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
    }
}
}
