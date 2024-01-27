package com.taomee.seer2.app.arena.animation.imples {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;

import org.taomee.utils.DisplayUtil;

public class FightMissAnimation extends BaseAnimation {


    private var _missSprite:Sprite;

    private var _side:uint;

    public function FightMissAnimation() {
        super();
        this.initialize();
    }

    override public function initData(param1:Object):void {
        this._side = param1["side"];
    }

    override public function initialize():void {
        DisplayObjectUtil.disableSprite(this);
        if (this._missSprite == null) {
            this._missSprite = FightUIManager.getSprite("UI_FightMiss");
        }
        addChild(this._missSprite);
    }

    override public function play():void {
        if (this._side == FightSide.LEFT) {
            this.x = 250;
            this.y = 200;
        }
        if (this._side == FightSide.RIGHT) {
            this.x = 710;
            this.y = 200;
        }
        var _loc1_:int = 50;
        TweenLite.to(this, 1, {
            "y": _loc1_,
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
        DisplayUtil.removeForParent(this._missSprite);
        this._missSprite = null;
        super.dispose();
    }
}
}
