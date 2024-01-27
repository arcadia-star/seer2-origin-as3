package com.taomee.seer2.app.processor.quest.handler.branch.quest10050 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_10050_121 extends QuestMapHandler {


    public function QuestMapHandler_10050_121(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        }
        DialogPanel.addCloseEventListener(this.onCloseDialog);
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            this.doQuest();
        }
    }

    private function onCloseDialog(param1:DialogCloseEvent):void {
        if (param1.params == "10050") {
            this.doQuest();
        }
    }

    private function doQuest():void {
        var wordStr:String = null;
        var wordStr2:String = null;
        var info:PetInfo = PetInfoManager.getFollowingPetInfo();
        if (Boolean(info) && info.bunchId < 4) {
            wordStr = "这个是轰轰烈烈的火系的主宠吧？！一看就是物理攻击很强，打架风格速战速决的类型！";
            wordStr2 = "这孩子性格很开朗呢，要好好和它相处！";
            if (info.bunchId == 1) {
                wordStr = "嗯，你拥有以优雅出名的水系主宠！一看就是擅长特殊攻击的类型！而且，绝对不会慢吞吞。";
                wordStr2 = "冷静是它最大的特点，在战斗时，它总是那么慎重。";
            } else if (info.bunchId == 3) {
                wordStr = "拉这可是我们草系非常出名的精灵！超强的体力和防御能力，能够抵抗高强度的战斗！";
                wordStr2 = "无忧无虑，它是非常温顺且沉着的精灵！";
            }
            NpcDialog.show(21, "油民", [[1, wordStr]], ["（好像说得有点道理）"], [function ():void {
                NpcDialog.show(21, "油民", [[1, wordStr2]], ["嗯，嗯！"], [function ():void {
                    NpcDialog.show(21, "油民", [[0, "哈哈，我今天真是大开眼界！作为对你的感谢，这个就送给你了！"]], ["哇！谢谢！"], [function ():void {
                        QuestManager.completeStep(_quest.id, 1);
                    }]);
                }]);
            }]);
        } else {
            NpcDialog.show(21, "油民", [[0, "嗯？别藏了，快给我看看！"]], ["（让自己的主宠跟随！）"], [null]);
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onCloseDialog);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
    }
}
}
