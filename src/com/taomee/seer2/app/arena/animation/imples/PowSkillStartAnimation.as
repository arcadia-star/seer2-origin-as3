package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.animation.event.ArenaAnimationEvent;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class PowSkillStartAnimation extends BaseAnimation {

    private static const RESOURCE_NAME:String = "UI_PowerSkillStart";


    private var _animationSkillStart:MovieClip;

    private var _moviePlayer:FighterMoviePlayer;

    private var _side:uint = 0;

    public function PowSkillStartAnimation() {
        super();
        this.initialize();
    }

    override public function initData(param1:Object):void {
        this._side = param1["side"];
    }

    override public function initialize():void {
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }

    override public function play():void {
        if (this._animationSkillStart == null) {
            this._animationSkillStart = FightAnimationResourcePool.checkOutMC(RESOURCE_NAME);
        }
        addChild(this._animationSkillStart);
        if (this._side == FightSide.RIGHT) {
            this._animationSkillStart.scaleX = -1;
        }
        this._moviePlayer = new FighterMoviePlayer(this._animationSkillStart, this.onAnimationEnd, ClientConfig.timeRate);
    }

    override public function dispose():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
        if (this._animationSkillStart != null) {
            this._animationSkillStart.scaleX = 1;
            DisplayUtil.removeForParent(this._animationSkillStart);
            FightAnimationResourcePool.checkInMC(RESOURCE_NAME, this._animationSkillStart);
            this._animationSkillStart = null;
        }
        super.dispose();
    }

    private function onAnimationEnd():void {
        dispatchEvent(new ArenaAnimationEvent(ArenaAnimationEvent.EVT_END));
    }
}
}
