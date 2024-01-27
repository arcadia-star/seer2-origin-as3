package com.taomee.seer2.app.arena.ui.toolbar.sub {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.pet.data.SkillInfo;

import flash.display.MovieClip;
import flash.display.Sprite;

public class SuperSkillButton extends Sprite implements ISkillButton {


    private var _mc:MovieClip;

    private var _enabled:Boolean;

    private var _skillInfo:SkillInfo;

    public function SuperSkillButton() {
        super();
        this.createChildren();
    }

    private function createChildren():void {
        this._mc = FightUIManager.getMovieClip("UI_FightSuperSkill");
        addChild(this._mc);
    }

    public function set enabled(param1:Boolean):void {
        this._enabled = param1;
        if (this._enabled == true) {
            this._mc.gotoAndStop(2);
        } else {
            this._mc.gotoAndStop(1);
        }
    }

    public function get enabled():Boolean {
        return this._enabled;
    }

    public function setSkillInfo(param1:SkillInfo):void {
        this._skillInfo = param1;
    }

    public function getSkillInfo():SkillInfo {
        return this._skillInfo;
    }

    public function clearSkillInfo():void {
        this.dispose();
    }

    public function dispose():void {
        this._skillInfo = null;
    }
}
}
