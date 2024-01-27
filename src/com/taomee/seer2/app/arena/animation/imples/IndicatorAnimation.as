package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class IndicatorAnimation extends BaseAnimation {

    private static const RESOURCE_NAME:String = "UI_Indicator";


    private var _animationIndicator:MovieClip;

    private var _moviePlayer:FighterMoviePlayer;

    public function IndicatorAnimation() {
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }

    override public function play():void {
        if (this._animationIndicator == null) {
            this._animationIndicator = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
        }
        addChild(this._animationIndicator);
        this._moviePlayer = new FighterMoviePlayer(this._animationIndicator, null, ClientConfig.timeRate, Number.MAX_VALUE);
    }

    public function stopPlay():void {
        DisplayObjectUtil.removeFromParent(this._animationIndicator);
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }

    override public function dispose():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
        if (this._animationIndicator != null) {
            this._animationIndicator.gotoAndStop(this._animationIndicator.totalFrames);
            DisplayObjectUtil.removeFromParent(this._animationIndicator);
            FightAnimationResourcePool.checkInMC(RESOURCE_NAME, this._animationIndicator);
            this._animationIndicator = null;
        }
        super.dispose();
    }
}
}
