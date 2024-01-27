package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.manager.SelectPetManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class MapProcessor_80053 extends MapProcessor {


    private const FIGHT_ID_LIST:Array = [581, 582, 583, 584];

    private const FIGHT_INDEX:int = 203161;

    private const NEED_PET_NUM:Array = [6, 3, 2, 1];

    private const NEED_FULL_NUM:Array = [1, 1, 2, 1];

    private const NEED_CHARA:Array = ["天真", "开朗", "调皮", "固执"];

    private var buyItemBtn:SimpleButton;

    private var boxBtn:SimpleButton;

    private var fightIndex:uint;

    private var arrIndex:int;

    private var selectedPetInfo:Vector.<PetInfo>;

    public function MapProcessor_80053(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        ActiveCountManager.requestActiveCount(this.FIGHT_INDEX, this.getFightIndex);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.toFight);
        var _loc1_:MapModel = SceneManager.active.mapModel;
        this.buyItemBtn = _loc1_.front["buyItemBtn"];
        this.boxBtn = _loc1_.front["boxBtn"];
        this.initEvent();
    }

    override public function dispose():void {
        super.dispose();
        this.buyItemBtn.removeEventListener(MouseEvent.CLICK, this.buyItem);
        this.boxBtn.removeEventListener(MouseEvent.CLICK, this.showBoxPanel);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.toFight);
    }

    private function initEvent():void {
        this.buyItemBtn.addEventListener(MouseEvent.CLICK, this.buyItem);
        this.boxBtn.addEventListener(MouseEvent.CLICK, this.showBoxPanel);
    }

    private function showBoxPanel(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
    }

    private function buyItem(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("KingSoulWithIceItemPanel"));
    }

    private function getFightIndex(param1:uint, param2:uint):void {
        this.arrIndex = param2;
        this.fightIndex = this.FIGHT_ID_LIST[this.arrIndex];
    }

    private function toFight(param1:DialogPanelEvent):void {
        var _loc2_:int = 0;
        if ((param1.content as DialogPanelEventData).params == "toFight") {
            if (this.fightIndex == this.FIGHT_ID_LIST[0]) {
                this.selectedPetInfo = PetInfoManager.getAllBagPetInfo();
                if (this.checkCondition()) {
                    FightManager.addEventListener(FightStartEvent.FIGHT_OVER, this.changeMap);
                    FightManager.startFightWithBoss(this.fightIndex);
                }
            } else {
                _loc2_ = int(this.NEED_PET_NUM[this.arrIndex]);
                SelectPetManager.selectFixedPet(_loc2_, this.checkPet);
            }
        }
        param1.stopImmediatePropagation();
    }

    protected function changeMap(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.changeMap);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.switchComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function switchComplete(param1:SceneEvent):void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.switchComplete);
        ModuleManager.toggleModule(URLUtil.getAppModule("KingSoulWithIcePanel"));
    }

    private function checkCondition():Boolean {
        var _loc4_:int = 0;
        var _loc5_:PetInfo = null;
        var _loc1_:int = int(this.selectedPetInfo.length);
        if (_loc1_ < this.NEED_PET_NUM[this.arrIndex]) {
            AlertManager.showAlert("请准备好" + this.NEED_PET_NUM[this.arrIndex] + "只精灵再出战吧！");
            return false;
        }
        var _loc2_:uint = 0;
        var _loc3_:Boolean = false;
        _loc4_ = 0;
        while (_loc4_ < _loc1_) {
            if (this.selectedPetInfo[_loc4_].level == 100) {
                _loc2_++;
                if (this.selectedPetInfo[_loc4_].characterName == this.NEED_CHARA[this.arrIndex]) {
                    _loc3_ = true;
                }
            }
            _loc4_++;
        }
        if (_loc2_ < this.NEED_FULL_NUM[this.arrIndex]) {
            AlertManager.showAlert("出战精灵必须有" + this.NEED_FULL_NUM[this.arrIndex] + "只满级精灵才可以出战哦！");
            return false;
        }
        if (!_loc3_) {
            AlertManager.showAlert("出战精灵必须有性格为" + this.NEED_CHARA[this.arrIndex] + "的满级精灵才可以出战哦！");
            return false;
        }
        if (this.arrIndex == 3) {
            if ((_loc5_ = this.selectedPetInfo[0]).learningInfo.pointTotal() != 510) {
                AlertManager.showAlert("出战精灵必须为满学习力才可以挑战它哦!");
                return false;
            }
            if (_loc5_.totalPotential != 720) {
                AlertManager.showAlert("出战精灵必须为720才可以挑战它哦!");
                return false;
            }
        }
        return true;
    }

    private function checkPet(param1:Vector.<uint>):void {
        var _loc4_:LittleEndianByteArray = null;
        var _loc5_:int = 0;
        this.selectedPetInfo = new Vector.<PetInfo>();
        var _loc2_:int = int(param1.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this.getPetInfo(param1[_loc3_]);
            _loc3_++;
        }
        if (this.checkCondition()) {
            Connection.addCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, this.selectedComplete);
            Connection.addErrorHandler(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, this.errorSlected);
            (_loc4_ = new LittleEndianByteArray()).writeUnsignedInt(17);
            _loc4_.writeUnsignedInt(this.selectedPetInfo.length);
            _loc5_ = 0;
            while (_loc5_ < this.selectedPetInfo.length) {
                _loc4_.writeUnsignedInt(this.selectedPetInfo[_loc5_].catchTime);
                _loc5_++;
            }
            Connection.send(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, _loc4_);
        }
    }

    private function errorSlected(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, this.selectedComplete);
        Connection.removeCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, this.errorSlected);
        AlertManager.showAlert("选择的精灵不符合要求");
    }

    private function selectedComplete(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, this.selectedComplete);
        Connection.removeCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, this.errorSlected);
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, this.changeMap);
        FightManager.startFightWithBoss(this.fightIndex);
    }

    private function getPetInfo(param1:uint):void {
        var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        var _loc3_:int = int(_loc2_.length);
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if (_loc2_[_loc4_].catchTime == param1) {
                this.selectedPetInfo.push(_loc2_[_loc4_]);
                break;
            }
            _loc4_++;
        }
    }
}
}
