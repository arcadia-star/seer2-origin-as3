package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class MapProcessor_3804 extends MapProcessor {


    private var petId:int = 112;

    private var fightId:int = 441;

    public function MapProcessor_3804(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        if (QuestManager.isStepComplete(10188, 3) && !QuestManager.isComplete(10188)) {
            MobileManager.removeMobile(MobileManager.getMobile(437, MobileType.NPC), MobileType.NPC);
            ActiveCountManager.requestActiveCount(202259, this.getSeatInfo);
            this.createPet();
        }
        if (!QuestManager.isStepComplete(10188, 2)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                if (FightManager.isWinWar() && FightManager.currentFightRecord.initData.positionIndex == 440) {
                    DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onDiaEvent);
                    this.playFull();
                } else {
                    NpcDialog.show(437, "砂吉塔", [[0, "你就这两下子还敢来抢我的宝藏，回去再练练吧。"]], ["再来一次", "我先走了"], [function ():void {
                        FightManager.startFightWithWild(440);
                    }]);
                }
            } else {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onDiaEvent);
            }
        }
    }

    private function getSeatInfo(param1:uint, param2:int):void {
        var _loc3_:String = param2.toString();
        if (_loc3_.charAt(8) != "0" && FightManager.isJustWinFight()) {
            ModuleManager.toggleModule(URLUtil.getAppModule("YueBeastPanel"), "", "2");
        }
    }

    private function playFull():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10188_1"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
            QuestManager.completeStep(10188, 2);
        }, true, true);
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == 10188) {
            if (param1.stepId == 3) {
                QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
                ModuleManager.toggleModule(URLUtil.getAppModule("YueBeastPanel"), "", "2");
                MobileManager.removeMobile(MobileManager.getMobile(437, MobileType.NPC), MobileType.NPC);
                this.createPet();
            }
        }
    }

    private function onDiaEvent(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "fightPet_10188") {
            FightManager.startFightWithWild(440);
        }
    }

    private function createPet():void {
        var _loc3_:SpawnedPet = null;
        var _loc1_:int = 5;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = new SpawnedPet(this.petId, this.fightId, 0);
            MobileManager.addMobile(_loc3_, MobileType.SPAWNED_PET);
            _loc2_++;
        }
    }

    override public function dispose():void {
        super.dispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onDiaEvent);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
    }
}
}
