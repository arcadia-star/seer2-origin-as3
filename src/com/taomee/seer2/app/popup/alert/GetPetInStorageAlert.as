package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertInitInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
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

import org.taomee.filter.ColorFilter;

public class GetPetInStorageAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _starEffect:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _iconDisplay:IconDisplayer;

    private var _icon:MovieClip;

    private var _btnList:Vector.<SimpleButton>;

    private var _nameTxt:TextField;

    private var _contentTxt:TextField;

    private var _info:AlertInitInfo;

    private const moduleList:Array = [201058, 201038, "PetBagPanel", "", ""];

    private const POS_LIST:Vector.<Point> = Vector.<Point>([new Point(126, -6.2), new Point(129, -9.8), new Point(138, -8), new Point(141, -9), new Point(139, -4), new Point(154, -4)]);

    public function GetPetInStorageAlert() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_GetPet");
        this._confirmBtn = this._ui["confirmBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._nameTxt = this._ui["nameTxt"];
        this._contentTxt = this._ui["contentTxt"];
        this._icon = this._ui["icon"];
        this._iconDisplay = new IconDisplayer();
        this._iconDisplay.scaleX = this._iconDisplay.scaleY = 1;
        this._iconDisplay.x = this._iconDisplay.y = -40;
        this._icon.addChildAt(this._iconDisplay, 0);
        this._btnList = Vector.<SimpleButton>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 5) {
            this._btnList.push(this._ui["btn" + _loc1_]);
            this._btnList[_loc1_].addEventListener(MouseEvent.CLICK, this.onBtn);
            _loc1_++;
        }
        addChild(this._ui);
        this.funcBtnFilter();
    }

    private function funcBtnFilter():void {
        if (QuestManager.isCanAccepted(99) && NewPlayerGuideTimeManager.timeCheckNewGuide() || QuestManager.isAccepted(99) && !QuestManager.isComplete(99) || QuestManager.isAccepted(1) && !QuestManager.isComplete(1)) {
            this.setFuncBtnVisible(false);
        } else {
            this.setFuncBtnVisible(true);
        }
    }

    private function setFuncBtnVisible(param1:Boolean):void {
        var _loc2_:SimpleButton = null;
        for each(_loc2_ in this._btnList) {
            _loc2_.visible = param1;
        }
    }

    private function onBtn(param1:MouseEvent):void {
        var _loc3_:BuyPropInfo = null;
        var _loc4_:Object = null;
        var _loc5_:uint = 0;
        var _loc6_:uint = 0;
        var _loc7_:String = null;
        var _loc2_:int = this._btnList.indexOf(param1.currentTarget as SimpleButton);
        if (_loc2_ < 2) {
            _loc3_ = new BuyPropInfo();
            _loc3_.itemId = this.moduleList[_loc2_];
            ShopManager.buyBagItem(_loc3_);
        } else if (_loc2_ < 3) {
            (_loc4_ = new Object()).type = 0;
            _loc4_.subType = 2;
            ModuleManager.showModule(URLUtil.getAppModule(this.moduleList[_loc2_]), "", _loc4_);
        } else if (_loc2_ < 4) {
            if ((_loc5_ = PetConfig.getPetDefinition(this._info.referenceId).emblemId) == 0) {
                return;
            }
            if ((_loc6_ = ItemConfig.getEmblemDefinition(_loc5_).miBuyID) == 0) {
                return;
            }
            ShopManager.buyItemForId(_loc6_);
        } else if (_loc2_ < 5) {
            _loc7_ = PetConfig.getPetDefinitionInfo(this._info.referenceId).superModule;
            ModuleManager.showModule(URLUtil.getAppModule(_loc7_), "");
        }
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
        var _loc1_:String = String(URLUtil.getPetIcon(this._info.referenceId));
        var _loc2_:String = PetConfig.getPetDefinition(this._info.referenceId).name;
        this._iconDisplay.setIconUrl(_loc1_);
        this._contentTxt.htmlText = "精灵:" + "<font color=\'#ff0000\'>" + _loc2_ + "</font>已经放入精灵仓库";
        this._nameTxt.text = _loc2_;
    }

    public function show(param1:AlertInfo):void {
        var level:int;
        var moduleStr:String;
        var posX:int = 0;
        var posY:int = 0;
        var info:AlertInfo = param1;
        this._info = info.initInfo;
        level = int(PetConfig.getPetDefinition(this._info.referenceId).starLevel);
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
        this._ui.addChild(this._contentTxt);
        if (info.centralize == true) {
            posX = LayerManager.root.width - this.width >> 1;
            posY = LayerManager.root.height - this.height >> 1;
            this.x = posX;
            this.y = posY;
        }
        LayerManager.moduleLayer.addChild(this);
        moduleStr = PetConfig.getPetDefinitionInfo(this._info.referenceId).superModule;
        if (moduleStr == "") {
            this._btnList[4].mouseEnabled = false;
            ColorFilter.setGrayscale(this._btnList[4]);
        } else {
            this._btnList[4].mouseEnabled = true;
            this._btnList[4].filters = [];
        }
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
