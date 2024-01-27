package com.taomee.seer2.app.processor.quest.handler.main.quest99 {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.controls.widget.JLWidgetClick;
import com.taomee.seer2.app.controls.widget.NonoInputFrameWidget;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.event.LogicEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
import com.taomee.seer2.app.pet.PetIsHaveNumberManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.questTiny.QuestTinyPanel;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.ResContentLibrary;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.ModelLocator;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_99_80491 extends QuestMapHandler {

    public static var isClickQuest99_3:Boolean = false;

    public static var isClickQuest99_5:Boolean = false;

    public static var isClickQuest99_6:Boolean = false;

    private static const AWARD_FOR:int = 206072;


    private var _npc:MovieClip;

    private var _guidMc1:MovieClip;

    private var _guidMc2:MovieClip;

    public function QuestMapHandler_99_80491(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        ActorManager.getActor().blockNoNo = true;
        ModelLocator.getInstance().addEventListener(LogicEvent.NEW_GUIDE_BROAD1, this.onGetGuideTip);
        ModelLocator.getInstance().addEventListener(LogicEvent.NEW_GUIDE_BROAD3, this.onGetGuideTip3);
        ModelLocator.getInstance().addEventListener(LogicEvent.NEW_GUIDE_BROAD4, this.onGetGuideTip4);
        ModelLocator.getInstance().addEventListener(LogicEvent.NEW_GUIDE_BROAD5, this.onGetGuideTip5);
        ModelLocator.getInstance().addEventListener(LogicEvent.NEW_GUIDE_BROAD6, this.onGetGuideTip6);
        ModelLocator.getInstance().addEventListener(LogicEvent.NEW_GUIDE_BROAD8, this.onGetGuideTip8);
        ToolBar.getBtn(NonoInputFrameWidget.NONOINPUT).visible = false;
        if (ToolBar.getBtn(JLWidgetClick.J_L)) {
            if (NewPlayerGuideTimeManager.timeCheckNewGuide() && !QuestManager.isComplete(99)) {
                ToolBar.getBtn(JLWidgetClick.J_L).visible = false;
            } else {
                ToolBar.getBtn(JLWidgetClick.J_L).visible = true;
            }
        }
        if (QuestManager.isComplete(99)) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
            return;
        }
        if (QuestManager.isCanAccepted(questID)) {
            ActiveCountManager.requestActiveCount(AWARD_FOR, function (param1:uint, param2:uint):void {
                if (param1 == AWARD_FOR) {
                    if (param2 > 0) {
                        nextQuestProcessor();
                    } else {
                        ModuleManager.addEventListener("NewerSignFivePanel", ModuleEvent.HIDE, onNewerSignHide);
                        ModuleManager.showAppModule("NewerSignFivePanel");
                    }
                }
            });
        } else if (QuestManager.isAccepted(questID)) {
            this.nextQuestProcessor();
        } else if (QuestManager.isComplete(questID)) {
            this.questHandle8();
        }
        RightToolbarConter.instance.newPlayerShowFilter();
    }

    private function onNewerSignHide(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("NewerSignFivePanel", ModuleEvent.HIDE, this.onNewerSignHide);
        this.nextQuestProcessor();
    }

    private function play7Fun(param1:Boolean):void {
        if (param1) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(_quest.id, 7);
        } else {
            this._npc = this.getMC();
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpc7);
            StatisticsManager.newSendNovice("新手引导tyler版", "2014上半年版新手引导tyler版", "进入捕捉试炼3");
        }
    }

    private function nextQuestProcessor():void {
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            if (SceneManager.prevSceneType == SceneType.GUIDE_NEW_ARENA1) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
                QuestManager.completeStep(_quest.id, 1);
            } else {
                this.questHandle1();
            }
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 2)) {
            if (SceneManager.prevSceneType == SceneType.GUIDE_NEW_ARENA2) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
                QuestManager.completeStep(_quest.id, 2);
            } else {
                this.questHandle2();
            }
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 3)) {
            this.questHandle3();
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 4)) {
            if (SceneManager.prevSceneType == SceneType.GUIDE_NEW_ARENA3) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
                QuestManager.completeStep(_quest.id, 4);
            } else {
                this.questHandle4();
            }
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 5)) {
            this.questHandle5();
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 6)) {
            this.questHandle6();
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 7)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                if (FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == 1686) {
                    ToolBar.getBtn(NonoInputFrameWidget.NONOINPUT).visible = true;
                    QuestManager.addEventListener(QuestEvent.COMPLETE, this.onStepComplete1);
                    QuestManager.completeStep(_quest.id, 7);
                } else if (FightManager.fightWinnerSide == FightSide.RIGHT && FightManager.currentFightRecord.initData.positionIndex == 1686) {
                    this.questHandle7();
                    NpcDialog.show(1, "船长辛迪", [[0, "小赛尔，是不是战斗有些难呢，发动你的聪明才智，去努力<font color=\'#ff0000\'><b>提升战力</b></font>，再来试试吧，相信你会通过的！"]], ["知道了"], [function ():void {
                        NewGuidStatisManager.newPlayerStatisHandle(13);
                        ModuleManager.showAppModule("NewGuidelines");
                    }]);
                } else {
                    this.questHandle7();
                }
            } else {
                this.questHandle7();
            }
        }
    }

    private function showTaskPanel():void {
        NewGuidStatisManager.newPlayerStatisHandle(5);
        ModuleManager.showModule(URLUtil.getAppModule("DreamPetProcessPanel"), "正在打开面板...");
    }

    private function onGetGuideTip(param1:LogicEvent):void {
        this._guidMc1 = _processor.resLib.getMovieClip("mc1");
        LayerManager.topLayer.addChild(this._guidMc1);
        ResContentLibrary.setInitValue(this._guidMc1);
        ResContentLibrary.updateRes();
        this._guidMc1.addEventListener(MouseEvent.CLICK, this.onGuidMc1);
    }

    private function onGetGuideTip4(param1:LogicEvent):void {
        this._guidMc1 = _processor.resLib.getMovieClip("mc1");
        LayerManager.topLayer.addChild(this._guidMc1);
        ResContentLibrary.setInitValue(this._guidMc1);
        ResContentLibrary.updateRes();
        this._guidMc1.addEventListener(MouseEvent.CLICK, this.onGuidMc4);
    }

    private function onGetGuideTip6(param1:LogicEvent):void {
        this._guidMc1 = _processor.resLib.getMovieClip("mc1");
        LayerManager.topLayer.addChild(this._guidMc1);
        ResContentLibrary.setInitValue(this._guidMc1);
        ResContentLibrary.updateRes();
        this._guidMc1.addEventListener(MouseEvent.CLICK, this.onGuidMc6);
    }

    private function onGetGuideTip8(param1:LogicEvent):void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(_quest.id, 6);
    }

    private function onGuidMc4(param1:MouseEvent):void {
        DisplayUtil.removeForParent(this._guidMc1);
        isClickQuest99_5 = true;
        ModuleManager.showAppModule("PetBagPanel", {
            "type": 0,
            "subType": 0
        });
    }

    private function onGuidMc6(param1:MouseEvent):void {
        DisplayUtil.removeForParent(this._guidMc1);
        isClickQuest99_6 = true;
        ModuleManager.showAppModule("PetBagPanel", {
            "type": 0,
            "subType": 0
        });
    }

    private function onGetGuideTip3(param1:LogicEvent):void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(_quest.id, 3);
    }

    private function onGetGuideTip5(param1:LogicEvent):void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(_quest.id, 5);
    }

    private function onGuidMc1(param1:MouseEvent):void {
        DisplayUtil.removeForParent(this._guidMc1);
        isClickQuest99_3 = true;
        ModuleManager.showAppModule("PetBagPanel", {
            "type": 0,
            "subType": 0
        });
    }

    private function questHandle1():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc1);
        NewGuidStatisManager.newPlayerStatisHandle(5);
    }

    private function questHandle2():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc2);
    }

    private function questHandle3():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc3);
    }

    private function questHandle5():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc5);
    }

    private function questHandle6():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc6);
    }

    private function questHandle7():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc7);
    }

    private function questHandle8():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc8);
    }

    private function onNpc8(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("NewPlayerProcessWayPanel"), "...");
    }

    private function onNpc3(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    private function questHandle4():void {
        this._npc = this.getMC();
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc4);
    }

    private function onNpc1(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    private function onNpc2(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    private function onNpc4(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    private function isPet(param1:Function):void {
        var backBack:Function = param1;
        PetIsHaveNumberManager.requestIsHavePet(Vector.<uint>([1]), function ():void {
            if (PetIsHaveNumberManager.petIsHave(1)) {
                backBack(true);
            } else {
                backBack(false);
            }
        });
    }

    private function getMC():MovieClip {
        var _loc1_:MovieClip = _map.content["npc"].actor;
        _map.content["npc"].buttonMode = true;
        return _map.content["npc"];
    }

    private function onStepComplete1(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete1);
        this.questHandle8();
        QuestTinyPanel.instance.show();
        RightToolbarConter.instance.newPlayerShowFilter();
        NewGuidStatisManager.newPlayerStatisHandle(12);
        ModuleManager.showAppModule("NewPlayerProcessWayPanel");
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (param1.stepId == 1) {
            this.questHandle1();
            NewGuidStatisManager.newPlayerStatisHandle(6);
            ModuleManager.showAppModule("DreamPetProcessCompletePanel", {"index": param1.stepId});
        } else if (param1.stepId == 2) {
            this.questHandle2();
            NewGuidStatisManager.newPlayerStatisHandle(7);
            ModuleManager.showAppModule("DreamPetProcessCompletePanel", {"index": param1.stepId});
        } else if (param1.stepId == 3) {
            isClickQuest99_3 = false;
            this.questHandle3();
            NewGuidStatisManager.newPlayerStatisHandle(8);
            ModuleManager.showAppModule("DreamPetProcessCompletePanel", {"index": param1.stepId});
        } else if (param1.stepId == 4) {
            this.questHandle4();
            NewGuidStatisManager.newPlayerStatisHandle(9);
            ModuleManager.addEventListener("DreamPetProcessCompletePanel", ModuleEvent.HIDE, this.onComHide);
            ModuleManager.showAppModule("DreamPetProcessCompletePanel", {"index": param1.stepId});
        } else if (param1.stepId == 5) {
            isClickQuest99_5 = false;
            this.questHandle5();
            NewGuidStatisManager.newPlayerStatisHandle(10);
            ModuleManager.showAppModule("DreamPetProcessCompletePanel", {"index": param1.stepId});
        } else if (param1.stepId == 6) {
            isClickQuest99_6 = false;
            this.questHandle6();
            NewGuidStatisManager.newPlayerStatisHandle(11);
            ModuleManager.showAppModule("DreamPetProcessCompletePanel", {"index": param1.stepId});
        }
    }

    private function onComHide(param1:ModuleEvent):void {
        var evt:ModuleEvent = param1;
        ModuleManager.removeEventListener("DreamPetProcessCompletePanel", ModuleEvent.HIDE, this.onComHide);
        this._guidMc2 = _processor.resLib.getMovieClip("guidMc2");
        LayerManager.topLayer.addChild(this._guidMc2);
        MovieClipUtil.playMc(this._guidMc2["mc"], 2, this._guidMc2["mc"].totalFrames, function ():void {
            (_guidMc2["mc"] as MovieClip).gotoAndStop((_guidMc2["mc"] as MovieClip).totalFrames);
        });
        ResContentLibrary.setInitValue(this._guidMc2);
        ResContentLibrary.updateRes();
        this._guidMc2.addEventListener(MouseEvent.CLICK, this.onGuidMc2Click);
    }

    private function onGuidMc2Click(param1:MouseEvent):void {
        this._guidMc2.removeEventListener(MouseEvent.CLICK, this.onGuidMc2Click);
        DisplayUtil.removeForParent(this._guidMc2);
    }

    private function onNpc7(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    private function onNpc5(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    private function onNpc6(param1:MouseEvent):void {
        this.showTaskPanel();
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        ActorManager.getActor().blockNoNo = false;
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD1, this.onGetGuideTip);
        DisplayUtil.removeForParent(this._guidMc1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete1);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc1);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc2);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc3);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc4);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc5);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc6);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc7);
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc8);
        ResContentLibrary.clearInitValue(this._guidMc1);
        ResContentLibrary.clearInitValue(this._guidMc2);
        if (this._guidMc1) {
            this._guidMc1.removeEventListener(MouseEvent.CLICK, this.onGuidMc1);
            this._guidMc1.removeEventListener(MouseEvent.CLICK, this.onGuidMc4);
            this._guidMc1.removeEventListener(MouseEvent.CLICK, this.onGuidMc6);
            this._guidMc1 = null;
        }
        if (this._guidMc2) {
            this._guidMc2.removeEventListener(MouseEvent.CLICK, this.onGuidMc2Click);
            this._guidMc2 = null;
        }
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD1, this.onGetGuideTip);
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD3, this.onGetGuideTip3);
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD4, this.onGetGuideTip4);
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD5, this.onGetGuideTip5);
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD6, this.onGetGuideTip6);
        ModelLocator.getInstance().removeEventListener(LogicEvent.NEW_GUIDE_BROAD8, this.onGetGuideTip8);
    }
}
}
