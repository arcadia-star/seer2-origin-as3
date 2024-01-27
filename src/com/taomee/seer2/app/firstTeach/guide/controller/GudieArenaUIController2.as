package com.taomee.seer2.app.firstTeach.guide.controller {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
import com.taomee.seer2.app.arena.animation.ArenaAnimationType;
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
import com.taomee.seer2.app.arena.controller.IArenaUIController;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.data.FighterTurnResultInfo;
import com.taomee.seer2.app.arena.data.ItemUseResultInfo;
import com.taomee.seer2.app.arena.data.TurnResultInfo;
import com.taomee.seer2.app.arena.decoration.DecorationControl;
import com.taomee.seer2.app.arena.events.OperateEvent;
import com.taomee.seer2.app.arena.newUI.toolbar.FightPointPanel;
import com.taomee.seer2.app.arena.newUI.toolbar.NewFightControlPanel;
import com.taomee.seer2.app.arena.ui.status.StatusPanelFactory;
import com.taomee.seer2.app.arena.ui.status.panel.*;
import com.taomee.seer2.app.arena.ui.toolbar.FightControlPanel;
import com.taomee.seer2.app.arena.util.FightState;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;
import flash.utils.ByteArray;

public class GudieArenaUIController2 implements IArenaUIController {


    private var _scene:ArenaScene;

    private var _controlPanel:*;

    private var _statusPanel:FightStatusPanel;

    private var _fightPointPanel:FightPointPanel;

    private var _contentValue:Sprite;

    private var _petContentValue:Sprite;

    private var _operateFighters:Vector.<Fighter>;

    public function GudieArenaUIController2(param1:ArenaScene) {
        super();
        this._scene = param1;
        this.createControlPanel();
        this.createStatusPanel();
        this.createPointPanel();
    }

    private function createControlPanel():void {
        this._controlPanel = this.creControl();
        DecorationControl._trunCount = 0;
        if (ArenaUIIsNew.isNewUI == false) {
            this._controlPanel.x = 0;
            this._controlPanel.y = 513;
        } else {
            this._controlPanel.x = 246;
            this._controlPanel.y = 570;
        }
        this._contentValue = new Sprite();
        this._scene.mapModel.front.addChild(this._contentValue);
        this._contentValue.addChild(this._controlPanel);
        this._controlPanel.initPanelInfo(this._scene.arenaData);
        this._controlPanel.updateControlledFighter(this.getLeftTeam().mainFighter);
    }

    public function hideSkillPanel():void {
        this._controlPanel.hideSkillPanel();
    }

    public function getContent():Sprite {
        return this._contentValue;
    }

    public function layOut():void {
        this._contentValue.scaleX = LayerManager.stage.stageWidth / 1200;
        this._contentValue.scaleY = LayerManager.stage.stageHeight / 660;
    }

    protected function creControl():* {
        if (ArenaUIIsNew.isNewUI == false) {
            return new FightControlPanel();
        }
        return new NewFightControlPanel();
    }

    private function createPointPanel():void {
        this._fightPointPanel = new FightPointPanel();
        this._fightPointPanel.y = 541;
        this._contentValue.addChild(this._fightPointPanel);
    }

    private function createStatusPanel():void {
        this._statusPanel = StatusPanelFactory.createStatusPanel(this._scene.arenaData);
        this._contentValue.addChild(this._statusPanel);
        this.updateStatusPanelInfo();
    }

    public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._controlPanel);
        this._controlPanel.dispose();
        this._controlPanel = null;
        DisplayObjectUtil.removeFromParent(this._statusPanel);
        this._statusPanel.dispose();
        this._statusPanel = null;
        DisplayObjectUtil.removeFromParent(this._fightPointPanel);
        this._fightPointPanel.dispose();
        this._fightPointPanel = null;
        DisplayObjectUtil.removeFromParent(this._contentValue);
        this._contentValue = null;
        DisplayObjectUtil.removeFromParent(this._petContentValue);
        this._petContentValue = null;
    }

    public function entryValue(param1:String):void {
        this._fightPointPanel.entryValue(param1);
    }

    public function startActiveFighter():void {
        ArenaAnimationManager.addPar(this._contentValue);
        this._scene.fightController.addPar(this._contentValue);
        this._petContentValue = new Sprite();
        var _loc1_:Sprite = this._scene.mapModel.content;
        _loc1_.addChild(this._petContentValue);
        var _loc2_:Fighter = this.getLeftTeam().mainFighter;
        _loc2_.active();
        _loc2_.visible = false;
        this._petContentValue.addChild(_loc2_);
        var _loc3_:Fighter = this.getLeftTeam().subFighter;
        if (_loc3_ != null) {
            _loc3_.active();
            _loc3_.visible = false;
            this._petContentValue.addChild(_loc3_);
        }
        var _loc4_:Fighter;
        (_loc4_ = this.getRightTeam().mainFighter).active();
        this._petContentValue.addChild(_loc4_);
        var _loc5_:Fighter;
        if ((_loc5_ = this.getRightTeam().subFighter) != null) {
            _loc5_.active();
            this._petContentValue.addChild(_loc5_);
        }
        this._scene.sortAllFighters();
    }

    public function startSelectOperate():void {
        this._operateFighters = new Vector.<Fighter>();
        this._operateFighters.push(this.getLeftTeam().mainFighter);
        if (this.getLeftTeam().subFighter != null) {
            this._operateFighters.push(this.getLeftTeam().subFighter);
        }
        this.fighterStartOperate(this._operateFighters.shift());
    }

    private function fighterStartOperate(param1:Fighter):void {
        var fighter:Fighter = param1;
        var onChangeComplete:Function = function ():void {
            _scene.sortAllFighters();
            activeControlSkillPanel(fighter);
            updateStatusPanelInfo();
        };
        this._controlPanel.addEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        if (fighter.isDead() && this._scene.arenaData.isDoubleMode) {
            this.onOperateEnd(null);
            return;
        }
        if (this._scene.arenaData.isDoubleMode) {
            ArenaAnimationManager.showIndiator(fighter);
        }
        onChangeComplete();
    }

    public function changeTeam(param1:String, param2:uint, param3:uint):void {
        this._controlPanel.changeTeam(param1, param2, param3);
    }

    private function activeControlSkillPanel(param1:Fighter):void {
        this._controlPanel.updateControlledFighter(param1);
        this._controlPanel.showSkillPanel();
        this._controlPanel.active();
    }

    public function activeControlPetPanel(param1:Fighter):void {
        this._controlPanel.updateControlledFighter(param1);
        this._controlPanel.showFighterPanel();
        this._controlPanel.active();
    }

    private function onOperateEnd(param1:OperateEvent):void {
        var sendMessageOver:Function = null;
        var evt:OperateEvent = param1;
        sendMessageOver = function ():void {
            fighterStartOperate(_operateFighters.shift());
        };
        this._controlPanel.removeEventListener(OperateEvent.OPERATE_END, this.onOperateEnd);
        ArenaAnimationManager.abortCountDown();
        if (this._scene.arenaData.isDoubleMode) {
            ArenaAnimationManager.hideIndiator();
        }
        if (this._operateFighters.length > 0) {
            this.sendMessage(evt, sendMessageOver);
        } else {
            this.sendMessage(evt);
            ArenaAnimationManager.showWaiting(this._scene.fightMode);
        }
    }

    private function sendMessage(param1:OperateEvent, param2:Function = null):void {
        if (param1 != null) {
            this.sendOperateMessage(param1.operateType, param1.id, param1.fighterId, param2);
        } else {
            this.sendOperateMessage(OperateEvent.OPERATE_SKILL, 0, 0, param2);
        }
    }

    private function updateAnger():void {
        var _loc1_:ByteArray = new ByteArray();
        var _loc2_:uint = 50233;
        var _loc3_:uint = 1;
        var _loc4_:uint = 13119;
        var _loc6_:SkillInfo;
        var _loc5_:Fighter;
        if ((_loc6_ = (_loc5_ = this._scene.leftTeam.getFighter(_loc2_, _loc3_)).fighterInfo.getSkillInfo(_loc4_)) != null) {
            _loc5_.fighterInfo.fightAnger -= _loc6_.anger;
        }
    }

    private function parserLeftTeamData():void {
        this._scene.fightController.changeFighter(50233, 1, 20, 1);
    }

    private function parserRightTeamData():void {
        this._scene.fightController.changeFighter(0, 2, 20, 1);
    }

    private function updateAnger2(param1:uint, param2:uint, param3:uint):void {
        var _loc4_:Fighter;
        (_loc4_ = this._scene.arenaData.getFighter(param1, param2)).updateAnger(param3);
    }

    private function parserSpecialDamage4():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(16321);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeShort(20);
        _loc1_.writeByte(1);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserSpecialDamage5():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(16243);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeShort(20);
        _loc1_.writeByte(1);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserSpecialDamage6():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(10046);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(450);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(1);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(101);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(500);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserDamage3():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().skillInfo.skillInfoVec[0].id);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().maxHp);
        _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().maxHp);
        _loc1_.writeShort(30);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(20);
        _loc1_.writeShort(40);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(20);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserDamage():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(380);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(40);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(13110);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(30);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(120);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserDamage1():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(300);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(40);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(10042);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(30);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(101);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(200);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserDamage_1():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(380);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(100);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(13077);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(380);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(120);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserDamage_2():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(450);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(100);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(10010);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(300);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function parserSpecialDamage():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(13119);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(380);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeShort(20);
        _loc1_.writeByte(1);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(380);
        _loc1_.position = 0;
        var _loc2_:TurnResultInfo = new TurnResultInfo(_loc1_);
        if (this.checkDummyAtk(_loc2_) == false) {
            this._scene.fightController.addTurnResultInfo(_loc2_);
        }
    }

    private function getNormalSkilId(param1:uint):uint {
        var _loc2_:uint = 0;
        switch (param1) {
            case 1:
                _loc2_ = 10001;
                break;
            case 4:
                _loc2_ = 10018;
                break;
            case 7:
                _loc2_ = 10034;
        }
        return _loc2_;
    }

    private function getSpecialSkilId(param1:uint):uint {
        var _loc2_:uint = 0;
        switch (param1) {
            case 1:
                _loc2_ = 10013;
                break;
            case 4:
                _loc2_ = 10030;
                break;
            case 7:
                _loc2_ = 10046;
        }
        return _loc2_;
    }

    private function checkDummyAtk(param1:TurnResultInfo):Boolean {
        var _loc3_:FighterTurnResultInfo = null;
        var _loc2_:Vector.<FighterTurnResultInfo> = param1.fighterTurnResultInfoVec;
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isAtker && _loc3_.skillId == 0) {
                return true;
            }
        }
        return false;
    }

    private function parseTurnResult():void {
        var _loc1_:uint = 2;
        this._scene.arenaData.turnCount = _loc1_;
        var _loc2_:uint = 0;
        this._scene.updateWeather(_loc2_);
        var _loc3_:String = this._scene.fightController.state;
        if (_loc3_ == FightState.CHANGE_LEFT_FIGHTER) {
            return;
        }
        if (_loc3_ == FightState.CATCH_FIGHTER_FAILED) {
            return;
        }
        this._scene.fightController.parseTurnResult();
    }

    private function updateEscape():void {
    }

    private function useItem():void {
        var _loc6_:Object = null;
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(200);
        _loc1_.writeUnsignedInt(200);
        _loc1_.writeShort(100);
        _loc1_.writeByte(0);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeByte(6);
        _loc1_.writeUnsignedInt(0);
        _loc1_.position = 0;
        var _loc2_:ItemUseResultInfo = new ItemUseResultInfo(_loc1_);
        var _loc3_:uint = _loc2_.userId;
        var _loc4_:uint = _loc2_.fighterId;
        var _loc5_:Fighter;
        if ((_loc5_ = this._scene.arenaData.getFighter(_loc3_, _loc4_)) != null) {
            _loc6_ = {
                "fighter": _loc5_,
                "side": _loc5_.fighterSide,
                "itemUseResultInfo": _loc2_
            };
            ArenaAnimationManager.createAnimation(ArenaAnimationType.ITEMUSE, _loc6_, this.endAnimation);
            this.showSkillPanel();
            this.updateStatusPanel();
        }
    }

    private function endAnimation():void {
        this.startSelectOperate();
        this._controlPanel.active();
    }

    private function onCatchSuccess():void {
        this._scene.fightController.rightMainFighter.deactive();
        DisplayObjectUtil.removeFromParent(this._scene.fightController.rightMainFighter);
    }

    private function sendOperateMessage(param1:uint, param2:uint, param3:uint = 0, param4:Function = null):void {
        if (param1 == OperateEvent.OPERATE_SKILL) {
            this.updateAnger();
            this.parserLeftTeamData();
            this.parserRightTeamData();
            this._scene.fightController.checkRightFighterChanged();
            this.updateAnger2(50233, 1, 20);
            this.updateAnger2(0, 2, 20);
            this.updateAngerBar();
            if (this.checkNumSkill(param2)) {
                this.parserDamage();
                this.parserDamage_1();
            } else if (SceneManager.currentSceneType == SceneType.GUDIE_ARENA3) {
                this.parserDamage3();
            } else if (SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA1) {
                this.parserDamage3();
            } else if (SceneManager.currentSceneType == SceneType.GUDIE_ARENA4) {
                this.parserSpecialDamage4();
            } else if (SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA2) {
                this.parserSpecialDamage5();
            } else if (SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA3) {
                if (param2 != 10046) {
                    this.parserDamage1();
                    this.parserDamage_2();
                } else {
                    this.parserSpecialDamage6();
                }
            } else if (param2 == 13119) {
                this.parserSpecialDamage();
            }
            this.parseTurnResult();
        } else if (param1 == OperateEvent.OPERATE_ESCAPE) {
            this.updateEscape();
        } else if (param1 != OperateEvent.OPERATE_FIGHTER) {
            if (param1 == OperateEvent.OPERATE_ITEM_CATCH_PET) {
                this.useCapule();
            } else if (param1 == OperateEvent.OPERATE_ITEM_USE_MEDICINE) {
                this.useItem();
            }
        }
        if (param1 != OperateEvent.OPERATE_ESCAPE && param4 != null) {
            param4();
        }
    }

    private function useCapule():void {
        this._scene.fightController.changeFighterState(FightState.CATCH_FIGHTER_SUCCESS);
        ArenaAnimationManager.createAnimation(ArenaAnimationType.CATCHPETSUCCESS, {
            "target": 1,
            "onCatchSuccessFun": this.onCatchSuccess
        }, this.onCatchAnimationEnd);
    }

    private function onCatchAnimationEnd():void {
        AlertManager.showAutoCloseAlert("捕捉成功", 3, this.checkGudieTask);
    }

    private function checkGudieTask():void {
        this._scene.fightController.exitFight();
    }

    private function checkNumSkill(param1:uint):Boolean {
        if (param1 == 13110 || param1 == 13113 || param1 == 13115 || param1 == 13123) {
            return true;
        }
        return false;
    }

    public function showFighterPanel():void {
        this._controlPanel.showFighterPanel();
    }

    public function showSkillPanel():void {
        this._controlPanel.showSkillPanel();
    }

    public function updateControlledFighter(param1:Fighter):void {
        this._controlPanel.updateControlledFighter(param1);
    }

    public function updateOppositeFighter():void {
        this._controlPanel.updateOppositeFighter();
    }

    public function itemPanelUpdate():void {
        this._controlPanel.itemPanelUpdate();
    }

    public function updateStatusPanelInfo():void {
        this._statusPanel.updateFighters();
        this.updateStatusPanel();
        this.updatePetPress();
    }

    public function updatePetPress():void {
        this._statusPanel.updatePetPress();
    }

    public function updateStatusPanel():void {
        this._statusPanel.update();
    }

    public function updateAngerBar():void {
        this._statusPanel.updateAngerBar();
    }

    public function showSkillBubble(param1:Fighter, param2:String):void {
        this._statusPanel.showSkillBubble(param1, param2);
    }

    private function getLeftTeam():FighterTeam {
        return this._scene.leftTeam;
    }

    private function getRightTeam():FighterTeam {
        return this._scene.rightTeam;
    }
}
}
