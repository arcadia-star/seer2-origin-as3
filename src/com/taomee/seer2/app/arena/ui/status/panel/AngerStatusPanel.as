package com.taomee.seer2.app.arena.ui.status.panel {
import com.greensock.TweenLite;
import com.greensock.easing.Strong;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class AngerStatusPanel extends Sprite {

    private static const LEFT_RESOURCE_NAME:String = "UI_FightAngerLeft";

    private static const RIGHT_RESOURCE_NAME:String = "UI_FightAngerRight";

    private static const WIDTH:int = 292;


    private var _side:uint;

    private var _bubble:MovieClip;

    private var _prevAnger:int;

    private var _fight:Fighter;

    private var _setTimeout:uint;

    public function AngerStatusPanel(param1:uint) {
        super();
        this._side = param1;
    }

    public function setFight(param1:Fighter):void {
        this._fight = param1;
        this._prevAnger = param1.fighterInfo.fightAnger;
    }

    public function update():void {
        var _loc1_:String = null;
        var _loc2_:int = 0;
        if (this._fight.fighterInfo.fightAnger == this._prevAnger) {
            return;
        }
        if (this._fight.fighterInfo.fightAnger > this._prevAnger) {
            _loc1_ = LEFT_RESOURCE_NAME;
            _loc2_ = this._fight.fighterInfo.fightAnger - this._prevAnger;
        } else if (this._fight.fighterInfo.fightAnger < this._prevAnger) {
            _loc1_ = RIGHT_RESOURCE_NAME;
            _loc2_ = this._prevAnger - this._fight.fighterInfo.fightAnger;
        }
        this.dispose();
        this._bubble = FightAnimationResourcePool.checkOutMC(_loc1_);
        addChild(this._bubble);
        this._bubble.x = this._side == FightSide.LEFT ? 335 : 755;
        this._bubble.y = 125;
        this._bubble["num0"].gotoAndStop(uint(_loc2_ / 10) + 1);
        this._bubble["num1"].gotoAndStop(_loc2_ % 10 + 1);
        this.emerge();
        this._prevAnger = this._fight.fighterInfo.fightAnger;
    }

    private function emerge():void {
        var _loc1_:int = 58;
        TweenLite.to(this._bubble, 0.3, {
            "y": _loc1_,
            "ease": Strong.easeIn,
            "onComplete": this.onEmerge
        });
    }

    private function onEmerge():void {
        this._setTimeout = setTimeout(this.shrink, 1500);
    }

    private function shrink():void {
        this.dispose();
    }

    public function dispose():void {
        TweenLite.killTweensOf(this._bubble);
        clearTimeout(this._setTimeout);
        DisplayObjectUtil.removeFromParent(this._bubble);
        this._bubble = null;
    }
}
}
