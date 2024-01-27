package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class CatchHintAnimation extends BaseAnimation {


    private var _mc:MovieClip;

    private var _moviePlayer:FighterMoviePlayer;

    public function CatchHintAnimation() {
        super();
        this.initialize();
    }

    override public function initialize():void {
        DisplayObjectUtil.disableSprite(this);
        this._mc = FightUIManager.getMovieClip("UI_FightCatchHint");
        this._mc.y = 128;
        this._mc.gotoAndStop(1);
        addChild(this._mc);
    }

    override public function play():void {
        this._moviePlayer = new FighterMoviePlayer(this._mc, this.onAnimationEnd, ClientConfig.timeRate);
    }

    private function onAnimationEnd():void {
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }

    override public function dispose():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
        if (this._mc != null) {
            DisplayObjectUtil.removeFromParent(this._mc);
            this._mc = null;
        }
        super.dispose();
    }
}
}
