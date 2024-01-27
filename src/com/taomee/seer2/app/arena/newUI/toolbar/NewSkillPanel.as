package com.taomee.seer2.app.arena.newUI.toolbar {
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.events.OperateEvent;
import com.taomee.seer2.app.arena.newUI.toolbar.sub.NewSkillButton;
import com.taomee.seer2.app.arena.newUI.toolbar.sub.NewSuperSkillButton;
import com.taomee.seer2.app.arena.processor.Processor_19;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.ui.toolbar.sub.ISkillButton;
import com.taomee.seer2.app.arena.ui.toolbar.sub.SkillTip;
import com.taomee.seer2.app.arena.util.SkillCategoryName;
import com.taomee.seer2.app.firstTeach.guide.controller.GudieFightTipContent;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

internal class NewSkillPanel extends Sprite {

    private static const SKILL_BTN_NUM:int = 4;


    private var _controlledFighter:Fighter;

    private var _usedSkillInfo:SkillInfo;

    private var _tip:SkillTip;

    private var _skillBtnLightRingVec:Vector.<MovieClip>;

    private var _skillBtnVec:Vector.<NewSkillButton>;

    private var _skillBtnLightRingEnabled:Boolean = false;

    private var _superSkillBtn:NewSuperSkillButton;

    private var _superSkillBtnLightRing:MovieClip;

    private var _fightSkillTitleMC:MovieClip;

    public function NewSkillPanel() {
        var offsetX:int;
        var offsetY:int;
        var btnWidth:int;
        var i:int = 0;
        var onSkillBtnOver:Function = null;
        var onSkillBtnOut:Function = null;
        var skillBtn:NewSkillButton = null;
        super();
        onSkillBtnOver = function (param1:MouseEvent):void {
            var _loc2_:NewSkillButton = null;
            if (SceneManager.currentSceneType != SceneType.GUDIE_ARENA2 && SceneManager.currentSceneType != SceneType.GUDIE_ARENA3 && SceneManager.currentSceneType != SceneType.GUDIE_ARENA4 && SceneManager.currentSceneType != SceneType.GUDIE_ARENA5 && SceneManager.currentSceneType != SceneType.GUIDE_NEW_ARENA1 && SceneManager.currentSceneType != SceneType.GUIDE_NEW_ARENA2 && SceneManager.currentSceneType != SceneType.GUIDE_NEW_ARENA3) {
                _loc2_ = param1.currentTarget as NewSkillButton;
                _tip.setSkillInfo(_loc2_.getSkillInfo());
                _tip.x = _loc2_.x + 20;
                _tip.y = _loc2_.y + 10;
                addChild(_tip);
                param1.stopImmediatePropagation();
            }
        };
        onSkillBtnOut = function (param1:MouseEvent):void {
            if (SceneManager.currentSceneType != SceneType.GUDIE_ARENA2 && SceneManager.currentSceneType != SceneType.GUDIE_ARENA3 && SceneManager.currentSceneType != SceneType.GUDIE_ARENA4 && SceneManager.currentSceneType != SceneType.GUDIE_ARENA5 && SceneManager.currentSceneType != SceneType.GUIDE_NEW_ARENA1 && SceneManager.currentSceneType != SceneType.GUIDE_NEW_ARENA2 && SceneManager.currentSceneType != SceneType.GUIDE_NEW_ARENA3) {
                DisplayObjectUtil.removeFromParent(_tip);
                param1.stopImmediatePropagation();
            }
        };
        this.mouseEnabled = false;
        this._superSkillBtn = new NewSuperSkillButton();
        this._superSkillBtn.x = 590;
        this._superSkillBtn.y = -60;
        this._superSkillBtn.buttonMode = true;
        this._superSkillBtn.useHandCursor = true;
        this._superSkillBtn.enabled = false;
        this._superSkillBtn.addEventListener(MouseEvent.CLICK, this.onSkillBtnClick);
        offsetX = 30;
        offsetY = -60;
        btnWidth = 140;
        this._skillBtnVec = new Vector.<NewSkillButton>();
        i = 0;
        while (i < SKILL_BTN_NUM) {
            skillBtn = new NewSkillButton();
            skillBtn.x = offsetX + i * btnWidth;
            skillBtn.y = offsetY;
            skillBtn.id = i;
            skillBtn.addEventListener(MouseEvent.CLICK, this.onSkillBtnClick);
            skillBtn.addEventListener(MouseEvent.MOUSE_OVER, onSkillBtnOver);
            skillBtn.addEventListener(MouseEvent.MOUSE_OUT, onSkillBtnOut);
            this._skillBtnVec.push(skillBtn);
            i++;
        }
        this._fightSkillTitleMC = FightUIManager.getMovieClip("New_UI_FightSkillTitleMC");
        this._fightSkillTitleMC.x = 12;
        this._fightSkillTitleMC.y = -22;
        addChild(this._fightSkillTitleMC);
        this._tip = new SkillTip();
        if (SceneManager.currentSceneType == SceneType.GUDIE_ARENA) {
            this.addGudie();
        } else if (SceneManager.currentSceneType == SceneType.GUDIE_ARENA2) {
            this.addGudieNew();
        } else if (SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA3) {
            this.addGudieNew1();
        } else if (SceneManager.currentSceneType == SceneType.GUDIE_ARENA3) {
            this.addGudieNew3();
        } else if (SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA1) {
            this.addGudieNew5();
        } else if (SceneManager.currentSceneType == SceneType.GUDIE_ARENA4) {
            this.addGudieNew4();
        } else if (SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA2) {
            this.addNewGudieNew4();
        }
    }

    private function addGudieNew():void {
        GudieFightTipContent.pushTar(this._skillBtnVec[0], 0);
        GudieFightTipContent.pushTar(this._superSkillBtn, 1);
    }

    private function addGudieNew1():void {
        GudieFightTipContent.pushTar(this._skillBtnVec[0], 0);
        GudieFightTipContent.pushTar(this._superSkillBtn, 1);
    }

    private function addGudieNew5():void {
        GudieFightTipContent.pushTar(this._skillBtnVec[0], 5);
    }

    private function addGudie():void {
        GudieFightTipContent.pushTar(this._skillBtnVec[0], 0);
        GudieFightTipContent.pushTar(this._superSkillBtn, 3);
    }

    private function addGudieNew3():void {
        GudieFightTipContent.pushTar(this._skillBtnVec[0], 5);
    }

    private function addGudieNew4():void {
    }

    private function addNewGudieNew4():void {
    }

    public function active():void {
        var _loc1_:NewSkillButton = null;
        this.mouseEnabled = true;
        this._superSkillBtn.mouseEnabled = true;
        this._superSkillBtn.mouseChildren = true;
        for each(_loc1_ in this._skillBtnVec) {
            _loc1_.enabled = true;
        }
    }

    public function deactive():void {
        var _loc1_:NewSkillButton = null;
        this.mouseEnabled = false;
        this._superSkillBtn.mouseEnabled = false;
        this._superSkillBtn.mouseChildren = false;
        for each(_loc1_ in this._skillBtnVec) {
            _loc1_.enabled = false;
        }
    }

    public function setFighter(param1:Fighter):void {
        this._controlledFighter = param1;
        var _loc2_:Vector.<SkillInfo> = this._controlledFighter.fighterInfo.skillInfoVec;
        this.showNormalSkillBtn(_loc2_);
        this.showSuperSkillBtn(_loc2_);
        this.updateSkillBtn();
    }

    private function showNormalSkillBtn(param1:Vector.<SkillInfo>):void {
        var _loc6_:SkillInfo = null;
        var _loc7_:NewSkillButton = null;
        this.clearSkillBtnVec();
        var _loc2_:int = int(param1.length);
        var _loc3_:int = int(this._skillBtnVec.length);
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_) {
            if ((_loc6_ = param1[_loc5_]).id != 0) {
                if (_loc6_.category != SkillCategoryName.POW) {
                    if (_loc4_ > _loc3_ - 1) {
                        break;
                    }
                    (_loc7_ = this._skillBtnVec[_loc4_]).setSkillInfo(_loc6_);
                    addChild(_loc7_);
                    _loc4_++;
                }
            }
            _loc5_++;
        }
    }

    private function showSuperSkillBtn(param1:Vector.<SkillInfo>):void {
        var _loc4_:SkillInfo = null;
        this.resetSuperSkillBtn();
        var _loc2_:int = int(param1.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if ((_loc4_ = param1[_loc3_]).id != 0) {
                if (_loc4_.category == SkillCategoryName.POW) {
                    this._superSkillBtn.setSkillInfo(_loc4_);
                    addChild(this._superSkillBtn);
                    break;
                }
            }
            _loc3_++;
        }
    }

    public function updateSkillBtn():void {
        var _loc1_:NewSkillButton = null;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc7_:SkillInfo = null;
        var _loc8_:String = null;
        for each(_loc1_ in this._skillBtnVec) {
            if (!((_loc7_ = _loc1_.getSkillInfo()) == null || _loc7_.id == 0)) {
                if (_loc7_ != null) {
                    _loc1_.updateScale(this._controlledFighter.fighterInfo.fightAnger, _loc7_.anger);
                    if (this._controlledFighter.fighterInfo.checkSkillAnger(_loc7_)) {
                        _loc1_.enabled = true;
                    } else {
                        _loc1_.enabled = false;
                    }
                }
            }
        }
        if (this._superSkillBtn.getSkillInfo() != null) {
            this._superSkillBtn.updateScale(this._controlledFighter.fighterInfo.fightAnger, this._superSkillBtn.getSkillInfo().anger);
            if (this._controlledFighter.fighterInfo.checkSkillAnger(this._superSkillBtn.getSkillInfo())) {
                this._superSkillBtn.enabled = true;
            } else {
                this._superSkillBtn.enabled = false;
            }
        }
        var _loc2_:Boolean = this._controlledFighter.fighterInfo.hasSuperSkill();
        if (_loc2_) {
            _loc8_ = this._superSkillBtn.getSkillInfo() == null ? "必杀技" : this._superSkillBtn.getSkillInfo().description;
            TooltipManager.addCommonTip(this._superSkillBtn, _loc8_);
        } else {
            TooltipManager.addCommonTip(this._superSkillBtn, "60级领悟必杀技");
        }
        var _loc5_:int = 30;
        var _loc6_:int = -60;
        if (this._superSkillBtn.getSkillInfo() == null) {
            DisplayUtil.removeForParent(this._superSkillBtn);
            _loc3_ = 190;
            _loc4_ = 0;
            while (_loc4_ < 4) {
                this._skillBtnVec[_loc4_].x = _loc5_ + _loc4_ * _loc3_;
                _loc4_++;
            }
        } else {
            addChild(this._superSkillBtn);
            _loc3_ = 140;
            _loc4_ = 0;
            while (_loc4_ < 4) {
                this._skillBtnVec[_loc4_].x = _loc5_ + _loc4_ * _loc3_;
                _loc4_++;
            }
        }
    }

    public function set skillBtnLightRingEnabled(param1:Boolean):void {
        this._skillBtnLightRingEnabled = param1;
        if (this._skillBtnLightRingEnabled == true) {
            this.addSkillBtnLightRing();
        }
    }

    public function get skillBtnLightRingEnabled():Boolean {
        return this._skillBtnLightRingEnabled;
    }

    private function onSkillBtnClick(param1:MouseEvent):void {
        if (Processor_19.isChangeIng) {
            return;
        }
        var _loc2_:ISkillButton = param1.currentTarget as ISkillButton;
        if (_loc2_.enabled) {
            this._usedSkillInfo = _loc2_.getSkillInfo();
            dispatchEvent(new OperateEvent(OperateEvent.OPERATE_SKILL, this._usedSkillInfo.id, OperateEvent.OPERATE_END));
            if (this._skillBtnLightRingEnabled) {
                this.removeSkillBtnLightRing();
            }
        }
        SoundEffects.playFightSound("Sound_Skill", 0.35);
    }

    private function addSkillBtnLightRing():void {
        var _loc2_:uint = 0;
        var _loc3_:NewSkillButton = null;
        var _loc4_:MovieClip = null;
        this.removeSkillBtnLightRing();
        this._skillBtnLightRingVec = new Vector.<MovieClip>();
        var _loc1_:uint = this._skillBtnVec.length;
        if (_loc1_ > 0) {
            _loc2_ = _loc1_ - 1;
            while (_loc2_ > 0) {
                _loc3_ = this._skillBtnVec[_loc2_];
                if (_loc3_.enabled == true && Boolean(_loc3_.getSkillInfo())) {
                    (_loc4_ = FightUIManager.getMovieClip("UI_FightSkillBtnLightRing")).x = _loc3_.x;
                    _loc4_.y = _loc3_.y;
                    _loc4_.mouseEnabled = false;
                    _loc4_.mouseChildren = false;
                    addChild(_loc4_);
                    this._skillBtnLightRingVec.push(_loc4_);
                    break;
                }
                _loc2_--;
            }
        }
        if (this._superSkillBtn.enabled == true) {
            this._superSkillBtnLightRing = FightUIManager.getMovieClip("UI_FightSuperSkillBtnLightRing");
            this._superSkillBtnLightRing.x = this._superSkillBtn.x;
            this._superSkillBtnLightRing.y = this._superSkillBtn.y;
            addChild(this._superSkillBtnLightRing);
        }
    }

    private function removeSkillBtnLightRing():void {
        if (this._superSkillBtnLightRing) {
            DisplayObjectUtil.removeFromParent(this._superSkillBtnLightRing);
            this._superSkillBtnLightRing = null;
        }
        if (this._skillBtnLightRingVec == null) {
            return;
        }
        var _loc1_:uint = 0;
        while (_loc1_ < this._skillBtnLightRingVec.length) {
            DisplayObjectUtil.removeFromParent(this._skillBtnLightRingVec[_loc1_]);
            this._skillBtnLightRingVec[_loc1_] = null;
            _loc1_++;
        }
        this._skillBtnLightRingVec = null;
    }

    private function resetSuperSkillBtn():void {
        this._superSkillBtn.enabled = false;
        this._superSkillBtn.clearSkillInfo();
    }

    private function clearSkillBtnVec():void {
        var _loc1_:NewSkillButton = null;
        for each(_loc1_ in this._skillBtnVec) {
            DisplayObjectUtil.removeFromParent(_loc1_);
        }
        if (this._superSkillBtn) {
            TooltipManager.remove(this._superSkillBtn);
        }
    }

    public function dispose():void {
        var _loc1_:NewSkillButton = null;
        if (this._superSkillBtn) {
            TooltipManager.remove(this._superSkillBtn);
        }
        DisplayObjectUtil.removeAllChildren(this);
        this._controlledFighter = null;
        this._tip = null;
        this._usedSkillInfo = null;
        for each(_loc1_ in this._skillBtnVec) {
            _loc1_.dispose();
            DisplayObjectUtil.removeFromParent(_loc1_);
        }
        this._skillBtnVec = null;
        this._superSkillBtn.dispose();
        this._superSkillBtn = null;
        this.removeSkillBtnLightRing();
    }
}
}
