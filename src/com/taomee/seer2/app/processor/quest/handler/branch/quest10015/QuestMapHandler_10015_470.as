package com.taomee.seer2.app.processor.quest.handler.branch.quest10015 {
import com.taomee.seer2.app.animationInteractive.AnimationEvent;
import com.taomee.seer2.app.animationInteractive.Interactive_10015;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10015_470 extends QuestMapHandler {


    private var _makeStone:Interactive_10015;

    private var _mobile:Mobile;

    public function QuestMapHandler_10015_470(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._mobile = MobileManager.getMobile(443, MobileType.NPC);
        this._mobile.buttonMode = true;
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        this._mobile.addEventListener(MouseEvent.CLICK, this.onQuestClick);
        this._makeStone = new Interactive_10015();
    }

    protected function onQuestAccept(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            DialogPanel.showForSimple(443, "埃卡维特", [[0, "看好了，只要你能找到我藏起来的友谊树种，就算你赢了！"]], "好啊，我准备好了。", this.onAcceptOver);
        }
    }

    private function onQuestClick(param1:MouseEvent):void {
        if (QuestManager.isAccepted(10015) && !QuestManager.isStepComplete(10015, 1)) {
            DialogPanel.showForSimple(443, "埃卡维特", [[0, "看好了，只要你能找到我藏起来的友谊树种，就算你赢了！"]], "好啊，我准备好了。", this.onAcceptOver);
        }
        if (QuestManager.isStepComplete(10015, 1) && QuestManager.isStepComplete(10015, 2) == false) {
            DialogPanel.showForSimple(443, "埃卡维特", [[0, "你好厉害，居然猜对了，那这个友谊树种就是你的了。"]], "咦，友谊树种？", this.complete10015);
        }
    }

    private function onAcceptOver():void {
        this._makeStone.setup("interactive_10015");
        this._makeStone.addEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.addEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
    }

    private function onCloseAnimation(param1:Event):void {
        this._makeStone.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.removeEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
        var _loc2_:XML = new XML("<dialog npcId=\"443\" npcName=\"埃卡维特\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[想得到友谊树，可没那么简单。]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[再玩一遍，我就能猜对了。]]></reply>" + "<reply action=\"close\" params=\"no\"><![CDATA[一点都不好玩。]]></reply></branch>" + "</dialog>");
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
            QuestManager.abortQuest(10015);
        }
    }

    private function onMakeBubbleOver(param1:Event):void {
        this._makeStone.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.removeEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
        QuestManager.completeStep(_quest.id, 1);
        DialogPanel.showForSimple(443, "埃卡维特", [[0, "你好厉害，居然猜对了，那这个友谊树种就是你的了。"]], "咦，友谊树种？", this.complete10015);
    }

    private function complete10015():void {
        DialogPanel.showForSimple(443, "埃卡维特", [[0, "还是让神奇的戏法师帮你种上吧。搞定，以后我们会再见面的。"]], "你先别走啊！", function ():void {
            QuestManager.completeStep(_quest.id, 2);
        });
    }

    override public function processMapDispose():void {
        this._makeStone = null;
        this._mobile = null;
    }
}
}
