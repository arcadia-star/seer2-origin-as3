package com.taomee.seer2.app.arena.animation.imples {
import com.taomee.seer2.app.arena.animation.core.BaseAnimation;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;

public class FightWaitingAnimation extends BaseAnimation {

    private static const RESOURCE_NAME:String = "UI_FightWaiting";


    private var _waitingSprite:Sprite;

    public function FightWaitingAnimation() {
        super();
        this.initialize();
    }

    override public function initialize():void {
        DisplayObjectUtil.disableSprite(this);
        if (this._waitingSprite == null) {
            this._waitingSprite = FightUIManager.getSprite(RESOURCE_NAME);
        }
    }

    override public function play():void {
        this._waitingSprite.x = 1200 / 2;
        this._waitingSprite.y = 180;
        addChild(this._waitingSprite);
    }

    override public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._waitingSprite);
        this._waitingSprite = null;
        super.dispose();
    }
}
}
