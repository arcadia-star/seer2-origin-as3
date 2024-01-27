package com.taomee.seer2.app.firstTeach.petSkillTeach {
import com.taomee.seer2.app.firstTeach.FirstTeachManager;
import com.taomee.seer2.app.firstTeach.FirstTeachType;
import com.taomee.seer2.app.firstTeach.IFirstTeach;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.module.ModuleProxy;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.ui.UINumberGenerator;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import org.taomee.manager.EventManager;

public class PetSkillTeach implements IFirstTeach {

    private static const LAST_TEACH_INDEX:Array = [3, 3, 4];

    private static const POP_ANIMATION_PREFIX:String = "popAnimation_";

    private static const TEACH_ANIMATION_PREFIX:String = "teachAnimation_";

    private static const END_ANIMATION_PREFIX:String = "endAnimation";


    private var _data:Object;

    private var _petInfo:PetInfo;

    private var _teachType:uint;

    private var _angerSign:Sprite;

    private var _hpSign:Sprite;

    public function PetSkillTeach(param1:Object, param2:uint) {
        super();
        this._data = param1;
        this._petInfo = this._data["petInfo"];
        this._teachType = param2;
    }

    public function mapChange():void {
    }

    public function teach():void {
        this.showPopAnimation();
    }

    protected function showPopAnimation():void {
        var _loc1_:String = this._teachType + "/" + POP_ANIMATION_PREFIX + this._data.index;
        MovieClipUtil.playFullScreen(URLUtil.getFirstTeachAnimation(_loc1_), this.showTeachAnimation);
    }

    protected function showTeachAnimation():void {
        var _loc1_:String = this._teachType + "/" + TEACH_ANIMATION_PREFIX + this._data.index;
        this.playTeachAnimation(URLUtil.getFirstTeachAnimation(_loc1_));
    }

    protected function playTeachAnimation(param1:String):void {
        UILoader.load(param1, LoadType.SWF, this.onFullScreenLoadComplete);
    }

    private function onFullScreenLoadComplete(param1:ContentInfo):void {
        var mc:MovieClip = null;
        var soundUrl:String = null;
        var info:ContentInfo = param1;
        mc = info.content as MovieClip;
        SoundManager.enabled = false;
        soundUrl = String(URLUtil.getMapSoundUrl("BGM_1002"));
        SoundManager.play(soundUrl, 0.4, true);
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        LayerManager.hideMap();
        this.setTeachPetStatus(mc);
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            doSpecialOnFrame(mc.currentFrameLabel, mc);
            if (mc.currentFrame == mc.totalFrames) {
                mc.stop();
                SoundManager.stop(soundUrl);
                SoundManager.enabled = true;
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                DisplayObjectUtil.removeFromParent(mc);
                LayerManager.resetOperation();
                LayerManager.showMap();
                completeTeach();
            }
        });
    }

    protected function doSpecialOnFrame(param1:String, param2:MovieClip):void {
        var _loc3_:MovieClip = null;
        var _loc4_:MovieClip = null;
        if (param1 == "hideAngerBar") {
            _loc3_ = param2["petinfo"];
            (_loc4_ = _loc3_["angerBarContainer"]).visible = false;
            this._angerSign.visible = false;
        }
    }

    private function setTeachPetStatus(param1:MovieClip):void {
        var _loc2_:MovieClip = param1["petinfo"];
        var _loc3_:Sprite = new Sprite();
        _loc2_.addChild(_loc3_);
        _loc3_.x = (_loc2_["lvSprite"] as MovieClip).x;
        _loc3_.y = (_loc2_["lvSprite"] as MovieClip).y;
        DisplayObjectUtil.removeFromParent(_loc2_["lvSprite"] as MovieClip);
        _loc3_.addChild(UINumberGenerator.generateFighterLevelNumber(this._petInfo.level));
        this._hpSign = new Sprite();
        _loc2_.addChild(this._hpSign);
        this._hpSign.x = (_loc2_["hpSign"] as MovieClip).x;
        this._hpSign.y = (_loc2_["hpSign"] as MovieClip).y;
        DisplayObjectUtil.removeFromParent(_loc2_["hpSign"] as MovieClip);
        this._hpSign.addChild(UINumberGenerator.generateHpNumber(this._petInfo.hp, this._petInfo.maxHp));
        this._angerSign = new Sprite();
        _loc2_.addChild(this._angerSign);
        this._angerSign.x = (_loc2_["angerSign"] as MovieClip).x;
        this._angerSign.y = (_loc2_["angerSign"] as MovieClip).y;
        DisplayObjectUtil.removeFromParent(_loc2_["angerSign"] as MovieClip);
        this._angerSign.addChild(UINumberGenerator.generateAngerNumber(20, 100));
        var _loc5_:MovieClip;
        var _loc4_:MovieClip;
        (_loc5_ = (_loc4_ = _loc2_["hpBarContainer"])["hpBar"]).scaleX = this._petInfo.hp / this._petInfo.maxHp;
        var _loc7_:MovieClip;
        var _loc6_:MovieClip;
        (_loc7_ = (_loc6_ = _loc2_["angerBarContainer"])["angerBar"]).scaleX = 20 / 100;
    }

    private function completeTeach():void {
        if (this._data.index == LAST_TEACH_INDEX[this._teachType - FirstTeachType.SKILLTEACH_LA_AO]) {
            this.processLastTeach();
            return;
        }
        this.updateStatus();
    }

    private function updateStatus():void {
        FirstTeachManager.updataStatus(this._teachType, this._data.index);
        EventManager.dispatchEvent(new Event(FirstTeachManager.PETSKILLTEACH_COMPLETE_EVENT));
        this.showBagStorageModule();
    }

    private function processLastTeach():void {
        var _loc1_:String = this._teachType + "/" + END_ANIMATION_PREFIX;
        MovieClipUtil.playFullScreen(URLUtil.getFirstTeachAnimation(_loc1_), this.showInitPetDetailPanel);
    }

    private function showInitPetDetailPanel():void {
        PetInfoManager.getPetInfo(this._petInfo.catchTime, this.onGetInitPetInfo, this.onGetInitPetInfoError);
    }

    private function onGetInitPetInfo(param1:PetInfo):void {
        this.changeBagInitPetInfo(param1);
        FirstTeachManager.closePetSkillTeachPop();
        ModuleManager.toggleModule(URLUtil.getAppModule("InitPetDetailPanel"), "正在打开初始精灵信息面板...", {
            "petInfo": param1,
            "callBack": this.updateStatus
        });
    }

    private function onGetInitPetInfoError():void {
        this.showBagStorageModule();
    }

    private function showBagStorageModule():void {
        var _loc1_:String = null;
        if (this._data.moduleFlag == PetSkillTeachHelper.PET_BAG) {
            _loc1_ = "PetBagPanel";
        } else if (this._data.moduleFlag == PetSkillTeachHelper.PET_STORAGE) {
            _loc1_ = "PetStoragePanel";
        }
        if (_loc1_ == null || ModuleManager.getModuleStatus(_loc1_) == ModuleProxy.SHOW) {
            return;
        }
        ModuleManager.toggleModule(URLUtil.getAppModule(_loc1_), "正在打开...");
    }

    private function changeBagInitPetInfo(param1:PetInfo):void {
        var _loc2_:PetInfo = PetInfoManager.getPetInfoFromBag(param1.catchTime);
        if (_loc2_) {
            _loc2_.sex = param1.sex;
            _loc2_.hp = param1.hp;
            _loc2_.maxHp = param1.maxHp;
            _loc2_.atk = param1.atk;
            _loc2_.specialAtk = param1.specialAtk;
            _loc2_.defence = param1.defence;
            _loc2_.specialDefence = param1.specialDefence;
            _loc2_.speed = param1.speed;
            _loc2_.character = param1.character;
            _loc2_.potential = param1.potential;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE, _loc2_);
        }
    }

    public function dispose():void {
        this._hpSign = null;
        this._angerSign = null;
    }
}
}
