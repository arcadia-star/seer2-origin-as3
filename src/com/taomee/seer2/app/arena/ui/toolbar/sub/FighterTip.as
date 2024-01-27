package com.taomee.seer2.app.arena.ui.toolbar.sub {
import com.taomee.seer2.app.arena.data.FighterInfo;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.pet.data.SkillInfo;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class FighterTip extends Sprite {

    private static const ITEM_MAX_NUM:int = 5;

    private static const ITEM_HEIGHT:int = 37;


    private var _back:Sprite;

    private var _itemVec:Vector.<MovieClip>;

    public function FighterTip() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this.createChildren();
    }

    private function createChildren():void {
        this.createBack();
        this.createItemVec();
    }

    private function createBack():void {
        this._back = FightUIManager.getSprite("UI_FightPetTipBack");
        addChild(this._back);
    }

    private function createItemVec():void {
        var _loc3_:MovieClip = null;
        this._itemVec = new Vector.<MovieClip>();
        var _loc1_:int = 6;
        var _loc2_:int = 0;
        while (_loc2_ < ITEM_MAX_NUM) {
            _loc3_ = FightUIManager.getMovieClip("UI_FightPeTipItem");
            _loc3_.x = _loc1_;
            this._itemVec.push(_loc3_);
            addChild(_loc3_);
            _loc2_++;
        }
    }

    public function setFighterInfo(param1:FighterInfo):void {
        this.updateSkillConent(param1.skillInfoVec);
    }

    private function updateSkillConent(param1:Vector.<SkillInfo>):void {
        this.resetSkillContent();
        var _loc2_:int = int(param1.length);
        _loc2_ = _loc2_ <= this._itemVec.length ? _loc2_ : int(this._itemVec.length);
        this._back.height = ITEM_HEIGHT * _loc2_ + 40;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (this._itemVec[_loc3_] != null) {
                this._itemVec[_loc3_].y = -1 * this._back.height + _loc3_ * ITEM_HEIGHT + 10;
                this.showSkillItem(this._itemVec[_loc3_], param1[_loc3_]);
            }
            _loc3_++;
        }
    }

    private function showSkillItem(param1:MovieClip, param2:SkillInfo):void {
        var _loc3_:TextField = param1["nameTxt"];
        var _loc4_:TextField = param1["powerTxt"];
        var _loc5_:TextField = param1["powerValueTxt"];
        var _loc6_:TextField = param1["angerTxt"];
        var _loc7_:TextField = param1["angerValueTxt"];
        _loc3_.text = param2.name;
        _loc4_.text = "威力" + ":";
        _loc5_.text = param2.power.toString();
        _loc6_.text = "怒气" + ":";
        _loc7_.text = param2.anger.toString();
        param1.visible = true;
    }

    private function resetSkillContent():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._itemVec) {
            _loc1_.visible = false;
        }
    }
}
}
