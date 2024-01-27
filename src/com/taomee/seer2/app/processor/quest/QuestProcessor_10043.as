package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10043.ReplacePet;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class QuestProcessor_10043 extends QuestProcessor {

    private static const STATISTIC_PRE:String = "http://misc.taomee.com/seer2/seer2.php?type=lose_weight_plan_";

    private static const STATISTIC_MID:String = "&mm=";

    private static const MAP_ID_1:Array = [122];

    private static const MAP_ID_2:Array = [121, 151, 131, 141];

    private static const MAP_ID_3:Array = [142, 193, 510];

    private static const MAP_ID_4:Array = [122];

    private static const FLAG_2:Array = [1, 2, 4, 8];

    private static const ITEM_2:Array = ["荷叶", "露水", "橘子皮", "山楂"];

    private static const FLAG_3:Array = [1, 2, 4];

    private static const NPC_INDEX:uint = 48;

    private static const KADUNJIUJIU_RESID:uint = 45;


    private var _npc:Mobile;

    private var _inprogressMark:InProgressMark;

    private var _acceptMark:AcceptableMark;

    public function QuestProcessor_10043(param1:Quest) {
        super(param1);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.onMapStart);
    }

    private function processStep1():void {
        var count:uint = 0;
        if (_quest.getStepData(1, 0) >= 5) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            QuestManager.completeStep(_quest.id, 1);
        } else if (SceneManager.active.mapID == 122 && SceneManager.prevSceneType == SceneType.ARENA) {
            if (PetInfoManager.getFirstPetInfo().resourceId == KADUNJIUJIU_RESID && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex < 10 && FightManager.fightWinnerSide == FightSide.LEFT) {
                count = uint(_quest.getStepData(1, 0));
                _quest.setStepData(1, 0, count + 1);
                QuestManager.setStepBufferServer(_quest.id, 1);
            }
            if (_quest.getStepData(1, 0) >= 5) {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10043_1"), function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
                    QuestManager.completeStep(_quest.id, 1);
                });
            } else {
                ServerMessager.addMessage("还需要战胜 <font color=\'#ffcc00\'>" + (5 - _quest.getStepData(1, 0)) + " </font> 只 <font color=\'#ffcc00\'>啾啾</font>");
            }
        }
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.sendStatistics(1);
            if (SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.prevSceneType == SceneType.ARENA) {
                ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 2});
            }
        }
    }

    private function sendStatistics(param1:uint):void {
        StatisticsManager.sendStatisticsByUrl(STATISTIC_PRE + param1.toString() + STATISTIC_MID + ActorManager.actorInfo.id);
    }

    private function processStep2():void {
        var index:int = 0;
        var count:uint = 0;
        if (_quest.getStepData(2, 0) >= 15) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            QuestManager.completeStep(_quest.id, 2);
        } else if (SceneManager.prevSceneType == SceneType.ARENA && MAP_ID_2.indexOf(SceneManager.active.mapResourceID) != -1) {
            index = MAP_ID_2.indexOf(SceneManager.active.mapResourceID);
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex < 10 && FightManager.fightWinnerSide == FightSide.LEFT) {
                count = uint(_quest.getStepData(2, 0));
                if (!(count & FLAG_2[index])) {
                    ServerMessager.addMessage("收集到 <font color=\'#ffcc00\'>" + ITEM_2[index] + "</font>");
                    _quest.setStepData(2, 0, count + FLAG_2[index]);
                    QuestManager.setStepBufferServer(_quest.id, 2);
                    if (_quest.getStepData(2, 0) >= 15) {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10043_2"), function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep2);
                            QuestManager.completeStep(_quest.id, 2);
                        });
                    } else {
                        ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 2});
                    }
                }
            }
        }
    }

    private function onCompleteStep2(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            this.sendStatistics(2);
            if (SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.prevSceneType == SceneType.ARENA) {
                ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 3});
            }
        }
    }

    private function processStep3():void {
        var count:uint = 0;
        var index:int = 0;
        var flag:uint = 0;
        if (_quest.getStepData(3, 0) >= 7) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
            QuestManager.completeStep(_quest.id, 3);
        } else if (SceneManager.prevSceneType == SceneType.ARENA && MAP_ID_3.indexOf(SceneManager.active.mapResourceID) != -1) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                index = MAP_ID_3.indexOf(SceneManager.active.mapResourceID);
                if (SceneManager.active.mapResourceID == 510 && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.positionIndex) && FightManager.currentFightRecord.initData.positionIndex < 10) {
                    count = uint(_quest.getStepData(3, 1));
                    _quest.setStepData(3, 1, count + 1);
                    QuestManager.setStepBufferServer(_quest.id, 3);
                    if (count + 1 >= 5) {
                        flag = uint(_quest.getStepData(3, 0));
                        _quest.setStepData(3, 0, flag + FLAG_3[2]);
                        QuestManager.setStepBufferServer(_quest.id, 3);
                        if (_quest.getStepData(3, 0) >= 7) {
                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10043_3"), function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep3);
                                QuestManager.completeStep(_quest.id, 3);
                            });
                        } else {
                            ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 3});
                        }
                    } else {
                        ServerMessager.addMessage("还需要战胜 <font color=\'#ffcc00\'>" + (5 - _quest.getStepData(3, 1)) + " </font> 只 <font color=\'#ffcc00\'>格尔西克</font>");
                    }
                } else if (SceneManager.active.mapResourceID == 142 && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.bossId && FightManager.currentFightRecord.initData.bossId == 17 || SceneManager.active.mapResourceID == 193 && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.bossId && FightManager.currentFightRecord.initData.bossId == 31) {
                    count = uint(_quest.getStepData(3, 0));
                    if (!(count & FLAG_3[index])) {
                        _quest.setStepData(3, 0, count + FLAG_3[index]);
                        QuestManager.setStepBufferServer(_quest.id, 3);
                        if (_quest.getStepData(3, 0) >= 7) {
                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10043_3"), function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep3);
                                QuestManager.completeStep(_quest.id, 3);
                            });
                        } else {
                            ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 3});
                        }
                    }
                }
            }
        }
    }

    private function onCompleteStep3(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
            this.sendStatistics(3);
            if (SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.prevSceneType == SceneType.ARENA) {
                ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 4});
            }
        }
    }

    private function processStep4():void {
        if (SceneManager.active.mapID == 122) {
            if (_quest.getStepData(4, 0) >= 1) {
                ReplacePet.replacePet();
                QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
                QuestManager.completeStep(_quest.id, 4);
            } else if (PetInfoManager.getFirstPetInfo().resourceId == KADUNJIUJIU_RESID && SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_INDEX && FightManager.fightWinnerSide == FightSide.LEFT) {
                _quest.setStepData(4, 0, 1);
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10043_4"), function ():void {
                    ReplacePet.replacePet();
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                    QuestManager.completeStep(_quest.id, 4);
                });
            } else {
                this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClickStep4, false, 1);
            }
        }
    }

    private function onQuestComplete(param1:QuestEvent):void {
        if (param1.questId == 10043) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        }
    }

    private function onNpcClickStep4(param1:MouseEvent):void {
        var _loc2_:ButtonPanelData = null;
        param1.stopImmediatePropagation();
        if (PetInfoManager.getFirstPetInfo().resourceId != KADUNJIUJIU_RESID) {
            AlertManager.showAlert("需要让卡顿啾啾自己战胜心魔哦~ 快把它设为首发吧");
        } else {
            _loc2_ = new ButtonPanelData();
            _loc2_.catchEnabled = false;
            _loc2_.petEnabled = false;
            FightManager.startFightWithWild(NPC_INDEX, null, null, _loc2_);
        }
    }

    private function processAccept():void {
        var followPetInfo:PetInfo = PetInfoManager.getFollowingPetInfo();
        if (PetInfoManager.getFirstPetInfo().resourceId != KADUNJIUJIU_RESID || followPetInfo == null || followPetInfo.resourceId != KADUNJIUJIU_RESID) {
            NpcDialog.show(460, "卡顿啾啾", [[2, "啧啧啧……这是我们胖子的话题！如果你没有 <font color=\'#ffcc00\'>卡顿啾啾（啾啾第三形态） </font>的话我可不理你……"]], ["（需要将卡顿啾啾设为首发并带在身边跟随）"], [null]);
        } else {
            NpcDialog.show(460, "卡顿啾啾", [[0, "肥胖困扰我多年，我这里倒是有一套健康减肥方案……只是我坚持不下来，你能不能帮帮我们……"]], ["GOGOGO！向着窈窕进军！", "我一会再来"], [function ():void {
                QuestManager.addEventListener(QuestEvent.ACCEPT, onQuestAccepted);
                QuestManager.accept(_quest.id);
            }, null]);
        }
    }

    private function onQuestAccepted(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
            if (this._acceptMark) {
                DisplayObjectUtil.removeFromParent(this._acceptMark);
                this._acceptMark = null;
            }
            if (this._npc && SceneManager.active && Boolean(SceneManager.active.mapModel)) {
                if (this._inprogressMark == null) {
                    this._inprogressMark = new InProgressMark();
                }
                this._inprogressMark.x = this._npc.x;
                this._inprogressMark.y = this._npc.y - this._npc.height;
                SceneManager.active.mapModel.content.addChild(this._inprogressMark);
            }
            if (Boolean(SceneManager.active) && SceneManager.active.type == SceneType.LOBBY) {
                ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": 1});
            }
        }
    }

    private function onOpenQuestModule(param1:DialogPanelEvent):void {
        if (param1.content.questId == 10043 && QuestManager.isCanAccepted(10043)) {
            this.processAccept();
        } else if (param1.content.questId == 10043 && QuestManager.isAccepted(10043) && QuestManager.isComplete(10043) == false) {
            DialogPanel.hide();
            ModuleManager.showModule(URLUtil.getAppModule("KaDunJiuJiuPanel"), "正在打开减肥计划单……", {"step": param1.content.stepId});
        }
    }

    private function onMapComplete(param1:SceneEvent):void {
        if (SceneManager.active) {
            if (SceneManager.active.mapID == 122) {
                this.createNpc();
                DialogPanel.addEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onOpenQuestModule);
            }
            if (_quest.isStepCompletable(1)) {
                this.processStep1();
            } else if (_quest.isStepCompletable(2)) {
                this.processStep2();
            } else if (_quest.isStepCompletable(3)) {
                this.processStep3();
            } else if (_quest.isStepCompletable(4)) {
                this.processStep4();
            }
        }
    }

    private function onMapStart(param1:SceneEvent):void {
        this.clearLayout();
        DialogPanel.removeEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onOpenQuestModule);
    }

    private function createNpc():void {
        var _loc1_:XML = <npc id="460" resId="460" name="卡顿啾啾" dir="1" width="70" height="70" pos="545, 390"
                              actorPos="578, 457" path="">
            <dialog npcId="460" transport="1,300,400">
                <branch id="default">
                    <node emotion="2"><![CDATA[啧啧啧……我再胖下去就连这桥都要断了！哎！我的体重直线飙升，昔日的可爱形象已不复返！哎……]]></node>
                    <reply action="close"><![CDATA[（坦白说，你真的长残了……）]]></reply>
                </branch>
            </dialog>
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[啧啧啧……好想摆脱肚子上的救生圈！]]></HandlerShowNpcSlogan>
                </mouseOver>
                <click>
                    <HandlerOpenDialogPanel/>
                </click>
            </eventHandler>
        </npc>;
        this._npc = MobileManager.createNpc(new NpcDefinition(_loc1_));
        if (QuestManager.isCanAccepted(10043)) {
            if (this._acceptMark == null) {
                this._acceptMark = new AcceptableMark();
            }
            this._acceptMark.x = this._npc.x;
            this._acceptMark.y = this._npc.y - this._npc.height;
            SceneManager.active.mapModel.content.addChild(this._acceptMark);
        } else if (QuestManager.isAccepted(10043) && QuestManager.isComplete(10043) == false) {
            if (this._inprogressMark == null) {
                this._inprogressMark = new InProgressMark();
            }
            this._inprogressMark.x = this._npc.x;
            this._inprogressMark.y = this._npc.y - this._npc.height;
            SceneManager.active.mapModel.content.addChild(this._inprogressMark);
        }
    }

    private function clearLayout():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClickStep4);
            MobileManager.removeMobile(this._npc, MobileType.NPC);
            this._npc = null;
        }
        if (this._acceptMark) {
            DisplayObjectUtil.removeFromParent(this._acceptMark);
            this._acceptMark = null;
        }
        if (this._inprogressMark) {
            DisplayObjectUtil.removeFromParent(this._inprogressMark);
            this._inprogressMark = null;
        }
    }

    override public function dispose():void {
        this.clearLayout();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        DialogPanel.removeEventListener(DialogPanelEvent.QUEST_UNIT_CLICK, this.onOpenQuestModule);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.onMapStart);
        super.dispose();
    }
}
}
