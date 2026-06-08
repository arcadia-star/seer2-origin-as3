package com.taomee.seer2.app.arena.data {
import com.taomee.seer2.app.arena.util.FighterActionType;
import com.taomee.seer2.core.config.ClientConfig;

public class AnimiationHitInfo {


    public var id:uint;

    public var physics:uint;

    public var attribute:uint;

    public var special:uint;

    public var critical:uint;

    public var fit:uint;

    public var physicsArray:Array;

    public var attributeArray:Array;

    public var specialArray:Array;

    public var criticalArray:Array;

    public var fitArray:Array;

    public var hasArray:Boolean;

    public function AnimiationHitInfo() {
        super();
    }

    public function getHitValue(param1:String):int {
        var _loc2_:int = 0;
        switch (param1) {
            case FighterActionType.ATK_PHY:
                _loc2_ = this.physics;
                break;
            case FighterActionType.ATK_BUF:
                _loc2_ = this.attribute;
                break;
            case FighterActionType.ATK_SPE:
                _loc2_ = this.special;
                break;
            case FighterActionType.ATK_POW:
                _loc2_ = this.critical;
                break;
            case FighterActionType.INTERCOURSE:
                _loc2_ = this.fit;
        }
        _loc2_ /= 1.07;//帧率降低过一次，但是xml中数据还是按原来的配置的，先在这里/1.07过度一下，后面找办法改
        return _loc2_;
    }

    public function getHitArray(param1:String):Array {
        var _loc2_:Array;
        if (!hasArray) {
            var hit:int = getHitValue(param1);
            hit = hit == 0 ? 1 : hit;
            return [hit];
        }//不是所有精灵都配置了array
        switch (param1) {
            case FighterActionType.ATK_PHY:
                _loc2_ = this.physicsArray;
                break;
            case FighterActionType.ATK_BUF:
                _loc2_ = this.attributeArray;
                break;
            case FighterActionType.ATK_SPE:
                _loc2_ = this.specialArray;
                break;
            case FighterActionType.ATK_POW:
                _loc2_ = this.criticalArray;
                break;
            case FighterActionType.INTERCOURSE:
                _loc2_ = this.fitArray;
        }
        return _loc2_;
    }
}
}
