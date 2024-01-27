package com.taomee.seer2.app.arena.ui.status {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.component.PetTypeIcon;

import flash.display.Sprite;

public class FightInfoRelation extends Sprite {

    private static const RELATION_LIST:Array = [[4, 6, 7], [2, 8, 15], [3, 9, 16], [4, 10, 11], [4, 7, 14, 18, 17], [8, 10, 17], [9, 16], [3, 5, 7, 18], [4, 14, 15], [6, 12, 13], [2, 9, 18], [3, 8, 18, 12, 13], [5, 11], [6, 14, 18, 13], [2, 5, 10, 18, 17], [11, 12, 15], [6, 9, 12, 13, 15, 16]];


    private const H_SPACE_MARK:int = 10;

    private const H_SPACE_ICON:int = 10;

    public function FightInfoRelation() {
        super();
    }

    public function showRelation(param1:int):void {
        var _loc2_:Sprite = null;
        var _loc3_:PetTypeIcon = null;
        var _loc5_:int = 0;
        if (param1 >= 19) {
            return;
        }
        _loc2_ = FightUIManager.getMovieClip("UI_Mark");
        _loc2_.x = 475.75;
        _loc2_.y = 371.9;
        addChild(_loc2_);
        _loc3_ = new PetTypeIcon();
        _loc3_.type = param1;
        _loc3_.y = 366.45;
        _loc3_.x = _loc2_.x + _loc2_.width + this.H_SPACE_MARK;
        addChild(_loc3_);
        var _loc4_:Array = RELATION_LIST[param1 - 2];
        var _loc6_:int = 0;
        while (_loc6_ < _loc4_.length) {
            _loc3_ = new PetTypeIcon();
            _loc3_.type = _loc4_[_loc4_.length - _loc6_ - 1];
            if (_loc6_ == 0) {
                _loc3_.x = _loc2_.x - this.H_SPACE_MARK - _loc3_.width;
                _loc5_ = _loc3_.x;
            } else {
                _loc3_.x = _loc5_ - this.H_SPACE_ICON - _loc3_.width;
                _loc5_ = _loc3_.x;
            }
            _loc3_.y = 366.45;
            addChild(_loc3_);
            _loc6_++;
        }
    }

    public function dispose():void {
        while (this.numChildren > 0) {
            this.removeChildAt(0);
        }
    }
}
}
