package com.taomee.seer2.app.arena.animation.imples {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.app.arena.util.FightSide;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class BuffDisabledAnimation extends BaseAnimation {

    public static const BUFF_ID_LIST:Vector.<int> = Vector.<int>([1, 2, 3, 5, 6, 7, 8, 9, 12]);


    private var _buffTip:MovieClip;

    private var _buffId:int;

    private var _fightSide:int;

    public function BuffDisabledAnimation() {
        super();
    }

    override public function initData(param1:Object):void {
        this._buffId = param1["buffId"];
        this._fightSide = param1["side"];
    }

    override public function play():void {
        this.y = 350;
        this.x = this._fightSide == FightSide.LEFT ? 200 : 760;
        this.createBuffTip();
        this.alpha = 1;
        this.scaleX = this.scaleY = 3;
        var _loc1_:uint = 0.1;
        var _loc2_:uint = 0.1;
        TweenLite.to(this, 3, {
            "y": 180,
            "scaleX": 1.5,
            "scaleY": 1.5,
            "ease": Expo.easeOut,
            "onComplete": this.onAnimateComplete
        });
    }

    private function onAnimateComplete():void {
        TweenLite.to(this, 1, {
            "alpha": 0,
            "ease": Expo.easeOut,
            "onComplete": this.onPlayComplete
        });
    }

    private function onPlayComplete():void {
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }

    override public function dispose():void {
        TweenLite.killTweensOf(this);
        if (this._buffTip != null) {
            FightAnimationResourcePool.checkInMC("UI_BuffTip_" + this._buffId, this._buffTip);
            DisplayUtil.removeForParent(this._buffTip);
            this._buffTip = null;
        }
        super.dispose();
    }

    private function createBuffTip():void {
        var _loc1_:MovieClip = FightAnimationResourcePool.checkOutMC("UI_BuffTip_" + this._buffId);
        addChild(_loc1_);
    }
}
}
