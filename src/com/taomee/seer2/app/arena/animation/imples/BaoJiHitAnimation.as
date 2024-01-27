package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class BaoJiHitAnimation extends BaseAnimation {

    private static const RESOURCE_NAME:String = "UI_BaoJiSkillHit";


    private var _animationBaojiHit:MovieClip;

    private var _moviePlayer:FighterMoviePlayer;

    public function BaoJiHitAnimation() {
        super();
        this.initialize();
    }

    override public function initialize():void {
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }

    override public function play():void {
        if (this._animationBaojiHit == null) {
            this._animationBaojiHit = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
        }
        addChild(this._animationBaojiHit);
        this._moviePlayer = new FighterMoviePlayer(this._animationBaojiHit, this.onAnimationEnd, ClientConfig.timeRate);
    }

    private function onAnimationEnd():void {
        DisplayObjectUtil.removeFromParent(this._animationBaojiHit);
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }

    override public function dispose():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
        if (this._animationBaojiHit != null) {
            FightAnimationResourcePool.checkInMC(RESOURCE_NAME, this._animationBaojiHit);
            this._animationBaojiHit = null;
        }
        super.dispose();
    }
}
}
