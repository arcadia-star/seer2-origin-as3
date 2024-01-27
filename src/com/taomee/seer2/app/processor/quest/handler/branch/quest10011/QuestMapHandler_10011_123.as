package com.taomee.seer2.app.processor.quest.handler.branch.quest10011 {
import com.taomee.seer2.app.animationInteractive.AnimationEvent;
import com.taomee.seer2.app.animationInteractive.Interactive_10011;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10011_123 extends BranchQuestMapHandler {


    private var _makeStone:Interactive_10011;

    public function QuestMapHandler_10011_123(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="428" resId="428" name="" dir="1" width="25" height="50" pos="457,390"
                              actorPos="510,428" path="">
            <dialog npcId="428" npcName="浣狸" transport="">
                <branch id="default" npcId="428" npcName="浣狸">
                    <node emotion="0"><![CDATA[美味蓝菇……嘿嘿……肯定很美味吧……]]></node>
                    <reply action="close"><![CDATA[（好多口水啊……）]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        tip = "";
        this._makeStone = new Interactive_10011();
    }

    override protected function onQuestAccept(param1:QuestEvent):void {
        super.onQuestAccept(param1);
        if (_questId == param1.questId) {
            DialogPanel.showForSimple(428, "浣狸", [[0, "我用尾巴上的毛变了5把锤子，帮我用它们吓唬一下舒尔吧！（在浣狸吃完蓝菇之前，用锤子吓唬舒尔，30秒。）"]], "看我的！", this.onAcceptOver);
        }
    }

    override protected function onQuestClick(param1:MouseEvent):void {
        if (QuestManager.isAccepted(10011) && !QuestManager.isStepComplete(10011, 1)) {
            DialogPanel.showForSimple(428, "浣狸", [[0, "我用尾巴上的毛变了5把锤子，帮我用它们吓唬一下舒尔吧！（在浣狸吃完蓝菇之前，用锤子吓唬舒尔，30秒。）"]], "看我的！", this.onAcceptOver);
        }
        if (QuestManager.isStepComplete(10011, 1) && QuestManager.isStepComplete(10011, 2) == false) {
            DialogPanel.showForSimple(428, "浣狸", [[0, "哗啦一下就下去了，还，还没尝出味儿来呢！你再帮我把一会儿风吧？嘿嘿……"]], "你也太贪吃了吧！", this.complete10011);
        }
        super.onQuestClick(param1);
    }

    private function onAcceptOver():void {
        this._makeStone.setup("interactive_10011");
        this._makeStone.addEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.addEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
    }

    private function onCloseAnimation(param1:Event):void {
        this._makeStone.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.removeEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
        var _loc2_:XML = new XML("<dialog npcId=\"428\" npcName=\"浣狸\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[哇哇……屁股很痛啊！但是……我不会放弃的！！]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[我再帮你一次！]]></reply>" + "<reply action=\"close\" params=\"no\"><![CDATA[你忍耐一下，我下次再来！]]></reply></branch>" + "</dialog>");
        var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
        DialogPanel.addCloseEventListener(this.dialogComplete);
        DialogPanel.showForCommon(_loc3_);
    }

    private function dialogComplete(param1:DialogCloseEvent):void {
        DialogPanel.removeCloseEventListener(this.dialogComplete);
        if (param1.params == "yes") {
            this.onAcceptOver();
        }
        if (param1.params == "no") {
            QuestManager.abortQuest(10011);
        }
    }

    private function onMakeBubbleOver(param1:Event):void {
        this._makeStone.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.removeEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
        QuestManager.completeStep(_questId, 1);
        DialogPanel.showForSimple(428, "浣狸", [[0, "哗啦一下就下去了，还，还没尝出味儿来呢！你再帮我把一会儿风吧？嘿嘿……"]], "你也太贪吃了吧！", this.complete10011);
    }

    private function complete10011():void {
        QuestManager.completeStep(_questId, 2);
    }
}
}
