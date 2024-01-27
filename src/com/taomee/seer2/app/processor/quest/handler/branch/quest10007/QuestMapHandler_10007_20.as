package com.taomee.seer2.app.processor.quest.handler.branch.quest10007 {
import com.taomee.seer2.app.animationInteractive.AnimationEvent;
import com.taomee.seer2.app.animationInteractive.FindDuduAnimation;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10007_20 extends BranchQuestMapHandler {


    private var _findDdudu:FindDuduAnimation;

    public function QuestMapHandler_10007_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="415" resId="415" name="" dir="1" width="25" height="50" pos="276, 306"
                              actorPos="276,330" path="">
            <dialog npcId="415" npcName="嘟嘟" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[嗨~~你是有眼光的赛尔，你说说看，啾啾是不是和我长得像极了？]]></node>
                    <reply action="close"><![CDATA[呃……我想想……]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        tip = "快来实验室找嘟嘟吧";
    }

    override protected function onQuestClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (QuestManager.isAccepted(_questId) && !QuestManager.isStepComplete(_questId, 1)) {
            DialogPanel.showForSimple(415, "嘟嘟", [[0, "来来来，我们也来玩抓迷藏吧，我藏在实验室的各个角落，你来找我呀！"]], "好吧，你藏好，我开始找了！", function ():void {
                addFindDuduAnimation();
            });
            return;
        }
        if (QuestManager.isStepComplete(_questId, 1) && !QuestManager.isStepComplete(_questId, 2)) {
            DialogPanel.showForSimple(415, "嘟嘟", [[0, "你去玩一局捉迷藏游戏，我告诉你一个秘密！"]], " 好啊，我现在就去！");
            return;
        }
        super.onQuestClick(evt);
    }

    override protected function onQuestAccept(param1:QuestEvent):void {
        if (param1.questId == _questId) {
            this.addFindDuduAnimation();
        }
    }

    private function addFindDuduAnimation():void {
        this._findDdudu = new FindDuduAnimation();
        this._findDdudu.setup("findDudu");
        this._findDdudu.addEventListener(AnimationEvent.FINDDUDU, this.onFindDudu);
        this._findDdudu.addEventListener(Event.CLOSE, this.onCloseAnimation);
    }

    private function onFindDudu(param1:Event):void {
        var evt:Event = param1;
        QuestManager.completeStep(_questId, 1);
        this._findDdudu.dispose();
        this._findDdudu = null;
        DialogPanel.showForSimple(415, "嘟嘟", [[0, "嘻嘻~~你的眼好尖哦，全让你找到了！"]], "呵呵，那是！", function ():void {
            DialogPanel.showForSimple(415, "嘟嘟", [[0, "啾啾喜欢玩捉迷藏，我也喜欢玩捉迷藏！你去玩一局捉迷藏游戏，我告诉你一个秘密！"]], "好啊，我现在就去！", function ():void {
                ServerMessager.addMessage("去玩1局“爱上捉迷藏”游戏！");
            });
        });
    }

    private function onCloseAnimation(param1:Event):void {
        this._findDdudu.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        this._findDdudu.removeEventListener(AnimationEvent.FINDDUDU, this.onFindDudu);
    }

    override protected function completeQuest():void {
        DialogPanel.showForSimple(415, "嘟嘟", [[0, " (*^__^*) 嘻嘻……不知道你玩到极限关没？极限关里有我在哦！如果你极限关胜利，有机会得到我哦！再见！"]], "呵呵，真是个好秘密！再见！", function ():void {
            QuestManager.completeStep(_questId, 3);
        });
    }
}
}
