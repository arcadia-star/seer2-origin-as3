package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestProcessor_10018 extends QuestProcessor {


    private var _mobile:Mobile;

    public function QuestProcessor_10018(param1:Quest) {
        super(param1);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
    }

    private function onMapComplete(param1:SceneEvent):void {
        if (this.isAccept() != 0) {
            this._mobile = new Mobile();
            this._mobile.resourceUrl = URLUtil.getPetSwf(109);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
            if (ActorManager.getActor().getFollowingPet()) {
                ActorManager.getActor().addCarriedMobile(this._mobile, 80);
            } else {
                ActorManager.getActor().addCarriedMobile(this._mobile, 60);
            }
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId >= 10018 && param1.questId <= 10022) {
            ActorManager.getActor().removeCarriedMobile(this._mobile);
        }
    }

    private function isAccept():uint {
        if (QuestManager.getQuest(10018).status == QuestStatus.IN_PROGRESS) {
            return 10018;
        }
        if (QuestManager.getQuest(10019).status == QuestStatus.IN_PROGRESS) {
            return 10019;
        }
        if (QuestManager.getQuest(10020).status == QuestStatus.IN_PROGRESS) {
            return 10020;
        }
        if (QuestManager.getQuest(10021).status == QuestStatus.IN_PROGRESS) {
            return 10021;
        }
        if (QuestManager.getQuest(10022).status == QuestStatus.IN_PROGRESS) {
            return 10022;
        }
        return 0;
    }

    override public function processMapDispose():void {
        ActorManager.getActor().removeCarriedMobile(this._mobile);
    }
}
}
