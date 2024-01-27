package com.taomee.seer2.app.arena.ui.status.statusBar {
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
import com.taomee.seer2.app.arena.data.FighterInfo;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.ui.status.AngerBar;
import com.taomee.seer2.app.arena.ui.status.ShrinkBar;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.component.PetTypeIcon;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.UINumberGenerator;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;

public class FighterStatusBar extends Sprite {


    protected var _fighter:Fighter;

    protected var _back:Sprite;

    protected var _iconDisplayer:IconDisplayer;

    protected var _sign:Sprite;

    protected var _healthShadowBar:ShrinkBar;

    protected var _angerBar:ShrinkBar;

    protected var _angerSign:Sprite;

    protected var _levelSprite:Sprite;

    protected var _nameSprite:Sprite;

    protected var _typeIcon:PetTypeIcon;

    protected var _healthBar:ShrinkBar;

    protected var _hpSign:Sprite;

    protected var _preeeMC:MovieClip;

    protected var _shape:Shape;

    private var border:MovieClip;

    public function FighterStatusBar() {
        super();
        DisplayObjectUtil.disableSprite(this);
        this.createChildren();
        this.layout();
    }

    public function setFighter(param1:Fighter):void {
        this._fighter = param1;
        this.initDisplay();
    }

    public function update():void {
        this.updateHpSign();
        this.updateAngerSign();
        this.updateHealthBar();
        this.updateAngerBar();
    }

    public function updatePetPress(param1:int):void {
    }

    public function dispose():void {
        DisplayObjectUtil.removeAllChildren(this);
        this._iconDisplayer.dispose();
        this._iconDisplayer = null;
        this._fighter = null;
        this._back = null;
        this._sign = null;
        this._angerBar.dispose();
        this._angerBar = null;
        this._healthBar.dispose();
        this._healthBar = null;
        this._healthShadowBar.dispose();
        this._healthShadowBar = null;
        this._hpSign = null;
        this._angerSign = null;
        this._levelSprite = null;
        this._nameSprite = null;
        this._typeIcon = null;
        this._shape = null;
    }

    protected function createChildren():void {
        this.createBack();
        this.createShapeIcon();
        this.createFighterIcon();
        this.createSign();
        this.createHealthShadowBar();
        this.createAngerBar();
        this.createAngerSign();
        this.createLevelSprite();
        this.createNameSprite();
        this.createTypeIcon();
        this.createHealthBar();
        this.createHpSign();
    }

    protected function createBack():void {
        if (ArenaUIIsNew.isNewUI) {
            this._back = FightUIManager.getSprite("New_UI_FightStatusBarBack");
        } else {
            this._back = FightUIManager.getSprite("UI_FightStatusBarBack");
            this._preeeMC = this._back["preeMC"];
            this._preeeMC.gotoAndStop(1);
        }
        addChild(this._back);
    }

    protected function createFighterIcon():void {
        this._iconDisplayer = new IconDisplayer();
        if (ArenaUIIsNew.isNewUI) {
            this._back["icon"].addChildAt(this._iconDisplayer, this._back["icon"].numChildren - 1);
        } else {
            addChild(this._iconDisplayer);
        }
    }

    protected function createShapeIcon():void {
        this._shape = new Shape();
        addChild(this._shape);
    }

    protected function createSign():void {
        this._sign = FightUIManager.getSprite("UI_FightStatusBarSign");
        if (ArenaUIIsNew.isNewUI == false) {
            addChild(this._sign);
        }
    }

    protected function createHealthShadowBar():void {
        this._healthShadowBar = new ShrinkBar("UI_FightHealthShadowBar");
    }

    protected function createAngerBar():void {
        if (ArenaUIIsNew.isNewUI) {
            this._angerBar = new AngerBar("New_UI_FightAngerBar");
        } else {
            this._angerBar = new AngerBar("UI_FightAngerBar");
        }
        addChild(this._angerBar);
    }

    protected function createHealthBar():void {
        if (ArenaUIIsNew.isNewUI) {
            this._healthBar = new ShrinkBar("New_UI_FightHealthBar");
        } else {
            this._healthBar = new ShrinkBar("UI_FightHealthBar");
        }
        addChild(this._healthBar);
    }

    protected function createHpSign():void {
        this._hpSign = new Sprite();
        addChild(this._hpSign);
    }

    protected function createAngerSign():void {
        this._angerSign = new Sprite();
        addChild(this._angerSign);
    }

    protected function createLevelSprite():void {
        this._levelSprite = new Sprite();
        this._levelSprite.addChild(FightUIManager.getSprite("UI_FighterLevelSign"));
        addChild(this._levelSprite);
    }

    protected function createNameSprite():void {
        this._nameSprite = FightUIManager.getSprite("UI_FighterName");
        addChild(this._nameSprite);
    }

    protected function createTypeIcon():void {
        this._typeIcon = new PetTypeIcon();
        addChild(this._typeIcon);
    }

    protected function layout():void {
        if (ArenaUIIsNew.isNewUI) {
            this.setChildPosition(this._iconDisplayer, 15, 10);
            this.setChildPosition(this._sign, 79, 40);
            this.setChildPosition(this._healthShadowBar, 90, 38);
            this.setChildPosition(this._healthBar, 93, 36);
            this.setChildPosition(this._hpSign, 190, 39);
            this.setChildPosition(this._angerBar, 88, 64);
            this.setChildPosition(this._angerSign, 190, 65);
            this.setChildPosition(this._levelSprite, 170, 15);
            this.setChildPosition(this._nameSprite, 95, 11);
            this.setChildPosition(this._typeIcon, 240, 13);
        } else {
            this.setChildPosition(this._iconDisplayer, 6, 7);
            this.setChildPosition(this._sign, 85, 9);
            this.setChildPosition(this._healthShadowBar, 92, 41);
            this.setChildPosition(this._healthBar, 111, 10);
            this.setChildPosition(this._hpSign, 190, 13);
            this.setChildPosition(this._angerBar, 110, 33);
            this.setChildPosition(this._angerSign, 190, 33);
            this.setChildPosition(this._levelSprite, 82, 53);
            this.setChildPosition(this._nameSprite, 4, 86);
            this.setChildPosition(this._typeIcon, 145, 51);
        }
    }

    protected function initDisplay():void {
        this.loadIcon();
        this.updateHpSign();
        this.updateAngerSign();
        this.updateAngerBar();
        this.initHealthBar();
        this.initLevel();
        this.initName();
        this.initTypeIcon();
    }

    protected function loadIcon():void {
        var _loc3_:String = null;
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        this._iconDisplayer.setIconUrl(this._fighter.iconUrl);
        var _loc1_:Sprite = this.getCurIconDisplayerParent();
        _loc1_.addChildAt(this._iconDisplayer, _loc1_.numChildren - 2);
        var _loc2_:FighterInfo = this._fighter.fighterInfo;
        if (this.border) {
            DisplayObjectUtil.removeFromParent(this.border);
        }
        if (_loc2_.evolveLevel != 0) {
            _loc3_ = "";
            if ((_loc4_ = _loc2_.evolveLevel > 1000 ? uint(_loc2_.evolveLevel - 1000) : _loc2_.evolveLevel) > 2) {
                if (_loc4_ < 5) {
                    _loc3_ = "UI_AgBorder";
                } else if (_loc4_ < 7) {
                    _loc3_ = "UI_GoldBorder";
                } else {
                    _loc3_ = "UI_PurpleBorder";
                }
                if (_loc3_.length > 0) {
                    this.border = UIManager.getMovieClip(_loc3_);
                    this.border.mouseChildren = false;
                    this.border.mouseEnabled = false;
                    this.border.x = 0;
                    this.border.y = 0;
                    _loc5_ = this.getCurBorderTargetIndex();
                    addChildAt(this.border, _loc5_ + 1);
                }
            }
        }
    }

    private function getCurIconDisplayerParent():Sprite {
        var _loc1_:Sprite = null;
        if (Boolean(this._back) && this._back.contains(this._iconDisplayer)) {
            _loc1_ = this._back["icon"];
        } else {
            _loc1_ = this;
        }
        return _loc1_;
    }

    private function getCurBorderTargetIndex():int {
        var _loc1_:int = 0;
        if (Boolean(this._back) && this._back.contains(this._iconDisplayer)) {
            _loc1_ = getChildIndex(this._back);
        } else {
            _loc1_ = getChildIndex(this._iconDisplayer);
        }
        return _loc1_;
    }

    protected function updateHpSign():void {
        if (this._hpSign.numChildren > 0) {
            this._hpSign.removeChildAt(0);
        }
        var _loc1_:FighterInfo = this._fighter.fighterInfo;
        this._hpSign.addChild(UINumberGenerator.generateHpNumber(_loc1_.hp, _loc1_.maxHp));
    }

    protected function updateAngerSign():void {
        if (this._angerSign.numChildren > 0) {
            this._angerSign.removeChildAt(0);
        }
        var _loc1_:FighterInfo = this._fighter.fighterInfo;
        this._angerSign.addChild(UINumberGenerator.generateAngerNumber(_loc1_.fightAnger, _loc1_.maxAnger));
    }

    protected function updateHealthBar():void {
        var _loc1_:FighterInfo = this._fighter.fighterInfo;
        var _loc2_:Number = _loc1_.hp / _loc1_.maxHp;
        this._healthBar.playToPercent(_loc2_);
        this._healthShadowBar.playToPercent(_loc2_);
    }

    protected function updateAngerBar():void {
        var _loc1_:FighterInfo = this._fighter.fighterInfo;
        var _loc2_:Number = _loc1_.fightAnger / _loc1_.maxAnger;
        this._angerBar.playToPercent(_loc2_);
    }

    protected function initHealthBar():void {
        var _loc1_:Number = this._fighter.fighterInfo.hp / this._fighter.fighterInfo.maxHp;
        this._healthBar.initAtPercent(_loc1_);
        this._healthShadowBar.initAtPercent(_loc1_);
    }

    protected function initLevel():void {
        if (this._levelSprite.numChildren > 1) {
            this._levelSprite.removeChildAt(1);
        }
        var _loc1_:Sprite = UINumberGenerator.generateFighterLevelNumber(this._fighter.fighterInfo.level);
        _loc1_.x = 30;
        this._levelSprite.addChild(_loc1_);
    }

    protected function initName():void {
        (this._nameSprite["fighterNameTxt"] as TextField).text = this._fighter.fighterInfo.name;
    }

    protected function initTypeIcon():void {
        this._typeIcon.clear();
        var _loc1_:int = this._fighter.fighterInfo.typeId;
        this._typeIcon.type = _loc1_;
        this._typeIcon.scaleY = 0.5;
        this._typeIcon.scaleX = 0.5;
    }

    protected function setChildPosition(param1:DisplayObject, param2:int, param3:int):void {
        param1.x = param2;
        param1.y = param3;
    }
}
}
