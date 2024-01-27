package com.taomee.seer2.app.processor.activity.frozen {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.RemoteActor;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;

public class FrozenActor {


    public var actor:RemoteActor;

    public var thisActor:Actor;

    public var hp:uint;

    public var status:Boolean;

    private var _frozen:MovieClip;

    private var _fun:Function;

    private var _timer:Timer;

    private var _blood:MovieClip;

    private var _bloodList:Vector.<MovieClip>;

    public function FrozenActor() {
        this._bloodList = Vector.<MovieClip>([]);
        super();
    }

    public function startTimer(param1:Function = null, param2:Boolean = false):void {
        var fun:Function = param1;
        var isThis:Boolean = param2;
        this._fun = fun;
        FrozenStatus.getSwfContent(function ():void {
            _frozen = FrozenStatus.getFrozen();
            if (isThis) {
                thisActor.addChild(_frozen);
            } else {
                actor.addChild(_frozen);
            }
            _frozen.x = -75;
            _frozen.y = -120;
        });
        this._timer = new Timer(1000, 4);
        this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        this._timer.start();
    }

    private function onTimerComplete(param1:TimerEvent):void {
        this._timer.stop();
        this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        this.status = true;
        DisplayUtil.removeForParent(this._frozen);
        if (this._fun != null) {
            this._fun();
        }
        this._fun = null;
    }

    public function setThisHp(param1:uint):void {
        var vhp:uint = param1;
        this.hp = vhp;
        if (this._blood == null) {
            FrozenStatus.getSwfContent(function ():void {
                _blood = FrozenStatus.getBlood();
                LayerManager.uiLayer.addChild(_blood);
                _bloodList.push(_blood);
                _blood.x = ActorManager.getActor().x - 65;
                _blood.y = ActorManager.getActor().y - 100;
                if (hp != 0) {
                    _blood.gotoAndStop(hp);
                }
                if (_bloodList.length > 1) {
                    DisplayUtil.removeForParent(_bloodList[0]);
                    _bloodList = Vector.<MovieClip>([]);
                }
            });
            return;
        }
        if (this.hp != 0) {
            this._blood.gotoAndStop(this.hp);
        }
        if (this._bloodList.length > 1) {
            DisplayUtil.removeForParent(this._bloodList[0]);
            this._bloodList = Vector.<MovieClip>([]);
        }
    }

    public function setHp(param1:uint):void {
        this.hp = param1;
    }

    public function removeTimer():void {
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        }
        DisplayUtil.removeForParent(this._frozen);
        this._timer = null;
        this._fun = null;
    }

    public function getBlood():MovieClip {
        return this._blood;
    }

    public function removeHp():void {
        DisplayUtil.removeForParent(this._blood);
        this._blood = null;
    }

    public function releaseUser():void {
        this.removeTimer();
        this.status = true;
    }
}
}
