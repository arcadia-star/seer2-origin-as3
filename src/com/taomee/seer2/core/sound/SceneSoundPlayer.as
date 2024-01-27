package com.taomee.seer2.core.sound {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import org.taomee.utils.Tick;

public class SceneSoundPlayer {


    private var MAX_VOLUME:Number = 0.4;

    private var CHANGE_VOLUME:Number = 0.04;

    private var _sound:Sound;

    private var _chanel:SoundChannel;

    private var _oldChanel:SoundChannel;

    private var _oldTransform:SoundTransform;

    private var _transform:SoundTransform;

    private var _hasLoaded:Boolean = false;

    private var _list:Vector.<SoundInfo>;

    private var _invID:uint;

    private var _invID1:uint;

    private var _playIndex:int;

    private var _info:SoundInfo;

    private var _enabled:Boolean;

    private var _url:String;

    private var hasReplay:Boolean;

    public function SceneSoundPlayer() {
        super();
        this._transform = new SoundTransform();
        this._oldTransform = new SoundTransform();
        this._list = new Vector.<SoundInfo>();
    }

    public function play():void {
        if (this._list.length == 0) {
            return;
        }
        this._info = this._list[this._playIndex];
        this.hasReplay = false;
        if (this._url != this._info.url) {
            this._sound = new Sound();
            this._url = this._info.url;
            this._sound.addEventListener(Event.COMPLETE, this.getOutTime);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR, this.stopLoad);
            this._sound.load(new URLRequest(this._info.url));
            if (Tick.instance.hasRender(this.addVolume)) {
                Tick.instance.removeRender(this.addVolume);
            }
            this.stop();
            this.fadeIn();
        } else if (this._info.repInterval > 1) {
            this.fadeIn();
            this.getOutTime(null);
        } else {
            this.hasReplay = true;
            this.rePlay();
        }
    }

    protected function stopLoad(param1:IOErrorEvent):void {
        this._sound.removeEventListener(Event.COMPLETE, this.getOutTime);
        this._sound.removeEventListener(IOErrorEvent.IO_ERROR, this.stopLoad);
    }

    protected function getOutTime(param1:Event):void {
        var _loc2_:int = 0;
        this._sound.removeEventListener(Event.COMPLETE, this.getOutTime);
        this._sound.removeEventListener(IOErrorEvent.IO_ERROR, this.stopLoad);
        if (this._info.repInterval > 1) {
            if (!this._chanel) {
                return;
            }
            _loc2_ = this._sound.length - this._chanel.position - 3000;
            if (_loc2_ > 0) {
                this._invID1 = setTimeout(this.setNewIndex, _loc2_);
            }
        } else {
            this.hasReplay = true;
        }
    }

    private function setNewIndex():void {
        this.stop();
        if (this._playIndex >= this._list.length - 1) {
            this._playIndex = 0;
        } else {
            ++this._playIndex;
        }
        if (this._info.repInterval > 1) {
            this._chanel = null;
            this._invID = setTimeout(this.onInvFunc, this._info.repInterval);
        } else {
            this.onInvFunc();
        }
    }

    private function rePlay():void {
        if (this._chanel) {
            this._chanel.removeEventListener(Event.SOUND_COMPLETE, this.onPlayComplete);
            this._chanel.stop();
        }
        this._transform.volume = this.MAX_VOLUME;
        this.getChannel();
    }

    private function fadeIn():void {
        this._transform.volume = 0;
        this.getChannel();
        Tick.instance.addRender(this.addVolume, 300);
    }

    private function getChannel():void {
        if (!this._sound) {
            return;
        }
        this._chanel = this._sound.play(0, 1);
        if (!this._chanel) {
            return;
        }
        this._chanel.addEventListener(Event.SOUND_COMPLETE, this.onPlayComplete);
        this._chanel.soundTransform = this._transform;
    }

    private function onPlayComplete(param1:Event):void {
        if (this._chanel) {
            this._chanel.removeEventListener(Event.SOUND_COMPLETE, this.onPlayComplete);
        }
        if (this.hasReplay) {
            this.rePlay();
        }
    }

    private function addVolume(param1:int):void {
        this._transform.volume += this.CHANGE_VOLUME;
        if (this._transform.volume >= this.MAX_VOLUME) {
            Tick.instance.removeRender(this.addVolume);
        }
        if (!this._chanel) {
            Tick.instance.removeRender(this.addVolume);
            return;
        }
        this._chanel.soundTransform = this._transform;
    }

    public function stop():void {
        if (this._invID1 != 0) {
            clearTimeout(this._invID1);
        }
        if (this._chanel) {
            if (this._oldChanel) {
                Tick.instance.removeRender(this.fadeOut);
                this._oldChanel.stop();
                this._oldChanel.removeEventListener(Event.SOUND_COMPLETE, this.onPlayComplete);
                this._oldChanel = null;
            }
            this._oldChanel = this._chanel;
            this._oldTransform.volume = this._transform.volume;
            this._chanel = null;
            Tick.instance.addRender(this.fadeOut, 300);
        }
    }

    private function fadeOut(param1:int):void {
        if (!this._oldChanel) {
            Tick.instance.removeRender(this.fadeOut);
            return;
        }
        this._oldTransform.volume -= this.CHANGE_VOLUME;
        this._oldChanel.soundTransform = this._oldTransform;
        if (this._oldTransform.volume <= 0) {
            Tick.instance.removeRender(this.fadeOut);
            this._oldChanel.stop();
            this._oldChanel.removeEventListener(Event.SOUND_COMPLETE, this.onPlayComplete);
            this._oldChanel = null;
        }
    }

    public function clear():void {
        if (this._invID != 0) {
            clearTimeout(this._invID);
        }
        if (this._invID1 != 0) {
            clearTimeout(this._invID1);
        }
        this._list.length = 0;
        this._playIndex = 0;
        this.hasReplay = false;
    }

    public function hasURL(param1:String):Boolean {
        var _loc2_:SoundInfo = null;
        for each(_loc2_ in this._list) {
            if (_loc2_.url == param1) {
                return true;
            }
        }
        return false;
    }

    public function addPlay(param1:String, param2:Number):void {
        var _loc3_:SoundInfo = new SoundInfo();
        _loc3_.url = param1;
        _loc3_.repInterval = param2;
        this._list.push(_loc3_);
    }

    private function onInvFunc():void {
        clearTimeout(this._invID);
        this.play();
    }

    public function upDateRepInterval(param1:String, param2:Number):void {
        var _loc3_:SoundInfo = null;
        for each(_loc3_ in this._list) {
            if (_loc3_.url == param1) {
                _loc3_.repInterval = param2;
            }
        }
    }

    public function set enabled(param1:Boolean):void {
        this._enabled = param1;
        if (this._enabled) {
            this.play();
        } else {
            this.stop();
        }
    }
}
}

class SoundInfo {


    public var url:String;

    public var repInterval:Number;

    public function SoundInfo() {
        super();
    }
}
