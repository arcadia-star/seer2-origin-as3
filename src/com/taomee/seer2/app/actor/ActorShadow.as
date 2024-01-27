package com.taomee.seer2.app.actor {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.core.animation.FramePlayer;
import com.taomee.seer2.core.animation.frame.FrameSequenceManager;
import com.taomee.seer2.core.entity.AnimateElement;

public class ActorShadow extends AnimateElement {


    private var _player:FramePlayer;

    public function ActorShadow() {
        super();
        this.init();
    }

    private function init():void {
        this._player = new FramePlayer();
        this._player.frameSequence = FrameSequenceManager.getFrameSequence("UI_ActorShadow", null, true);
        this.animation = this._player;
    }

    public function updateLabel(param1:UserInfo):void {
        if (param1.vipInfo.isVip()) {
            this.animation.gotoLabel("vip");
        } else if (param1.isRemote()) {
            this.animation.gotoAndStop(2);
        } else {
            this.animation.gotoAndStop(1);
        }
    }

    public function set isStop(param1:Boolean):void {
        if (param1) {
            this.animation.stop();
        } else {
            this.animation.play();
        }
    }
}
}
