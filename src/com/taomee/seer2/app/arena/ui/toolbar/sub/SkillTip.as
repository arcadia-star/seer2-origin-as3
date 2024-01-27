package com.taomee.seer2.app.arena.ui.toolbar.sub {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

public class SkillTip extends Sprite {


    private var _tip:MovieClip;

    private var _back:MovieClip;

    private var _descriptionTxt:TextField;

    public function SkillTip() {
        super();
        this.initialize();
    }

    private function initialize():void {
        var _loc1_:TextFormat = null;
        DisplayObjectUtil.disableSprite(this);
        this._tip = FightUIManager.getMovieClip("UI_FightSkillTip");
        this._back = this._tip["backMc"];
        this._descriptionTxt = this._tip["txtDes"];
        _loc1_ = new TextFormat("", 10);
        this._descriptionTxt.textColor = 16777215;
        this._descriptionTxt.selectable = false;
        this._descriptionTxt.mouseEnabled = false;
        this._descriptionTxt.defaultTextFormat = _loc1_;
        addChild(this._tip);
    }

    public function setSkillInfo(param1:SkillInfo):void {
        var _loc2_:Array = param1.description.split(" ");
        var _loc3_:String = _loc2_.join("\n");
        this._descriptionTxt.text = _loc3_;
    }
}
}
