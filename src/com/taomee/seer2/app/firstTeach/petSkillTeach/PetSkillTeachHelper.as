package com.taomee.seer2.app.firstTeach.petSkillTeach {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.firstTeach.FirstTeachManager;
import com.taomee.seer2.app.firstTeach.FirstTeachType;
import com.taomee.seer2.app.home.panel.HomePanel;
import com.taomee.seer2.app.home.panel.bar.HomeSideBar;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1017;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.manager.EventManager;

public class PetSkillTeachHelper {

    public static const PET_BAG:uint = 0;

    public static const PET_STORAGE:uint = 1;


    private var _initPetInfoVec:Vector.<PetInfo>;

    private var _statusVec:Vector.<int>;

    private var _petResourceId:uint;

    private var _petId:uint;

    private var _type:int;

    private var _skillTeachIndex:int;

    private var _petInfo:PetInfo;

    private var _storagePop:MovieClip;

    public function PetSkillTeachHelper() {
        super();
        this._initPetInfoVec = PetInfoManager.getInitialPetInfoVec();
    }

    public function initEventListener():void {
        EventManager.addEventListener(FirstTeachManager.PETSKILLTEACH_COMPLETE_EVENT, this.onPetSkillTeachComplete);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.onMapStart);
        PetInfoManager.addEventListener(PetInfoEvent.PET_START_TRAINING, this.onPetInfoChange);
        PetInfoManager.addEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE, this.onPetInfoChange);
        PetInfoManager.addEventListener(PetInfoEvent.PET_CURE, this.onPetInfoChange);
        PetInfoManager.addEventListener(PetInfoEvent.PET_PUT_TO_BAG, this.onPetInfoChange);
        PetInfoManager.addEventListener(PetInfoEvent.PET_PUT_TO_STORAGE, this.onPetInfoChange);
        PetInfoManager.addEventListener(PetInfoEvent.PET_REMOVE, this.onPetInfoChange);
        if (QuestManager.isFreshQuestComplete() == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        }
    }

    private function onQuestComplete(param1:QuestEvent):void {
        if (QuestManager.isFreshQuestComplete()) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            this.clearPop();
            this.onMapComplete(null);
        }
    }

    private function onPetInfoChange(param1:PetInfoEvent):void {
        var _loc2_:PetInfo = param1.info;
        if (_loc2_.resourceId <= 9) {
            PetInfoManager.setInitialPetInfo(_loc2_);
            this._initPetInfoVec = PetInfoManager.getInitialPetInfoVec();
            this.resetPopStatus();
        }
    }

    private function onPetSkillTeachComplete(param1:Event):void {
        this.resetPopStatus();
    }

    private function resetPopStatus():void {
        this.clearPop();
        this.onMapComplete(null);
    }

    private function onMapStart(param1:SceneEvent):void {
        this.clearPop();
    }

    private function onMapComplete(param1:SceneEvent):void {
        if (QuestManager.isFreshQuestComplete() == false || SceneManager.active == null) {
            return;
        }
        if (SceneManager.active.type == SceneType.HOME && ActorManager.actorInfo.id == SceneManager.active.mapID) {
            this.processStoragePetSkillTeach();
        } else if (SceneManager.active.type == SceneType.LOBBY) {
            this.processBagPetSkillTeach();
        }
    }

    private function processBagPetSkillTeach():void {
        if (this.hasBagPetNeedSkillTeach()) {
        }
    }

    private function processStoragePetSkillTeach():void {
        var _loc1_:PetInfo = null;
        for each(_loc1_ in this._initPetInfoVec) {
            this._petResourceId = _loc1_.resourceId;
            this._type = this.getPetSkillTeachType();
            this._petId = _loc1_.catchTime;
            if (_loc1_.isInStorage && this.isShowSkillTeache(_loc1_.level)) {
                this.processHomePetSkillTeach();
                return;
            }
        }
        this._petResourceId = 0;
        this._type = -1;
    }

    private function getStoragePetInfo():void {
        Connection.addCommandListener(CommandSet.PET_SIMPLE_INFO_1017, this.onGetPetSimpleInfo);
        Connection.send(CommandSet.PET_SIMPLE_INFO_1017, this._petId);
    }

    private function onGetPetSimpleInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.PET_SIMPLE_INFO_1017, this.onGetPetSimpleInfo);
        this._petInfo = new Parser_1017(param1.message.getRawData()).petInfo;
        var _loc2_:SimpleButton = HomePanel.getSidBar().getBtnByName(HomeSideBar.PET_STORAGE_BTN);
        if (Boolean(HomePanel.getSidBar()) && Boolean(_loc2_)) {
            HomePanel.getSidBar().addChild(this._storagePop);
            this._storagePop.x = _loc2_.x - 15;
            this._storagePop.y = _loc2_.y - 12.5;
            this._storagePop.mouseEnabled = true;
            this._storagePop.buttonMode = true;
            this._storagePop.addEventListener(MouseEvent.CLICK, this.onPopClick);
        }
    }

    private function onPopClick(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        var _loc2_:Object = new Object();
        _loc2_.index = this._statusVec[this._type] + 1;
        _loc2_.petInfo = this._petInfo;
        _loc2_.moduleFlag = PET_STORAGE;
        FirstTeachManager.setPetSkillTeachData(_loc2_);
        FirstTeachManager.firstTeach(this._type);
    }

    private function getPetSkillTeachType():int {
        switch (this._petResourceId) {
            case 1:
            case 2:
            case 3:
                return FirstTeachType.SKILLTEACH_DIDILAN;
            case 4:
            case 5:
            case 6:
                return FirstTeachType.SKILLTEACH_XIUXIU;
            case 7:
            case 8:
            case 9:
                return FirstTeachType.SKILLTEACH_LA_AO;
            default:
                return -1;
        }
    }

    public function setStatus(param1:Vector.<int>):void {
        this._statusVec = param1;
    }

    private function isShowSkillTeache(param1:uint):Boolean {
        this._skillTeachIndex = this.getPetSkillTeachIndex(param1);
        if (this._statusVec[this._type] < this._skillTeachIndex) {
            return true;
        }
        return false;
    }

    private function getPetSkillTeachIndex(param1:uint):int {
        switch (this._type) {
            case FirstTeachType.SKILLTEACH_DIDILAN:
                return this.diDiLanSkillTeachIndex(param1);
            case FirstTeachType.SKILLTEACH_LA_AO:
                return this.laAoSkillTeachIndex(param1);
            case FirstTeachType.SKILLTEACH_XIUXIU:
                return this.xiuXiuSkillTeachIndex(param1);
            default:
                return 0;
        }
    }

    private function laAoSkillTeachIndex(param1:uint):int {
        if (param1 < 20) {
            return 0;
        }
        if (param1 >= 20 && param1 < 45) {
            return 1;
        }
        if (param1 >= 45 && param1 < 60) {
            return 2;
        }
        return 3;
    }

    private function diDiLanSkillTeachIndex(param1:uint):int {
        if (param1 < 20) {
            return 0;
        }
        if (param1 >= 20 && param1 < 30) {
            return 1;
        }
        if (param1 >= 30 && param1 < 60) {
            return 2;
        }
        return 3;
    }

    private function xiuXiuSkillTeachIndex(param1:uint):int {
        if (param1 < 20) {
            return 0;
        }
        if (param1 >= 20 && param1 < 30) {
            return 1;
        }
        if (param1 >= 30 && param1 < 35) {
            return 2;
        }
        if (param1 >= 35 && param1 < 60) {
            return 3;
        }
        return 4;
    }

    private function processHomePetSkillTeach():void {
        this._storagePop = UIManager.getMovieClip("UI_PetSkillTeach_StoragePop");
        this.getStoragePetInfo();
    }

    private function hasBagPetNeedSkillTeach():Boolean {
        var _loc1_:PetInfo = null;
        for each(_loc1_ in this._initPetInfoVec) {
            this._petResourceId = _loc1_.resourceId;
            this._type = this.getPetSkillTeachType();
            this._petId = _loc1_.catchTime;
            this._petInfo = PetInfoManager.getPetInfoFromBag(this._petId);
            if (Boolean(this._petInfo) && this.isShowSkillTeache(_loc1_.level)) {
                return true;
            }
        }
        this._petResourceId = 0;
        this._type = -1;
        return false;
    }

    private function clearPop():void {
        if (this._storagePop) {
            this._storagePop.removeEventListener(MouseEvent.CLICK, this.onPopClick);
            DisplayObjectUtil.removeFromParent(this._storagePop);
            this._storagePop = null;
        }
    }

    public function getInitPetPotentialStatus(param1:uint):Boolean {
        switch (param1) {
            case 1:
                return this._statusVec[FirstTeachType.SKILLTEACH_DIDILAN] == 3;
            case 2:
                return this._statusVec[FirstTeachType.SKILLTEACH_XIUXIU] == 4;
            case 3:
                return this._statusVec[FirstTeachType.SKILLTEACH_LA_AO] == 3;
            default:
                return false;
        }
    }

    public function closePop():void {
        this.clearPop();
    }

    public function dispose():void {
        this.clearPop();
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.onMapStart);
        this._initPetInfoVec = null;
    }
}
}
