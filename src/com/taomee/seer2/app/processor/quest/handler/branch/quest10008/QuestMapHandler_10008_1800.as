package com.taomee.seer2.app.processor.quest.handler.branch.quest10008 {
import com.taomee.seer2.app.animationInteractive.KeepBalance;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_10008_1800 extends BranchQuestMapHandler {


    private var _keepBalance:KeepBalance;

    public function QuestMapHandler_10008_1800(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="417" resId="417" name="" dir="1" width="25" height="50" pos="300, 430"
                              actorPos="250,415" path="">
            <dialog npcId="408" npcName="水墨点点" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[不要靠近我，不要靠近我！]]></node>
                    <reply action="close"><![CDATA[……它好奇怪啊！]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        DialogPanel.addCloseEventListener(this.onClosePanel);
    }

    private function onClosePanel(param1:DialogCloseEvent):void {
        if (param1.params == "keepBalance") {
            this.addKeepBalance();
        }
    }

    override protected function onQuestAccept(param1:QuestEvent):void {
        if (param1.questId == _questId) {
            this.addKeepBalance();
        }
    }

    private function addKeepBalance():void {
        this._keepBalance = new KeepBalance(60, 1);
        this._keepBalance.setup("keepBalance", this.onKeepBalance);
    }

    private function onKeepBalance(param1:int):void {
        if (param1 >= 60) {
            QuestManager.completeStep(_questId, 1);
            this.completeQuest();
        }
        this._keepBalance = null;
    }

    override protected function completeQuest():void {
        DialogPanel.showForSimple(408, "水墨点点", [[0, "哇~~~我这么久都没有跌倒哦！！你太强了！谢谢，谢谢你！"]], " 呵呵，不要客气。", function ():void {
            DialogPanel.showForSimple(408, "水墨点点", [[0, "这是我谢谢你的礼物，请收下！我有信心了，我一定能走好，我一定也能游起来！"]], "是呀，加油！", function ():void {
                QuestManager.completeStep(_questId, 2);
            });
        });
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onClosePanel);
    }
}
}
