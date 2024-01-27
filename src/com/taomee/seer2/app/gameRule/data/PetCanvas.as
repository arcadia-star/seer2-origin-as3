package com.taomee.seer2.app.gameRule.data {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoHelper;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;

public class PetCanvas {


    private var _petInfo:PetInfo;

    private var _ui:MovieClip;

    private var _cureBtn:SimpleButton;

    private var _nameTxt:TextField;

    private var _levelTxt:TextField;

    private var _HP:DisplayObject;

    private var _content:MovieClip;

    private var _highLight:DisplayObject;

    private var _border:MovieClip;

    public function PetCanvas(param1:MovieClip) {
        super();
        this._ui = param1;
    }

    public function dispose():void {
        this.removeCureListener();
        this._ui = null;
        this._cureBtn = null;
        this._nameTxt = null;
        this._levelTxt = null;
        this._HP = null;
        this._content = null;
        this._highLight = null;
        if (this._border) {
            DisplayObjectUtil.removeFromParent(this._border);
            this._border = null;
        }
    }

    public function get ui():MovieClip {
        return this._ui;
    }

    public function get cureBtn():SimpleButton {
        if (this._cureBtn == null) {
            this._cureBtn = this._ui["cureBtn"] as SimpleButton;
        }
        return this._cureBtn;
    }

    public function get nameTxt():TextField {
        if (this._nameTxt == null) {
            this._nameTxt = this._ui["nameTxt"] as TextField;
        }
        return this._nameTxt;
    }

    public function get levelTxt():TextField {
        if (this._levelTxt == null) {
            this._levelTxt = this._ui["levelTxt"] as TextField;
        }
        return this._levelTxt;
    }

    public function get HP():DisplayObject {
        if (this._HP == null) {
            this._HP = this._ui["HP"] as DisplayObject;
        }
        return this._HP;
    }

    public function get content():MovieClip {
        if (this._content == null) {
            if (this._ui && this._ui["content"] && Boolean(this._ui["content"]["content"])) {
                this._content = this._ui["content"]["content"] as MovieClip;
            }
        }
        return this._content;
    }

    public function get highLight():DisplayObject {
        if (this._highLight == null) {
            this._highLight = this._ui["s0"] as DisplayObject;
        }
        return this._highLight;
    }

    public function get petInfo():PetInfo {
        return this._petInfo;
    }

    public function set petInfo(param1:PetInfo):void {
        this._petInfo = param1;
    }

    public function reset():void {
        this.cureBtn.visible = false;
        this.highLight.visible = false;
        this.nameTxt.text = "";
        this.levelTxt.text = "";
        this.petInfo = null;
        DisplayObjectUtil.removeAllChildren(this.content);
        this.removeCureListener();
        if (this._border) {
            DisplayObjectUtil.removeFromParent(this._border);
        }
    }

    public function removeCureListener():void {
        if (this.cureBtn.hasEventListener(MouseEvent.CLICK)) {
            this.cureBtn.removeEventListener(MouseEvent.CLICK, this.onCureBtnClick);
        }
    }

    public function addCureListener():void {
        this.cureBtn.addEventListener(MouseEvent.CLICK, this.onCureBtnClick);
    }

    public function updatePetInfo():void {
        var nn:Number;
        var url:String;
        var _icon:IconDisplayer = null;
        var onContentLoaded:Function = null;
        onContentLoaded = function ():void {
            if (content) {
                DisplayObjectUtil.removeAllChildren(content);
                content.addChild(_icon);
            }
        };
        if (this.nameTxt) {
            this.nameTxt.text = this.petInfo.name;
        }
        if (this.levelTxt) {
            this.levelTxt.text = String(this.petInfo.level);
        }
        nn = this.petInfo.hp / this.petInfo.maxHp;
        nn = nn > 1 ? 1 : nn;
        this.HP.scaleX = nn;
        url = String(URLUtil.getPetIcon(this.petInfo.resourceId));
        _icon = new IconDisplayer();
        _icon.scaleY = _icon.scaleX = 1.5;
        _icon.x = _icon.y = 3;
        _icon.setIconUrl(url, onContentLoaded);
        this.updateEvolve();
    }

    public function updateEvolve():void {
        var _loc1_:String = null;
        var _loc2_:uint = 0;
        if (this._border) {
            DisplayObjectUtil.removeFromParent(this._border);
            this._border = null;
        }
        if (this.petInfo.evolveLevel != 0) {
            _loc1_ = "";
            _loc2_ = this.petInfo.evolveLevel > 1000 ? uint(this.petInfo.evolveLevel - 1000) : this.petInfo.evolveLevel;
            if (_loc2_ > 2) {
                if (_loc2_ < 5) {
                    _loc1_ = "UI_AgBorder";
                } else if (_loc2_ < 7) {
                    _loc1_ = "UI_GoldBorder";
                } else {
                    _loc1_ = "UI_PurpleBorder";
                }
                if (_loc1_.length > 0) {
                    this._border = UIManager.getMovieClip(_loc1_);
                    this._border.x = 0;
                    this._border.y = 0;
                    this._border.mouseEnabled = this._border.mouseChildren = false;
                    this.content.addChild(this._border);
                }
            }
        }
    }

    private function onCureBtnClick(param1:MouseEvent):void {
        var onCancelCurePet:Function = null;
        var onPetCureSuccess:Function = null;
        var needCoins:int = 0;
        var event:MouseEvent = param1;
        onCancelCurePet = function ():void {
            DisplayObjectUtil.enableButton(cureBtn);
        };
        onPetCureSuccess = function (param1:PetInfoEvent):void {
            PetInfoManager.removeEventListener(PetInfoEvent.PET_CURE, onPetCureSuccess);
            DisplayObjectUtil.enableButton(cureBtn);
            ui.filters = [];
            petInfo = PetInfoManager.getPetInfoFromBag(petInfo.catchTime);
            updatePetInfo();
            if (petInfo.hp != petInfo.maxHp) {
                cureBtn.visible = true;
            } else {
                cureBtn.visible = false;
            }
        };
        if (this._petInfo != null) {
            if (this.petInfo.maxHp - this.petInfo.hp <= 0) {
                AlertManager.showAlert("这只精灵不需要恢复体力");
                return;
            }
            needCoins = PetInfoHelper.getCoinsForCure(this.petInfo);
            if (needCoins < ActorManager.actorInfo.coins) {
                PetInfoManager.addEventListener(PetInfoEvent.PET_CURE, onPetCureSuccess);
                PetInfoManager.requestCurePet(this.petInfo);
            } else {
                AlertManager.showAlert("没有足够的赛尔豆", onCancelCurePet);
            }
            DisplayObjectUtil.disableButton(this.cureBtn);
        }
        event.stopImmediatePropagation();
    }
}
}
