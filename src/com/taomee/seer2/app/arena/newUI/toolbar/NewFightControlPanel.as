package com.taomee.seer2.app.arena.newUI.toolbar {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.events.OperateEvent;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.arena.util.ControlPanelUtil;
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.arena.util.FightPostion;
import com.taomee.seer2.app.config.FitConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.gameRule.door.DoorArenaRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.inventory.constant.PetItemType;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import seer2.next.fight.auto.AutoFightPanel;

public class NewFightControlPanel extends Sprite {


    private var _arenaData:ArenaDataInfo;

    private var _controlledTeam:FighterTeam;

    private var _oppositeTeam:FighterTeam;

    private var _controlledFighter:Fighter;

    private var _back:Sprite;

    private var _changPet:MovieClip;

    private var _hubButtonPanel:NewHubButtonPanel;

    private var _skillPanel:NewSkillPanel;

    private var _itemPanel:NewItemPanel;

    private var _capsulePanel:NewItemPanel;

    private var _fighterPanel:NewFighterPanel;

    private var _par:Sprite;

    public function NewFightControlPanel() {
        super();
        this._back = FightUIManager.getSprite("New_UI_FightBarBack");
        addChild(this._back);
        this._skillPanel = new NewSkillPanel();
        this._skillPanel.y = 41;
        this._fighterPanel = new NewFighterPanel();
        this._itemPanel = new NewItemPanel(PetItemType.PHYSICAL_MEDICINE);
        this._capsulePanel = new NewItemPanel(PetItemType.CAPSULE);
        this._hubButtonPanel = new NewHubButtonPanel();
        addChild(this._hubButtonPanel);
        this._changPet = this._back["changPet"];
        this._changPet.visible = false;
        this._hubButtonPanel.addEventListener(NewHubButtonPanel.EVT_FIGHT, this.onFightClick);
        this._hubButtonPanel.addEventListener(NewHubButtonPanel.EVT_ITEM, this.onItemClick);
        this._hubButtonPanel.addEventListener(NewHubButtonPanel.EVT_PET, this.onPetClick);
        this._hubButtonPanel.addEventListener(NewHubButtonPanel.EVT_ESCAPE, this.onEscapeClick);
        this._hubButtonPanel.addEventListener(NewHubButtonPanel.EVT_CATCH, this.onCatchClick);
        this._skillPanel.addEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._fighterPanel.addEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._fighterPanel.addEventListener(OperateEvent.FIGHT_SELECT_SKILL, this.onFightSelectSkill);
        this._itemPanel.addEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._itemPanel.addEventListener(OperateEvent.ERROR, this.onItemPanelTurnError);
        this._itemPanel.addEventListener(OperateEvent.FIGHT_SELECT_ITEM, this.onFightSelectItem);
        this._capsulePanel.addEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
    }

    public function active():void {
        this._skillPanel.active();
        this._hubButtonPanel.active();
        this._itemPanel.active();
        this._capsulePanel.active();
        this._fighterPanel.active();
        this.updateHubButtonPanel();
        this.update();
    }

    public function deactive():void {
        this._hubButtonPanel.deactive();
        this._skillPanel.deactive();
        this._itemPanel.deactive();
        this._capsulePanel.deactive();
        this._fighterPanel.deactive();
    }

    public function addPar(param1:Sprite):void {
        this._par = param1;
        this._hubButtonPanel.addPar(this._par);
    }

    public function initPanelInfo(param1:ArenaDataInfo):void {
        this._arenaData = param1;
        this._controlledTeam = param1.leftTeam;
        this._oppositeTeam = param1.rightTeam;
        this.updateOppositeFighter();
        var _loc2_:ButtonPanelData = ControlPanelUtil.getSettingData(this._arenaData.fightMode);
        this._arenaData.btnPanelData.merge(_loc2_);
    }

    public function updateControlledFighter(param1:Fighter):void {
        this._controlledFighter = param1;
        this._itemPanel.setControlledFighter(this._controlledFighter);
        this._capsulePanel.setControlledFighter(this._controlledFighter);
        this._skillPanel.setFighter(this._controlledFighter);
        this.updateOppositeFighter();
    }

    public function updateOppositeFighter():void {
        this._itemPanel.setOppositeFighter(this._oppositeTeam.mainFighter);
        this._capsulePanel.setOppositeFighter(this._oppositeTeam.mainFighter);
    }

    public function update():void {
        this._skillPanel.updateSkillBtn();
        this._fighterPanel.update();
        this.showSkillBtnLightRingByQuest1();
    }

    public function showSkillPanel():void {
        this.hideAll();
        addChild(this._skillPanel);
        this._skillPanel.setFighter(this._controlledFighter);
        this._hubButtonPanel.highlightFightBtn();
    }

    public function hideSkillPanel():void {
        this._skillPanel.deactive();
    }

    public function showFighterPanel(param1:uint = 0):void {
        this.hideAll();
        this._fighterPanel.setFighterTeam(this._controlledTeam, param1);
        addChild(this._fighterPanel);
        this._hubButtonPanel.highlightPetBtn();
        if (!this._arenaData.isDoubleMode) {
            this._fighterPanel.updatePetPress(this._oppositeTeam.mainFighter.fighterInfo.typeId);
        }
    }

    public function changeTeam(param1:String, param2:uint, param3:uint):void {
        var _loc4_:Fighter = null;
        var _loc5_:Fighter = null;
        var _loc8_:int = 0;
        var _loc9_:int = 0;
        var _loc6_:Vector.<Fighter> = this._controlledTeam.fighterVec;
        var _loc7_:Vector.<Fighter> = this._controlledTeam.changeFighterVec;
        _loc5_ = this._controlledTeam.getFighter(ActorManager.actorInfo.id, param2);
        _loc4_ = this._controlledTeam.getChangeFighter(ActorManager.actorInfo.id, param3);
        _loc8_ = this._controlledTeam.fighterVec.indexOf(_loc5_);
        _loc9_ = this._controlledTeam.changeFighterVec.indexOf(_loc4_);
        this._controlledTeam.fighterVec[_loc8_] = _loc4_;
        this._controlledTeam.changeFighterVec[_loc9_] = _loc5_;
        if (param1 == "changePet") {
            _loc4_.fighterInfo.fightAnger = 20;
        } else if (param1 == "die") {
            _loc4_.fighterInfo.hp = 0;
        }
    }

    private function onFightSelectSkill(param1:OperateEvent):void {
        this.showSkillPanel();
    }

    public function automate():void {
        var _loc1_:OperateEvent = null;
        var _loc2_:int = 0;
        var _loc3_:Vector.<SkillInfo> = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:SkillInfo = null;
        var _loc7_:SkillInfo = null;
        var _loc8_:FighterInfo = null;
        if (this._controlledFighter.fighterInfo.hp > 0) {
            this.showSkillPanel();
            _loc2_ = -1;
            if (this._controlledFighter.fighterInfo.hasSuperSkill()) {
                if ((_loc6_ = this._controlledFighter.fighterInfo.getSuperSkill()) != null && this._controlledFighter.fighterInfo.checkSkillAnger(_loc6_)) {
                    _loc2_ = int(_loc6_.id);
                    _loc1_ = new OperateEvent(OperateEvent.OPERATE_SKILL, _loc2_, OperateEvent.OPERATE_END);
                    this.endInput(_loc1_);
                    return;
                }
            }
            _loc3_ = this._controlledFighter.fighterInfo.skillInfoVec;
            _loc4_ = int(_loc3_.length);
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc7_ = _loc3_[_loc5_];
                if (this._controlledFighter.fighterInfo.checkSkillAnger(_loc7_)) {
                    _loc2_ = int(_loc7_.id);
                    break;
                }
                _loc5_++;
            }
            if (_loc2_ == -1) {
                _loc2_ = int(_loc3_[0].id);
            }
            _loc1_ = new OperateEvent(OperateEvent.OPERATE_SKILL, _loc2_, OperateEvent.OPERATE_END);
        } else {
            this.showFighterPanel();
            if ((_loc8_ = this._controlledTeam.getRandomAliveFighterInfo()) != null) {
                _loc1_ = new OperateEvent(OperateEvent.OPERATE_FIGHTER, _loc8_.catchTime, OperateEvent.OPERATE_END);
            }
        }
        this.endInput(_loc1_);
    }

    public function automate2():void {
        var op:int = AutoFightPanel.instance().getOperation();
        showSkillPanel();
        if (op < 6) {
            this.skillOp(op);
        } else if (op == 6) {
            this.runOp();
        } else if (op == 7) {
            this.cure();
        } else if (op == 8) {
            this.capture();
        } else if (op > 20 && op < 30) {
            angerSupplement(op);
        } else if (op > 10 && op < 20) {
            changeOp(op);
        }
    }

    private function skillOp(skillIndex:int):void {
        if (this._controlledFighter.fighterInfo.hp > 0) {
            var skillId:int = int(this._controlledFighter.fighterInfo.skillInfoVec[skillIndex].id);
            this.endInput(new OperateEvent(OperateEvent.OPERATE_SKILL, skillId, OperateEvent.OPERATE_END));
            return;
        }
        showFighterPanel();
        var p:FighterInfo = null;
        if ((p = this._controlledTeam.getRandomAliveFighterInfo()) != null) {
            this.endInput(new OperateEvent(OperateEvent.OPERATE_FIGHTER, p.catchTime, OperateEvent.OPERATE_END));
        }
    }

    private function runOp():void {
        endInput(new OperateEvent(OperateEvent.OPERATE_ESCAPE, 0, OperateEvent.OPERATE_END));
    }

    private function cure():void {
        var oe:OperateEvent = new OperateEvent(OperateEvent.OPERATE_ITEM_USE_MEDICINE, 200019, OperateEvent.OPERATE_END);
        oe.fighterId = this._controlledFighter.id;
        endInput(oe);
    }

    private function capture():void {
        endInput(new OperateEvent(OperateEvent.OPERATE_ITEM_CATCH_PET, 200003, OperateEvent.OPERATE_END));
    }

    private function angerSupplement(param:uint):void {
        var oe:OperateEvent = new OperateEvent(OperateEvent.OPERATE_ITEM_USE_MEDICINE, 200000 + param, OperateEvent.OPERATE_END);
        oe.fighterId = this._controlledFighter.id;
        endInput(oe);
    }

    private function changeOp(petIndex:int):void {
        this.showFighterPanel();
        var o:FighterInfo = this._controlledTeam.fighterVec[petIndex - 11].fighterInfo;
        if (o.position != FightPostion.INACTIVE) {
            skillOp(0);
        } else if (o.hp > 0) {
            endInput(new OperateEvent(OperateEvent.OPERATE_FIGHTER, o.catchTime, OperateEvent.OPERATE_END));
        } else if (o.hp == 0) {
            var oe:OperateEvent = new OperateEvent(OperateEvent.OPERATE_RESURRECTION, 200064, OperateEvent.OPERATE_END);
            oe.fighterId = o.catchTime;
            endInput(oe);
        }
    }

    private function hideAll():void {
        DisplayObjectUtil.removeFromParent(this._capsulePanel);
        DisplayObjectUtil.removeFromParent(this._fighterPanel);
        DisplayObjectUtil.removeFromParent(this._itemPanel);
        DisplayObjectUtil.removeFromParent(this._skillPanel);
    }

    private function updateHubButtonPanel():void {
        this._hubButtonPanel.unhighlightAll();
        this._hubButtonPanel.catchBtnLightRingEnabled = false;
        var _loc1_:ButtonPanelData = new ButtonPanelData();
        if (this._controlledFighter.fighterInfo.hp == 0) {
            _loc1_.setDeadFightConfig();
        } else {
            _loc1_.merge(this._arenaData.btnPanelData);
        }
        if (this._arenaData.isDoubleMode) {
            _loc1_.catchEnabled = false;
        } else if (this._oppositeTeam.mainFighter.fighterInfo.isCatchable == false) {
            _loc1_.catchEnabled = false;
        }
        if (PetConfig.getPetDefinition(this._controlledFighter.fighterInfo.resourceId).chgMonId != 0) {
            this._changPet.visible = true;
            TooltipManager.addCommonTip(this._changPet, PetConfig.getPetDefinitionInfo(this._controlledFighter.fighterInfo.resourceId).changeTip);
        } else {
            this._changPet.visible = false;
        }
        _loc1_.catchEnabled &&= this._arenaData.canCatch;
        if (this._arenaData.canCatchAfterSptDeadNow) {
            _loc1_.catchEnabled = true;
        }
        var _loc2_:int = int(this._arenaData.fightMode);
        if (_loc2_ == FightMode.FIGHT_PVP_DOOR_NORMAL || _loc2_ == FightMode.FIGHT_PVP_DOOR_50V50) {
            if (DoorArenaRule.current_arena_rule == DoorRule.ATLETICO_DOOR) {
                _loc1_.petEnabled = false;
            }
        }
        this._hubButtonPanel.fightEnabled = _loc1_.fightEnabled;
        this._hubButtonPanel.catchEnabled = _loc1_.catchEnabled;
        this._hubButtonPanel.itemEnabled = _loc1_.itemEnabled;
        this._hubButtonPanel.petEnabled = _loc1_.petEnabled;
        this._hubButtonPanel.escapeEnabled = _loc1_.escapeEnabled;
        this.disableEscapeButtonByQuest1();
        this.showCatchLightRingByQuest3();
    }

    private function onOperateEnd(param1:OperateEvent):void {
        this.endInput(param1);
    }

    private function onItemPanelTurnError(param1:OperateEvent):void {
        this.showSkillPanel();
    }

    private function onFightClick(param1:Event):void {
        this.showSkillPanel();
    }

    public function itemPanelUpdate():void {
        this._itemPanel.resetData();
    }

    private function onItemClick(param1:Event):void {
        this.hideAll();
        this._itemPanel.reset();
        addChild(this._itemPanel);
    }

    private function onFightSelectItem(param1:OperateEvent):void {
        this.showFighterPanel(param1.id);
    }

    private function onPetClick(param1:Event):void {
        if (FitConfig.isPetFit(this._controlledFighter.fighterInfo.bunchId)) {
            AlertManager.showAlert("合体中不可更换精灵！");
            return;
        }
        this.showFighterPanel();
    }

    private function onEscapeClick(param1:Event):void {
        if (this._arenaData.isFightEnd == false) {
            this.endInput(new OperateEvent(OperateEvent.OPERATE_ESCAPE, 0, OperateEvent.OPERATE_END));
        }
    }

    private function onCatchClick(param1:Event):void {
        this.hideAll();
        this._capsulePanel.reset();
        addChild(this._capsulePanel);
    }

    private function endInput(param1:OperateEvent):void {
        this.deactive();
        dispatchEvent(param1);
    }

    public function getHubButtonPanel():NewHubButtonPanel {
        return this._hubButtonPanel;
    }

    public function dispose():void {
        DisplayObjectUtil.removeAllChildren(this);
        this._hubButtonPanel.removeEventListener(NewHubButtonPanel.EVT_FIGHT, this.onFightClick);
        this._hubButtonPanel.removeEventListener(NewHubButtonPanel.EVT_ITEM, this.onItemClick);
        this._hubButtonPanel.removeEventListener(NewHubButtonPanel.EVT_PET, this.onPetClick);
        this._hubButtonPanel.removeEventListener(NewHubButtonPanel.EVT_ESCAPE, this.onEscapeClick);
        this._hubButtonPanel.removeEventListener(NewHubButtonPanel.EVT_CATCH, this.onCatchClick);
        this._skillPanel.removeEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._fighterPanel.removeEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._itemPanel.removeEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._itemPanel.removeEventListener(OperateEvent.ERROR, this.onItemPanelTurnError);
        this._capsulePanel.removeEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        this._back = null;
        this._skillPanel.dispose();
        this._skillPanel = null;
        this._itemPanel.dispose();
        this._itemPanel = null;
        this._capsulePanel.dispose();
        this._capsulePanel = null;
        this._fighterPanel.dispose();
        this._fighterPanel = null;
        this._controlledTeam = null;
        this._controlledFighter = null;
        this._oppositeTeam = null;
        this._hubButtonPanel.dispose();
        this._hubButtonPanel = null;
    }

    private function disableEscapeButtonByQuest1():void {
        if (QuestManager.isComplete(1) == false) {
            this._hubButtonPanel.escapeEnabled = false;
        }
    }

    private function showCatchLightRingByQuest3():void {
        var _loc1_:Fighter = this._oppositeTeam.mainFighter;
        if (QuestManager.isStepComplete(3, 2) && QuestManager.isStepComplete(3, 3) == false && _loc1_.fighterInfo.resourceId == 10) {
            this._hubButtonPanel.catchBtnLightRingEnabled = true;
        }
    }

    private function showSkillBtnLightRingByQuest1():void {
        if (QuestManager.isStepComplete(1, 3) && QuestManager.isStepComplete(1, 4) == false) {
            this._skillPanel.skillBtnLightRingEnabled = true;
        }
    }
}
}
