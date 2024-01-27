package com.taomee.seer2.app.processor.quest.handler.branch.quest10001 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;

public class QuestMapHandler_10001_1310 extends BranchQuestMapHandler {


    public function QuestMapHandler_10001_1310(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="402" resId="4002" name="" dir="1" width="25" height="50" pos="200,410"
                              actorPos="250,415" path="">
            <dialog npcId="402" npcName="法拉" transport="1,300,400">
                <branch id="default">
                    <node emotion="2"><![CDATA[嘻~~你看，小小葵在做梦哦，真有趣，我要到它梦里去看看有什么好玩的。]]></node>
                    <reply action="close"><![CDATA[谢谢，可我现在不想去。]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        tip = "带上法拉去小小葵梦里看看吧！";
    }

    override protected function completeQuest():void {
        DialogPanel.showForSimple(402, "法拉", [[2, "嘻~~小小葵的梦有意思吗？偷偷的告诉你哦，每天晚上，小小葵都会做梦，而且还不一样哦！"]], "天天都会做梦啊……", this.gotoBranch);
    }

    private function gotoBranch():void {
        DialogPanel.showForSimple(402, "法拉", [[2, "哦，我要走啦！我说过保证你有收获的。这个送给你！"]], "谢谢，再见！", this.onDialogOver);
    }

    private function onDialogOver():void {
        QuestManager.completeStep(_questId, 2);
    }
}
}
