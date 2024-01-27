package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.arena.data.RevenueInfo;
import com.taomee.seer2.app.arena.record.FightRecordData;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.FightResultPanelWrapper;
import com.taomee.seer2.app.manager.PetExperenceHelper;
import com.taomee.seer2.app.miniGame.MiniGameEvent;
import com.taomee.seer2.app.miniGame.MiniGameManager;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;
import flash.utils.setTimeout;

public class QuestProcessor_30001 extends QuestProcessor {

    private static const FOLLOW_PET_ARR:Array = [161];

    private static const FISH_ITEM_ID:int = 200502;

    private static const WILD_PET_MAP_ID:int = 141;

    private static const GAME_ID:int = 3;

    private static const SPT_BOSS_ID:int = 17;


    public function QuestProcessor_30001(param1:Quest) {
        super(param1);
    }

    override public function init():void {
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
        } else if (_quest.status == QuestStatus.IN_PROGRESS) {
            this.processStep();
        }
        PetInfoManager.addEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE, this.onExperenceChange);
    }

    override public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onQuestUnitClick);
        DialogPanel.removeEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onQuestUnitClick1);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep5);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep6);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep7);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete1);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete2);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete3);
        MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME, this.onPlayMiniGameEnd);
        ItemManager.removeEventListener1(ItemEvent.COOKING_COMPLETE, this.onCookSuccess);
        ItemManager.removeEventListener1(ItemEvent.MINE_SUCCESS, this.onMineSuccess);
        PetInfoManager.removeEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE, this.onExperenceChange);
    }

    override public function processMapComplete():void {
    }

    override public function processMapDispose():void {
    }

    private function onExperenceChange(param1:PetInfoEvent):void {
        var _loc2_:FightResultInfo = param1.content.resultInfo;
        var _loc3_:RevenueInfo = param1.content.revenueInfo;
        if (_loc2_.endReason == PetExperenceHelper.LEIKE_QUEST) {
            new FightResultPanelWrapper().show(PetInfoManager.getAllBagPetInfo(), _loc3_, _loc2_);
        }
    }

    private function onAcceptQuest(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        if (_quest.id == evt.questId) {
            setTimeout(function ():void {
                ServerMessager.addMessage("接受任务：《小雷克快快长》，带雷克去找伊娃博士吧！");
            }, 2000);
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptQuest);
            this.processStep();
        }
    }

    private function processStep():void {
        if (_quest.isStepOpen(1)) {
            this.processStep1();
        } else if (_quest.isStepOpen(2)) {
            this.processStep2();
        } else if (_quest.isStepOpen(3)) {
            this.processStep3();
        } else if (_quest.isStepOpen(4)) {
            this.processStep4();
        } else if (_quest.isStepOpen(5)) {
            this.processStep5();
        } else if (_quest.isStepOpen(6)) {
            this.processStep6();
        } else if (_quest.isStepOpen(7)) {
            this.processStep7();
        } else if (_quest.isStepOpen(8)) {
            this.processStep8();
        }
    }

    private function processStep1():void {
        DialogPanel.addEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onQuestUnitClick);
    }

    private function onQuestUnitClick(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (evt.content.questId == _quest.id && evt.content.stepId == 1) {
            DialogPanel.hide();
            if (!this.isFollowingLeike()) {
                NpcDialog.show(2, "伊娃博士", [[0, "嗨~~听说你养了一只龙？真不简单，快带出来我看看吧！"]], ["好，我让它跟随，给你看看！"]);
            } else {
                NpcDialog.show(2, "伊娃博士", [[0, "呀！原来你真的养了一条龙，这可真少见！我瞧瞧，这是雷克……"]], [" 博士，它总喊饿，还叫我" + (ActorManager.actorInfo.sex == 0 ? "爸爸" : "妈妈") + "。"], [function ():void {
                    NpcDialog.show(2, "伊娃博士", [[0, "哈哈哈，这个世界上，有许多奇妙的生物，它们会把第一眼看到的生物称作爸爸妈妈！"]], [" 难道，雷克就是这样的？"], [function ():void {
                        NpcDialog.show(2, "伊娃博士", [[0, "是的！而且雷克是很智慧的精灵，它需要<font color=\'#ffcc00\'>坚毅之芯</font>，才会<font color=\'#ffcc00\'>进化</font>哦！"]], ["坚毅之芯？要怎么才能得到？"], [function ():void {
                            NpcDialog.show(2, "伊娃博士", [[0, "带雷克去做6件事，每件事都会让雷克成长，并脱落乳牙。带着6颗乳牙再来找我。"]], ["哪6件事？"], [function ():void {
                                NpcDialog.show(2, "伊娃博士", [[0, "<font color=\'#ffcc00\'>第一件事：带雷克跟随，去战胜幻影崖的小树根！</font>6件事已记录在任务档案中，按照任务档案中的指示去做吧！"]], [" 谢谢，我知道啦！"], [function ():void {
                                    ServerMessager.addMessage("让雷克跟随，去幻影崖战胜小树根。");
                                    DialogPanel.removeEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, onQuestUnitClick);
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
                                    QuestManager.completeStep(_quest.id, 1);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }
        }
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.processStep2();
        }
    }

    private function processStep2():void {
        if (this.isStepReady(2)) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete1);
        }
    }

    private function onSwitchComplete1(param1:SceneEvent):void {
        var position:int = 0;
        var evt:SceneEvent = param1;
        if (!this.isFollowingLeike()) {
            return;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.positionIndex) && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_WILD) {
                position = int(FightManager.currentFightRecord.initData.positionIndex);
                if (SceneManager.active.mapID == WILD_PET_MAP_ID && position >= 0 && position <= 9) {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_0"), function ():void {
                        ServerMessager.addMessage("获得第1颗乳牙！带雷克去玩《奇妙的宝石》");
                        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete1);
                        writeDateToBuffer(2);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep2);
                        QuestManager.completeStep(_quest.id, 2);
                    });
                }
            }
        }
    }

    private function onCompleteStep2(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            this.processStep3();
        }
    }

    private function processStep3():void {
        if (this.isStepReady(3)) {
            MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME, this.onPlayMiniGameEnd);
        }
    }

    private function onPlayMiniGameEnd(param1:MiniGameEvent):void {
        var evt:MiniGameEvent = param1;
        if (!this.isFollowingLeike()) {
            return;
        }
        if (evt.gameId == GAME_ID) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_0"), function ():void {
                ServerMessager.addMessage("获得第2颗乳牙！带雷克去好友小屋，挑战精灵");
                MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME, onPlayMiniGameEnd);
                writeDateToBuffer(3);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep3);
                QuestManager.completeStep(_quest.id, 3);
            });
        }
    }

    private function onCompleteStep3(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
            this.processStep4();
        }
    }

    private function processStep4():void {
        if (this.isStepReady(4)) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete3);
        }
    }

    private function onSwitchComplete3(param1:SceneEvent):void {
        var evt:SceneEvent = param1;
        if (!this.isFollowingLeike()) {
            return;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_TRAINER) {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_0"), function ():void {
                    ServerMessager.addMessage("获得第3颗乳牙！带雷克去异蘑世界挖矿！");
                    SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete3);
                    writeDateToBuffer(4);
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep4);
                    QuestManager.completeStep(_quest.id, 4);
                });
            }
        }
    }

    private function onCompleteStep4(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            this.processStep5();
        }
    }

    private function processStep5():void {
        if (this.isStepReady(5)) {
            ItemManager.addEventListener1(ItemEvent.MINE_SUCCESS, this.onMineSuccess);
        }
    }

    private function onMineSuccess(param1:ItemEvent):void {
        var evt:ItemEvent = param1;
        if (!this.isFollowingLeike()) {
            return;
        }
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_0"), function ():void {
            ServerMessager.addMessage("获得第4颗乳牙！带雷克去七味小厨制作1份炸黄鱼！");
            ItemManager.removeEventListener1(ItemEvent.MINE_SUCCESS, onMineSuccess);
            writeDateToBuffer(5);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep5);
            QuestManager.completeStep(_quest.id, 5);
        });
    }

    private function onCompleteStep5(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep5);
            this.processStep6();
        }
    }

    private function processStep6():void {
        if (this.isStepReady(6)) {
            ItemManager.addEventListener1(ItemEvent.COOKING_COMPLETE, this.onCookSuccess);
        }
    }

    private function onCookSuccess(param1:ItemEvent):void {
        var evt:ItemEvent = param1;
        if (!this.isFollowingLeike()) {
            return;
        }
        if (evt.content.id == FISH_ITEM_ID || evt.content.id == 200501 || evt.content.id == 200503) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_0"), function ():void {
                ServerMessager.addMessage("获得第5颗乳牙！带雷克去巨石洞穴挑战布鲁托！");
                ItemManager.removeEventListener1(ItemEvent.COOKING_COMPLETE, onCookSuccess);
                writeDateToBuffer(6);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep6);
                QuestManager.completeStep(_quest.id, 6);
            });
        }
    }

    private function onCompleteStep6(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep6);
            this.processStep7();
        }
    }

    private function processStep7():void {
        if (this.isStepReady(7)) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete2);
        }
    }

    private function onSwitchComplete2(param1:Event):void {
        var evt:Event = param1;
        if (!this.isFollowingLeike()) {
            return;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.bossId) && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_BOSS) {
                if (FightManager.currentFightRecord.initData.bossId == SPT_BOSS_ID) {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_0"), function ():void {
                        ServerMessager.addMessage("获得第6颗乳牙！去实验室找伊娃博士吧！");
                        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete2);
                        writeDateToBuffer(7);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep7);
                        QuestManager.completeStep(_quest.id, 7);
                    });
                }
            }
        }
    }

    private function onCompleteStep7(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            this.processStep8();
        }
    }

    private function processStep8():void {
        DialogPanel.addEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onQuestUnitClick1);
    }

    private function onQuestUnitClick1(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (evt.content.questId == _quest.id && evt.content.stepId == 8) {
            DialogPanel.hide();
            NpcDialog.show(2, "伊娃博士", [[0, "终于集齐6颗乳牙啦？啊，你的雷克也成长了不少！接下来，我要用这些乳牙融合出坚毅之芯啦！"]], ["交给你啦博士！"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30001_1"), function ():void {
                    NpcDialog.show(2, "伊娃博士", [[0, "坚毅之芯给你吧，好好培养你的小雷克，快点让它进化成强大的雷克斯哦！再见！"]], ["谢谢啦，再见，博士！"], [function ():void {
                        QuestManager.completeStep(_quest.id, 8);
                    }]);
                });
            }]);
        }
    }

    private function isStepReady(param1:int):Boolean {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:Date = null;
        return true;
    }

    private function writeDateToBuffer(param1:int):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * DateUtil.MILLISECONDS_PER_SECOND);
        _quest.setStepData(param1, 0, _loc2_.fullYear - 2000);
        _quest.setStepData(param1, 1, _loc2_.month);
        _quest.setStepData(param1, 2, _loc2_.date);
    }

    private function isFollowingLeike():Boolean {
        var _loc1_:PetInfo = PetInfoManager.getFollowingPetInfo();
        return Boolean(_loc1_) && FOLLOW_PET_ARR.indexOf(_loc1_.resourceId) != -1;
    }
}
}
