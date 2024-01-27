package com.taomee.seer2.app.processor.quest.handler.main.quest93 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_93_3828 extends QuestMapHandler {


    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_93_3828(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(questID)) {
            RightToolbarConter.instance.hide();
            this.initAccept();
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 1) == false) {
                this.initStep1();
            } else if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
                this.initStep2();
            }
        }
        if (QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 93) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        NpcDialog.show(1016, "里格", [[0, ActorManager.actorInfo.nick + "，你先不要着急，我们和梵拉有自己的计划。"]], ["他到底是什么人？（长相就怪怪的。）"], [function ():void {
            NpcDialog.show(1016, "里格", [[0, "梵拉曾是我们超能氏族的通灵师，能够召唤魂兽和精灵，深得族长大人和我族族人的信任。"]], ["通灵师？他原来那么厉害！"], [function ():void {
                NpcDialog.show(1016, "里格", [[0, "没错，可是自从萨伦帝国的魔爪伸向了我们的能量水晶后，梵拉的力量就随着能量水晶的衰弱不再能保护我们的氏族。我们只得成立反萨联盟在暗中进行斗争。"]], ["我怎么能知道你们是不是说谎？"], [function ():void {
                    NpcDialog.show(1016, "里格", [[0, "我们在这段时间里已经收集了足够的能量碎片，能够让梵拉再次施放召唤术，召唤精灵梵尔尼。到时候，真相自然会大白于天下。"]], ["那我就先相信你一次。"], [function ():void {
                        NpcDialog.show(1016, "里格", [[0, ActorManager.actorInfo.nick + "，还需要你帮最后一个忙，去穹顶大厅转告族长大人：只要他再次踏入超能广场，他就会得到答案的。"]], ["你们说话都不喜欢说完……（去穹顶大厅）"], [function ():void {
                            ActorManager.getActor().show();
                            ActorManager.getActor().blockFollowingPet = false;
                            ActorManager.getActor().blockNoNo = false;
                            initStep2();
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep2():void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 800;
        this._mouseHint.y = 250;
        _map.front.addChild(this._mouseHint);
    }

    override public function processMapDispose():void {
        RightToolbarConter.instance.show();
        super.processMapDispose();
    }
}
}
