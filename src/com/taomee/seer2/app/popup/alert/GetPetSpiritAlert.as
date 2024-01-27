package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.item.PetSpirtTrainItemDefinition;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertInitInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

public class GetPetSpiritAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _starEffect:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _iconDisplay:IconDisplayer;

    private var _nameTxt:TextField;

    private var _contentTxt:TextField;

    private var _info:AlertInitInfo;

    private const POS_LIST:Vector.<Point> = Vector.<Point>([new Point(126, 21), new Point(129, 21), new Point(128, 21), new Point(131, 21), new Point(126, 21), new Point(141, 21)]);

    public function GetPetSpiritAlert() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_GetPetSpirit");
        this._confirmBtn = this._ui["confirmBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._nameTxt = this._ui["nameTxt"];
        this._contentTxt = this._ui["contentTxt"];
        this._iconDisplay = new IconDisplayer();
        this._iconDisplay.setBoundary(60, 60);
        this._iconDisplay.x = 105;
        this._iconDisplay.y = 70;
        this._ui.addChild(this._iconDisplay);
        addChild(this._ui);
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        var _loc2_:Point = new Point(this._iconDisplay.x, this._iconDisplay.y);
        var _loc3_:Point = this._iconDisplay.parent.localToGlobal(_loc2_);
        this._iconDisplay.x = _loc3_.x;
        this._iconDisplay.y = _loc3_.y;
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._confirmBtn = null;
        DisplayObjectUtil.removeFromParent(this._ui);
        this.dispose();
    }

    private function tweenComplete():void {
        if (Boolean(this._iconDisplay) && Boolean(this._iconDisplay.parent)) {
            DisplayObjectUtil.removeFromParent(this._iconDisplay);
        }
        this._iconDisplay = null;
    }

    private function displayMessage():void {
        var _loc1_:String = String(URLUtil.getPetSpirtTrainIcon(this._info.referenceId));
        var _loc2_:PetSpirtTrainItemDefinition = ItemConfig.getItemDefinition(this._info.referenceId) as PetSpirtTrainItemDefinition;
        var _loc3_:String = PetConfig.getPetDefinition(_loc2_.breedMonID).name;
        this._iconDisplay.setIconUrl(_loc1_);
        this._contentTxt.htmlText = (_loc2_.type == 23 ? "精元蛋:" : "精元:").toString() + "<font color=\'#ff0000\'>" + _loc3_ + "</font>已经放入精元孵化器";
        this._nameTxt.text = _loc3_;
    }

    public function show(param1:AlertInfo):void {
        var level:int;
        var posX:int = 0;
        var posY:int = 0;
        var info:AlertInfo = param1;
        this._info = info.initInfo;
        level = int(PetConfig.getPetDefinition((ItemConfig.getItemDefinition(this._info.referenceId) as PetSpirtTrainItemDefinition).breedMonID).starLevel);
        if (level == 0) {
            level = 1;
        }
        this._starEffect = UIManager.getMovieClip("UI_StarLevel_" + level);
        this._ui.addChild(this._starEffect);
        this._starEffect.x = this.POS_LIST[level - 1].x;
        this._starEffect.y = this.POS_LIST[level - 1].y;
        MovieClipUtil.playMc(this._starEffect, 2, this._starEffect.totalFrames, function ():void {
            _starEffect.gotoAndStop(_starEffect.totalFrames);
        });
        this.displayMessage();
        if (info.centralize == true) {
            posX = LayerManager.root.width - this.width >> 1;
            posY = LayerManager.root.height - this.height >> 1;
            this.x = posX;
            this.y = posY;
        }
        LayerManager.topLayer.addChild(this);
    }

    public function dispose():void {
        if (this._info.closeHandler != null) {
            this._info.closeHandler();
            this._info.closeHandler = null;
        }
        this._info = null;
        this._ui = null;
        AlertManager.removePopUp(this, false);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}
