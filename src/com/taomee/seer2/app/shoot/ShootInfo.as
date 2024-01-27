package com.taomee.seer2.app.shoot {
import flash.geom.Point;

public class ShootInfo {


    public var id:int;

    public var type:String;

    public var name:String;

    public var stateType:int;

    public var lastTime:int;

    public var isOverlap:Boolean;

    public var speed:Number;

    public var soundId:int;

    public var userID:int;

    public var startPos:Point;

    public var endPos:Point;

    public function ShootInfo() {
        super();
    }

    public function clone():ShootInfo {
        var _loc1_:ShootInfo = new ShootInfo();
        _loc1_.id = this.id;
        _loc1_.type = this.type;
        _loc1_.name = this.name;
        _loc1_.stateType = this.stateType;
        _loc1_.lastTime = this.lastTime;
        _loc1_.isOverlap = this.isOverlap;
        _loc1_.speed = this.speed;
        _loc1_.soundId = this.soundId;
        return _loc1_;
    }
}
}
