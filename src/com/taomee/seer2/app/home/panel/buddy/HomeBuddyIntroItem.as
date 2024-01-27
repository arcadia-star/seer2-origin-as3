package com.taomee.seer2.app.home.panel.buddy {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.actor.preview.ActorPreview;
import com.taomee.seer2.app.component.VipLogoDisplayer;
import com.taomee.seer2.app.home.panel.data.HomeBuddyDataUnit;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class HomeBuddyIntroItem extends Sprite {


    protected var _dataUnit:HomeBuddyDataUnit;

    protected var _container:MovieClip;

    protected var _nickTxt:TextField;

    protected var _genderMc:MovieClip;

    protected var _preview:ActorPreview;

    protected var _vipLogo:VipLogoDisplayer;

    public function HomeBuddyIntroItem() {
        super();
        this.createChildren();
    }

    protected function createChildren():void {
        addChild(this._container);
        this._nickTxt = this._container["nick"];
        this._genderMc = this._container["gender"];
        this._genderMc.gotoAndStop(1);
        this._preview = new ActorPreview();
        this._preview.scaleX = this._preview.scaleY = 0.42;
        this._preview.x = 54;
        this._preview.y = 100;
        DisplayObjectUtil.disableSprite(this._preview);
        this._container.addChild(this._preview);
    }

    public function setData(param1:HomeBuddyDataUnit):void {
        this._dataUnit = param1;
        this.updateDisplay();
    }

    protected function updateDisplay():void {
        var _loc1_:UserInfo = this._dataUnit.userInfo;
        this._nickTxt.text = _loc1_.nick;
        this._genderMc.gotoAndStop(_loc1_.sex + 1);
        this._preview.setData(_loc1_);
        if (this._vipLogo) {
            this._vipLogo.setVipFlag(_loc1_.vipInfo);
        }
    }

    public function dispose():void {
        this._preview.dispose();
        if (this._vipLogo) {
            this._vipLogo.dispose();
            this._vipLogo = null;
        }
    }
}
}
