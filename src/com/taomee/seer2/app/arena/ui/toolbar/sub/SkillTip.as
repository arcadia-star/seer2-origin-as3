package com.taomee.seer2.app.arena.ui.toolbar.sub {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import seer2.next.utils.TextUtils;

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
        this._descriptionTxt.autoSize = TextFieldAutoSize.LEFT;
        this._descriptionTxt.wordWrap = true;
        addChild(this._tip);
    }

    public function setSkillInfo(param1:SkillInfo):void {
        this._descriptionTxt.htmlText = TextUtils.wrapHtmlFontSize(TextUtils.replaceColorFormat(param1.description));
        _back.height = Math.max(110.55, _descriptionTxt.height + 20);
        _descriptionTxt.y = 5 - _back.height;
    }
}
}
