package com.taomee.seer2.app.arena.ui.status {
import com.greensock.TweenLite;
import com.greensock.easing.Strong;
import com.taomee.seer2.app.arena.resource.FightAnimationResourcePool;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.utils.setTimeout;

public class SkillBubble extends Sprite {

    private static const LEFT_RESOURCE_NAME:String = "UI_FightSkillLeftBubble";

    private static const RIGHT_RESOURCE_NAME:String = "UI_FightSkillRightBubble";

    private static const WIDTH:int = 292;


    private var _side:uint;

    private var _bubble:MovieClip;

    private var _skillNameTxt:TextField;

    private var _bubbleContent:String;

    public function SkillBubble(param1:uint) {
        super();
        this._side = param1;
        DisplayObjectUtil.disableSprite(this);
        var _loc2_:String = this._side == FightSide.LEFT ? LEFT_RESOURCE_NAME : RIGHT_RESOURCE_NAME;
        this._bubble = FightAnimationResourcePool.checkOutMC(_loc2_);
        this._skillNameTxt = this._bubble["skillNameTxt"];
        addChild(this._bubble);
        this.alpha = 0;
        this.x = this._side == FightSide.LEFT ? 292 : 909;
        this.y = 125;
    }

    public function setSkillName(param1:String):void {
        this._bubbleContent = param1;
        this._skillNameTxt.text = this._bubbleContent;
        this.emerge();
    }

    private function emerge():void {
        this.visible = true;
        TweenLite.to(this, 0.5, {
            "alpha": 1,
            "ease": Strong.easeIn,
            "onComplete": this.onEmerge
        });
    }

    private function onEmerge():void {
        this._skillNameTxt.text = this._bubbleContent;
        setTimeout(this.shrink, 2000);
    }

    private function shrink():void {
        TweenLite.to(this, 0.5, {
            "alpha": 0,
            "ease": Strong.easeIn,
            "onComplete": this.onComplete
        });
    }

    private function onComplete():void {
        if (this) {
            this.visible = false;
        }
    }

    public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._bubble);
        var _loc1_:String = this._side == FightSide.LEFT ? LEFT_RESOURCE_NAME : RIGHT_RESOURCE_NAME;
        FightAnimationResourcePool.checkInMC(_loc1_, this._bubble);
        this._bubble = null;
        this._skillNameTxt.text = "";
        this._skillNameTxt = null;
        TweenLite.killTweensOf(this);
    }
}
}
