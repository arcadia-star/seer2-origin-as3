package com.taomee.seer2.app.arena.newUI.toolbar.sub {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.ui.toolbar.sub.ISkillButton;
import com.taomee.seer2.app.component.PetTypeIcon;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import org.taomee.utils.DisplayUtil;

public class NewSkillButton extends Sprite implements ISkillButton {


    private var _id:int;

    private var _btn:MovieClip;

    protected var _scaleMC:MovieClip;

    protected var _brief:MovieClip;

    protected var _typeIcon:PetTypeIcon;

    private var _nameTxt:TextField;

    private var _angerValueTxt:TextField;

    private var _powerTxt:TextField;

    private var _powerValueTxt:TextField;

    private var _categoryTxt:TextField;

    protected var _tipMC:MovieClip;

    private var _info:SkillInfo;

    private var _enabled:Boolean;

    private var _skillAngle:MovieClip;

    public function NewSkillButton() {
        super();
        this.createChildren();
        this.enabled = true;
    }

    private function createChildren():void {
        this._btn = this.createMc();
        this._btn.buttonMode = true;
        addChild(this._btn);
        this._tipMC = this._btn["tipMC"];
        this._brief = this.createSuperBrief();
        this._brief.mouseChildren = false;
        this._brief.mouseEnabled = false;
        var _loc1_:TextField = this._brief["txtAnger"];
        _loc1_.text = "怒气";
        this._nameTxt = this._brief["txtSkillName"];
        this._angerValueTxt = this._brief["txtAngerValue"];
        this._angerValueTxt.text = "0";
        this._powerTxt = this._brief["txtPower"];
        this._powerTxt.text = "威力";
        this._powerValueTxt = this._brief["txtPowerValue"];
        this._powerValueTxt.text = "0";
        this._categoryTxt = this._brief["txtSkillCategory"];
        this._brief.x = 16;
        this._brief.y = 27;
        addChild(this._brief);
        this._typeIcon = new PetTypeIcon();
        DisplayObjectUtil.disableSprite(this._typeIcon);
        this._typeIcon.x = 12;
        this._typeIcon.y = 29;
        addChild(this._typeIcon);
        this.updatePoint();
        this.updateSkillAngle();
    }

    protected function createMc():MovieClip {
        return FightUIManager.getMovieClip("New_UI_FightSkillBtn");
    }

    protected function createSuperBrief():MovieClip {
        return FightUIManager.getMovieClip("New_UI_FightSkillBrief");
    }

    protected function updatePoint():void {
    }

    private function updateSkillAngle():void {
        this._skillAngle = FightUIManager.getMovieClip("New_UI_Angle_Skill_Simple");
    }

    public function setSkillInfo(param1:SkillInfo):void {
        this._info = param1;
        this._nameTxt.text = this._info.name;
        this._angerValueTxt.text = this._info.anger.toString();
        this._powerValueTxt.text = this._info.power.toString();
        this._categoryTxt.text = this._info.category;
        this._typeIcon.type = this._info.typeId;
    }

    public function getSkillInfo():SkillInfo {
        return this._info;
    }

    public function set id(param1:int):void {
        this._id = param1;
    }

    public function get id():int {
        return this._id;
    }

    public function set enabled(param1:Boolean):void {
        this._enabled = param1;
        if (this._enabled == true) {
            DisplayObjectUtil.recoverDisplayObject(this);
            if (Boolean(this._skillAngle) && Boolean(this._skillAngle.parent)) {
                this._skillAngle.play();
            }
        } else {
            DisplayObjectUtil.darkenDisplayObject(this);
            if (Boolean(this._skillAngle) && Boolean(this._skillAngle.parent)) {
                this._skillAngle.stop();
            }
        }
    }

    public function updateScale(param1:uint, param2:uint):void {
        this.playSkillAngle(param1, param2);
        if (param1 >= param2) {
            this._tipMC.visible = false;
        } else {
            this._tipMC.visible = true;
        }
    }

    protected function playSkillAngle(param1:uint, param2:uint):void {
        DisplayUtil.removeForParent(this._skillAngle);
        if (param1 >= param2) {
            this._skillAngle.x = 11;
            this._skillAngle.y = 26;
            addChild(this._skillAngle);
            this._skillAngle.play();
        }
    }

    public function get enabled():Boolean {
        return this._enabled;
    }

    public function dispose():void {
        this._info = null;
    }
}
}
