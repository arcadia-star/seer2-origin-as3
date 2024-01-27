package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.component.PetPotentialityIcon;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.effects.MotionEffects;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class SelectPetAlert extends Sprite implements IAlert {


    protected var _ui:MovieClip;

    protected var _tipTxt:TextField;

    protected var _curtCell:MovieClip;

    protected var _curtLight:MovieClip;

    protected var _petInfoVec:Vector.<PetInfo>;

    protected var _pet:PetInfo;

    protected var _str:String;

    protected var _confirmHandler:Function;

    protected var _cancelHandler:Function;

    protected var _confirmBtn:SimpleButton;

    protected var _cancelBtn:SimpleButton;

    public function SelectPetAlert() {
        super();
        this.setup();
    }

    private function setup():void {
        this.setMainUI(UIManager.getMovieClip("UI_SelectPet"));
        this._tipTxt = this._ui["tipTxt"];
        var _loc1_:uint = 0;
        while (_loc1_ < 6) {
            (this._ui["cell_" + _loc1_] as MovieClip).buttonMode = true;
            (this._ui["cell_" + _loc1_] as MovieClip).addEventListener(MouseEvent.CLICK, this.onMouseCell);
            (this._ui["cell_" + _loc1_]["light"] as MovieClip).gotoAndStop(1);
            (this._ui["cell_" + _loc1_] as MovieClip).addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            (this._ui["cell_" + _loc1_] as MovieClip).addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            (this._ui["cell_" + _loc1_] as MovieClip).mouseChildren = false;
            _loc1_++;
        }
        this._confirmBtn = this._ui["confirmBtn"];
        this._cancelBtn = this._ui["cancelBtn"];
        DisplayObjectUtil.disableButton(this._confirmBtn);
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.okBtn);
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        addChild(this._ui);
    }

    protected function setMainUI(param1:MovieClip):void {
        this._ui = param1;
    }

    private function onCancelBtnClick(param1:MouseEvent):void {
        if (this._cancelHandler != null) {
            this._cancelHandler();
            this._cancelHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }

    private function createPets():void {
        var _loc1_:IconDisplayer = null;
        var _loc3_:PetPotentialityIcon = null;
        this._petInfoVec = PetInfoManager.getAllBagPetInfo();
        var _loc2_:uint = 0;
        while (_loc2_ < this._petInfoVec.length) {
            (this._ui["cell_" + _loc2_] as MovieClip).visible = true;
            (this._ui["cell_" + _loc2_]["selector"] as MovieClip).visible = false;
            _loc1_ = new IconDisplayer();
            _loc1_.scaleY = _loc1_.scaleX = 1.5;
            _loc1_.x = _loc1_.y = -40;
            _loc1_.setIconUrl(URLUtil.getPetIcon(this._petInfoVec[_loc2_].resourceId));
            (this._ui["cell_" + _loc2_] as MovieClip).addChildAt(_loc1_, 1);
            (this._ui["cell_" + _loc2_]["levelTxt"] as TextField).text = this._petInfoVec[_loc2_].level.toString();
            (this._ui["cell_" + _loc2_]["studyTxt"] as TextField).text = "" + this._petInfoVec[_loc2_].learningInfo.pointTotal();
            _loc3_ = new PetPotentialityIcon();
            _loc3_.x = 15;
            _loc3_.y = 3;
            (this._ui["cell_" + _loc2_] as MovieClip).addChild(_loc3_);
            _loc3_.visible = true;
            _loc3_.setPotential(this._petInfoVec[_loc2_].potential, this._petInfoVec[_loc2_].isAggraisal);
            _loc2_++;
        }
        this._tipTxt.htmlText = this._str;
    }

    protected function okBtn(param1:MouseEvent):void {
        var _loc2_:uint = 0;
        if (this._curtCell != null) {
            _loc2_ = uint(this._curtCell.name.slice(5));
            if (_loc2_ < this._petInfoVec.length) {
                this._pet = this._petInfoVec[_loc2_];
                DisplayObjectUtil.disableButton(this._confirmBtn);
                if (this._confirmHandler != null) {
                    this._confirmHandler(this._pet);
                    this._confirmHandler = null;
                }
                this.dispose();
            }
        }
    }

    private function onMouseCell(param1:MouseEvent):void {
        DisplayObjectUtil.enableButton(this._confirmBtn);
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        this.selectCell(_loc2_);
        this._curtCell = _loc2_;
    }

    private function selectCell(param1:MovieClip):void {
        var _loc2_:uint = 0;
        while (_loc2_ < 6) {
            if (this._ui["cell_" + _loc2_] as MovieClip == param1) {
                (this._ui["cell_" + _loc2_]["selector"] as MovieClip).visible = true;
            } else {
                (this._ui["cell_" + _loc2_]["selector"] as MovieClip).visible = false;
            }
            _loc2_++;
        }
    }

    private function onMouseOver(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        this._curtLight = _loc2_["light"] as MovieClip;
        this._curtLight.addEventListener(Event.ENTER_FRAME, this.onLightMcEnter);
        this._curtLight.gotoAndPlay(1);
        MotionEffects.execElastic(_loc2_);
    }

    private function onLightMcEnter(param1:Event):void {
        if (this._curtLight) {
            if (this._curtLight.currentFrame == this._curtLight.totalFrames) {
                this._curtLight.removeEventListener(Event.ENTER_FRAME, this.onLightMcEnter);
                this._curtLight.gotoAndStop(1);
            }
        }
    }

    private function onMouseOut(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        MotionEffects.resetScale(_loc2_);
    }

    public function show(param1:AlertInfo):void {
        this._str = param1.initInfo.message;
        this._confirmHandler = param1.initInfo.confirmHandler;
        this._cancelHandler = param1.initInfo.cancelHandler;
        this.createPets();
        AlertManager.addPopUp(param1, this);
    }

    public function dispose():void {
        var _loc1_:uint = 0;
        while (_loc1_ < 6) {
            (this._ui["cell_" + _loc1_] as MovieClip).removeEventListener(MouseEvent.CLICK, this.onMouseCell);
            (this._ui["cell_" + _loc1_] as MovieClip).removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            (this._ui["cell_" + _loc1_] as MovieClip).removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            _loc1_++;
        }
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.okBtn);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        this._confirmHandler = null;
        this._cancelHandler = null;
        this._ui = null;
        this._confirmBtn = null;
        this._cancelBtn = null;
        this._tipTxt = null;
        this._pet = null;
        this._petInfoVec = null;
        this._curtCell = null;
        this._curtLight = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}
