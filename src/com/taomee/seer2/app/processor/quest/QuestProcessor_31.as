package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.controls.MinorToolBar;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.guide.info.GudieDirectionType;
import com.taomee.seer2.app.guide.manager.GuideManager;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.geom.Point;
import flash.geom.Rectangle;

public class QuestProcessor_31 extends QuestProcessor {


    private var _npcDefintion:NpcDefinition;

    private var _ani:MovieClip;

    public function QuestProcessor_31(param1:Quest) {
        super(param1);
    }

    override public function init():void {
        super.init();
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        } else if (_quest.status == QuestStatus.IN_PROGRESS) {
            this.processStep();
        }
    }

    private function playTrainerAni():void {
        if (!this._ani) {
            this._ani = UIManager.getMovieClip("UI_TrainerAni");
        }
        LayerManager.moduleLayer.addChild(this._ani);
        MovieClipUtil.playMc(this._ani, 1, this._ani.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_ani);
            MinorToolBar.showTrainerAni();
            RightToolbarConter.instance.show();
            var _loc1_:Rectangle = new Rectangle(0, 0, 52, 45);
            GuideManager.instance.addTarget(_loc1_, 0);
            GuideManager.instance.addGuide2Target(_loc1_, 0, 0, new Point(1126, 6), false, false, GudieDirectionType.CONTENT, true);
            GuideManager.instance.startGuide(0);
            ModuleManager.addEventListener("QuestPanel", ModuleEvent.SHOW, onShowQuest);
            SceneManager.addEventListener(SceneEvent.SWITCH_START, onSwitchStart);
        }, true);
    }

    private function hideGudie(param1:ModuleEvent):void {
        if (_quest.id == 31) {
            GuideManager.instance.pause();
        }
    }

    private function onShowQuest(param1:ModuleEvent):void {
        var _loc2_:Rectangle = null;
        if (_quest.id == 31) {
            _loc2_ = new Rectangle(0, 0, 66, 25);
            GuideManager.instance.addTarget(_loc2_, 1);
            GuideManager.instance.addGuide2Target(_loc2_, 0, 1, new Point(636, 214), false, false, GudieDirectionType.CONTENT, false, true);
            GuideManager.instance.startGuide(1);
        }
    }

    private function onSwitchStart(param1:SceneEvent):void {
        ModuleManager.removeEventListener("QuestPanel", ModuleEvent.SHOW, this.onShowQuest);
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.onSwitchStart);
        GuideManager.instance.close();
        RightToolbarConter.instance.hide();
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            this.playTrainerAni();
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            ServerMessager.addMessage("将问候信带给草目氏族的酋长吧！");
            this.processStep();
        }
    }

    private function processStep():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onCompleteStep);
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArrive);
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onCompleteStep);
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArrive);
            if (this._npcDefintion) {
                this._npcDefintion.resetFunctionalityData();
                this._npcDefintion = null;
            }
        }
    }

    private function onActorArrive(param1:NpcEvent):void {
        var _loc2_:XML = null;
        if (param1.npcDefinition.id == 1) {
            this._npcDefintion = param1.npcDefinition;
            this._npcDefintion.resetFunctionalityData();
            _loc2_ = <node type="quest" name="结盟之路" params="31_1"/>;
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 0);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    private function onUnit(param1:DialogPanelEvent):void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        if (param1.content.params == "31_1") {
            NpcDialog.show(1, "船长", [[0, "尽快把我的问候信交给草目氏族的族长，见到族长，运用你的机智，随机应变，结盟，只能成功！"]], ["是！船长！"]);
        }
    }

    override public function dispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onCompleteStep);
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArrive);
        if (this._npcDefintion) {
            this._npcDefintion.resetFunctionalityData();
            this._npcDefintion = null;
        }
        super.dispose();
    }
}
}
