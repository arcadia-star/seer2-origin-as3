package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class FightCountDownAnimation extends BaseAnimation {

    private static const RESOURCE_NAME:String = "UI_FightCountDown";


    private var _animation:MovieClip;

    private var _moviePlayer:FighterMoviePlayer;

    public function FightCountDownAnimation() {
        super();
        this.initialize();
    }

    override public function initialize():void {
        DisplayObjectUtil.disableSprite(this);
        if (this._animation == null) {
            if (ArenaUIIsNew.isNewUI) {
                this._animation = FightAnimationResourcePool.checkOutMC("New_UI_FightCountDown");
            } else {
                this._animation = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
            }
        }
        this._animation.x = 591;
        this._animation.y = 291;
        this._animation.gotoAndStop(1);
        addChild(this._animation);
    }

    override public function play():void {
        this._moviePlayer = new FighterMoviePlayer(this._animation, this.onAnimationEnd, ClientConfig.timeRate);
    }

    override public function dispose():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
        if (this._animation != null) {
            this._animation.gotoAndStop(this._animation.totalFrames);
            DisplayObjectUtil.removeFromParent(this._animation);
            if (ArenaUIIsNew.isNewUI) {
                FightAnimationResourcePool.checkInMC("New_UI_FightCountDown", this._animation);
            } else {
                FightAnimationResourcePool.checkInMC(RESOURCE_NAME, this._animation);
            }
            this._animation = null;
        }
        super.dispose();
    }

    private function onAnimationEnd():void {
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }
}
}
