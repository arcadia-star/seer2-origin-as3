package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class PresentAnimation extends BaseAnimation {

    public static const RESOURCE_NAME:String = "UI_FightPresent";

    private static const EVT_PRESENT_FRAME_NUM:uint = 45;


    private var _animation:MovieClip;

    private var _moviePlayer:FighterMoviePlayer;

    private var _timeOutId:uint;

    private var _onFighterPresent:Function;

    public function PresentAnimation() {
        super();
        this.initialize();
    }

    override public function initData(param1:Object):void {
        this._onFighterPresent = param1["onFighterPresentFun"];
    }

    override public function initialize():void {
        if (this._animation == null) {
            this._animation = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
        }
        this._animation.stop();
        addChild(this._animation);
    }

    private function onPresent():void {
        this._timeOutId = 0;
        if (this._onFighterPresent != null) {
            this._onFighterPresent();
            this._onFighterPresent = null;
        }
    }

    private function onAnimationEnd():void {
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }

    override public function play():void {
        this._moviePlayer = new FighterMoviePlayer(this._animation, this.onAnimationEnd, ClientConfig.timeRate);
        this._timeOutId = setTimeout(this.onPresent, EVT_PRESENT_FRAME_NUM / ClientConfig.timeRate * 1000);
    }

    override public function dispose():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
        if (this._timeOutId != 0) {
            clearTimeout(this._timeOutId);
        }
        DisplayObjectUtil.removeFromParent(this._animation);
        FightAnimationResourcePool.checkInMC(RESOURCE_NAME, this._animation);
        this._animation = null;
        this._onFighterPresent = null;
        super.dispose();
    }
}
}
