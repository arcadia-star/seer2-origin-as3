package com.taomee.seer2.app.arena {
import com.taomee.seer2.app.arena.data.AnimiationHitInfo;
import com.taomee.seer2.app.arena.util.FighterActionType;
import com.taomee.seer2.app.arena.util.HitInfoConfig;
import com.taomee.seer2.core.animation.IAnimation;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.player.FighterMoviePlayer;

import flash.display.FrameLabel;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.DataEvent;
import flash.events.Event;
import flash.utils.setTimeout;

import seer2.next.play.HitData;
import seer2.next.play.HitEvent;

public class FighterAnimation extends Sprite implements IAnimation {

    public static const EVT_END:String = "end";

    public static const EVT_HIT:String = "fighterHit";

    private static const MODE_STOP_IDLE:String = "stopIdle";

    private static const MODE_STOP_LAST_FRAME:String = "stopLastFrame";

    private static const MODE_REPLAY:String = "replay";

    private static const MODE_BLANK:String = "blank";


    private var _mc:MovieClip;

    private var _actionAnimation:MovieClip;

    private var _currentLabel:String;

    private var _mode:String;

    private var _fighterResourceId:uint;

    private var _moviePlayer:FighterMoviePlayer;

    public function FighterAnimation() {
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }

    public function setup(param1:MovieClip, param2:uint):void {
        this._fighterResourceId = param2;
        if (param1 != null) {
            this._mc = param1;
            addChild(this._mc);
            return;
        }
        throw new Error("没有战斗精灵的素材资源！[" + this._fighterResourceId + "]");
    }

    public function get totalFrameNum():uint {
        return this._mc.totalFrames;
    }

    public function get currentFrameIndex():uint {
        return this._mc.currentFrame;
    }

    public function get currentFrameLabel():String {
        return this._mc.currentFrameLabel;
    }

    public function play():void {
        this._mc.play();
    }

    public function stop():void {
        this._mc.stop();
    }

    public function gotoAndPlay(param1:uint):void {
        this._mc.gotoAndPlay(param1);
    }

    public function gotoAndStop(param1:uint):void {
        this._mc.gotoAndStop(param1);
    }

    public function hasLabel(param1:String):Boolean {
        var _loc5_:FrameLabel = null;
        var _loc2_:Array = this._mc.currentLabels;
        var _loc3_:int = int(_loc2_.length);
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if ((_loc5_ = _loc2_[_loc4_] as FrameLabel).name == param1) {
                return true;
            }
            _loc4_++;
        }
        return false;
    }

    private function adjustCurrentLabel(param1:String):String {
        if (param1 == FighterActionType.ABOUT_TO_DIE && this.hasLabel(FighterActionType.ABOUT_TO_DIE) == false) {
            return FighterActionType.DEAD;
        }
        if (param1 == FighterActionType.PRESENT && this.hasLabel(FighterActionType.PRESENT) == false) {
            return FighterActionType.IDLE;
        }
        return param1;
    }

    private function calculateMode(param1:String):String {
        var _loc2_:String = MODE_BLANK;
        switch (param1) {
            case FighterActionType.IDLE:
                _loc2_ = MODE_REPLAY;
                break;
            case FighterActionType.ATK_BUF:
            case FighterActionType.ATK_PHY:
            case FighterActionType.ATK_POW:
            case FighterActionType.INTERCOURSE:
            case FighterActionType.ATK_SPE:
            case FighterActionType.MISS:
            case FighterActionType.UNDER_ATK:
            case FighterActionType.PRESENT:
            case FighterActionType.CHANGE_STATUS:
                _loc2_ = MODE_STOP_IDLE;
                break;
            case FighterActionType.ABOUT_TO_DIE:
            case FighterActionType.DEAD:
            case FighterActionType.WIN:
                _loc2_ = MODE_STOP_LAST_FRAME;
        }
        return _loc2_;
    }

    public function gotoLabel(param1:String):void {
        this.removeActionPlayEventListener();
        this._currentLabel = this.adjustCurrentLabel(param1);
        this._mode = this.calculateMode(this._currentLabel);
        if (this._mode != MODE_BLANK) {
            this._mc.addEventListener(Event.FRAME_CONSTRUCTED, this.onFrameConstructed);
        }
        this._mc.gotoAndStop(this._currentLabel);
    }

    private function onFrameConstructed(param1:Event):void {
        var onActionPlay:Function = null;
        var dispatchHitEvent:Function = null;
        var hitInfo:AnimiationHitInfo = null;
        var time:Number = NaN;
        var evt:Event = param1;
        onActionPlay = function ():void {
            removeActionPlayEventListener();
            doActionEnd();
        };
        dispatchHitEvent = function (hitData:HitData = null):void {
            dispatchEvent(new HitEvent(EVT_HIT, hitData ? hitData : HitData.default1()));
        };
        if (this._mc != null && this._mc.numChildren > 0) {
            this._mc.removeEventListener(Event.FRAME_CONSTRUCTED, this.onFrameConstructed);
            this._actionAnimation = this._mc.getChildAt(0) as MovieClip;
            if (this._currentLabel == FighterActionType.ATK_PHY || this._currentLabel == FighterActionType.ATK_BUF || this._currentLabel == FighterActionType.ATK_SPE || this._currentLabel == FighterActionType.ATK_POW || this._currentLabel == FighterActionType.INTERCOURSE) {
                hitInfo = HitInfoConfig.getHitData(this._fighterResourceId);
                time = hitInfo.getHitValue(this._currentLabel);
                if (time > 0) {//帧数表大于0的使用帧数表配置
                    setTimeout(dispatchHitEvent, time * 1000);
                } else {//否则使用事件触发
                    var _mc:MovieClip = this._mc;
                    const onMcHit:Function = function (event:Event):void {
                        if (event instanceof DataEvent) {//连击事件
                            var hitData:HitData = HitData.from(event as DataEvent);
                            if (hitData.last()) {
                                _mc.removeEventListener("hit", onMcHit);
                            }
                            dispatchHitEvent(hitData);
                        } else {//普通事件
                            _mc.removeEventListener("hit", onMcHit);
                            dispatchHitEvent();
                        }
                    }
                    _mc.addEventListener("hit", onMcHit)
                }
            }
            this.playAnimation(onActionPlay);
        }
    }

    private function playAnimation(param1:Function = null):void {
        this._moviePlayer = new FighterMoviePlayer(this._actionAnimation, param1, ClientConfig.timeRate);
    }

    private function removeActionPlayEventListener():void {
        if (this._moviePlayer != null) {
            this._moviePlayer.destroy();
            this._moviePlayer = null;
        }
    }

    private function doActionEnd():void {
        if (this._mode == MODE_STOP_IDLE) {
            this.gotoLabel(FighterActionType.IDLE);
        } else if (this._mode == MODE_STOP_LAST_FRAME) {
            this._actionAnimation.stop();
        } else if (this._mode == MODE_REPLAY) {
            this.playAnimation(this.onReplayComplete);
        }
        this.dispathchActionEndEvent(EVT_END);
    }

    private function onReplayComplete():void {
        this.removeActionPlayEventListener();
        this.playAnimation(this.onReplayComplete);
    }

    private function dispathchActionEndEvent(param1:String):void {
        if (this.hasEventListener(param1)) {
            dispatchEvent(new Event(param1));
        }
    }

    public function isStopAllAnimation(param1:Boolean):void {
    }

    public function update():void {
    }

    public function dispose():void {
        this.removeActionPlayEventListener();
        this._actionAnimation = null;
        if (this._mc != null) {
            try {
                this._mc.gotoAndStop(FighterActionType.BLANK);
            } catch (e:*) {
            }
            removeChild(this._mc);
        }
        this._mc = null;
    }
}
}
