package com.taomee.seer2.app.quest {
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.QuestStep;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

public class QuestNpcManager {


    public function QuestNpcManager() {
        super();
    }

    public static function setup():void {
        QuestManager.addEventListener(QuestEvent.INIT, onQuestInit);
    }

    private static function onQuestInit(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.INIT, onQuestInit);
        QuestManager.addEventListener(QuestEvent.ACCEPT, onQuestChange);
        QuestManager.addEventListener(QuestEvent.ABORT, onQuestChange);
        QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestChange);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestChange);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapComplete);
        updateQuestMark();
    }

    private static function onQuestChange(param1:QuestEvent):void {
        updateQuestMark();
    }

    private static function onMapComplete(param1:SceneEvent):void {
        updateQuestMark();
    }

    public static function updateQuestMark():void {
        if (SceneManager.currentSceneType != SceneType.NULL && SceneManager.currentSceneType !== SceneType.ARENA) {
            clearQuestMark();
            checkAcceptable();
            checkInProgress();
        }
    }

    private static function clearQuestMark():void {
        var _loc1_:Mobile = null;
        for each(_loc1_ in MobileManager.getMobileVec(MobileType.NPC)) {
            _loc1_.removeOverHeadMark();
        }
    }

    private static function checkAcceptable():void {
        var _loc1_:Quest = null;
        var _loc2_:int = 0;
        var _loc3_:Mobile = null;
        var _loc4_:AcceptableMark = null;
        for each(_loc1_ in QuestManager.getQuestListByStatus(QuestStatus.ACCEPTABLE)) {
            if (_loc1_.needAcceptMark) {
                if (_loc1_.acceptDialog) {
                    _loc2_ = int(_loc1_.acceptDialog.npcId);
                    _loc3_ = MobileManager.getMobile(_loc2_, MobileType.NPC);
                    if (_loc3_) {
                        _loc4_ = new AcceptableMark();
                        _loc3_.addOverHeadMark(_loc4_);
                    }
                }
            }
        }
    }

    private static function checkInProgress():void {
        var _loc1_:Quest = null;
        var _loc2_:QuestStep = null;
        var _loc3_:int = 0;
        var _loc4_:Mobile = null;
        var _loc5_:InProgressMark = null;
        for each(_loc1_ in QuestManager.getQuestListByStatus(QuestStatus.IN_PROGRESS)) {
            if (_loc1_.needAcceptMark) {
                for each(_loc2_ in _loc1_.getStepVec()) {
                    if (Boolean(_loc1_.isStepCompletable(_loc2_.id)) && Boolean(_loc2_.dialog)) {
                        _loc3_ = int(_loc2_.dialog.npcId);
                        if (_loc4_ = MobileManager.getMobile(_loc3_, MobileType.NPC)) {
                            _loc5_ = new InProgressMark();
                            _loc4_.addOverHeadMark(_loc5_);
                        }
                    }
                }
            }
        }
    }
}
}
