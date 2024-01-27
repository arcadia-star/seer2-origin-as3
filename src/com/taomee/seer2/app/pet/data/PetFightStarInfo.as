package com.taomee.seer2.app.pet.data {
import com.taomee.seer2.app.starMagic.StarInfo;

public class PetFightStarInfo {


    public var type:Array;

    public var level:Array;

    public function PetFightStarInfo() {
        super();
        this.type = new Array();
        this.level = new Array();
    }

    public function clear():void {
        while (this.type.length) {
            this.type.pop();
        }
        while (this.level.length) {
            this.level.pop();
        }
    }

    public function addAll(param1:Vector.<StarInfo>):void {
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            this.add(param1[_loc2_].level, param1[_loc2_].type);
            _loc2_++;
        }
    }

    public function add(param1:int, param2:int):void {
        this.type.push(param2);
        this.level.push(param1);
    }
}
}
