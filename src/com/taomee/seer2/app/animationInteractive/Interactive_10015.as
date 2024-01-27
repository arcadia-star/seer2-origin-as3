package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;

public class Interactive_10015 extends BaseAniamationInteractive {


    private var _no:MovieClip;

    private var _npc:MovieClip;

    private var _bag:MovieClip;

    private var _restBtn:SimpleButton;

    private var _mcVec:Vector.<MovieClip>;

    public function Interactive_10015() {
        super();
    }

    override protected function paramAnimation():void {
        this._no = _animation["no"];
        this._npc = _animation["npc"];
        this._bag = _animation["bag"];
        this._restBtn = _animation["restBtn"];
        this._mcVec = Vector.<MovieClip>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._mcVec.push(_animation["mc" + _loc1_]);
            _loc1_++;
        }
        this._no.visible = false;
        _closeBtn.visible = false;
        this._restBtn.visible = false;
        this.playMC();
    }

    private function playMC():void {
        MovieClipUtil.playMc(this._npc, 2, 110);
        MovieClipUtil.playMc(this._bag, 2, 45, function ():void {
            SoundManager.play(URLUtil.getQuestSound("移动"), 1);
            MovieClipUtil.playMc(_bag, 46, 92, function ():void {
                SoundManager.stop(URLUtil.getQuestSound("移动"));
                _npc.gotoAndPlay(111);
                openBtn(true);
                initEvent();
            }, true);
        }, true);
    }

    private function openBtn(param1:Boolean):void {
        _closeBtn.visible = param1;
        this._restBtn.visible = param1;
    }

    private function initEvent():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._mcVec) {
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._restBtn.addEventListener(MouseEvent.CLICK, this.onRest);
    }

    private function removeEvent():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._mcVec) {
            _loc1_.buttonMode = false;
            _loc1_.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._restBtn.removeEventListener(MouseEvent.CLICK, this.onRest);
    }

    private function onRest(param1:MouseEvent):void {
        this.openBtn(false);
        this.removeEvent();
        this.playMC();
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        var _loc3_:int = this._mcVec.indexOf(_loc2_);
        if (_loc3_ == 1) {
            this.win();
        } else {
            this.noWin(_loc2_);
        }
    }

    private function noWin(param1:MovieClip):void {
        var mc:MovieClip = param1;
        this.removeEvent();
        this.openBtn(false);
        MovieClipUtil.playMc(this._npc, 221, 330);
        this._no.visible = true;
        this._no.x = mc.x;
        this._no.y = mc.y;
        MovieClipUtil.playMc(this._no, 2, this._no.totalFrames, function ():void {
            _no.visible = false;
        });
        SoundManager.play(URLUtil.getQuestSound("错误"), 1);
        MovieClipUtil.playMc(this._bag, 153, this._bag.totalFrames, function ():void {
            SoundManager.stop(URLUtil.getQuestSound("错误"));
            openBtn(true);
            _restBtn.addEventListener(MouseEvent.CLICK, onRest);
        }, true);
    }

    private function win():void {
        this.removeEvent();
        this.openBtn(false);
        SoundManager.play(URLUtil.getQuestSound("正确"), 1);
        MovieClipUtil.playMc(this._bag, 93, 152, function ():void {
            SoundManager.stop(URLUtil.getQuestSound("正确"));
            dispatchEvent(new Event(AnimationEvent.STONE));
            dispose();
        }, true);
    }

    override public function dispose():void {
        this.removeEvent();
        this._mcVec = Vector.<MovieClip>([]);
        this._no = null;
        this._npc = null;
        this._bag = null;
        this._restBtn = null;
        super.dispose();
    }
}
}
