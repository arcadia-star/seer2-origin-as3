package com.taomee.seer2.app.arena.effect {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.utils.URLUtil;

import flash.media.Sound;
import flash.media.SoundChannel;

public class FighterSound {


    private var _soundId:uint;

    private var _sound:Sound;

    private var _soundChannel:SoundChannel;

    public function FighterSound(param1:uint) {
        super();
        this._soundId = param1;
    }

    public function getSoundUrl():String {
        return URLUtil.getPetSound(this._soundId);
    }

    public function onSoundLoaded(param1:ContentInfo):void {
        this._sound = param1.content as Sound;
    }

    public function playFighterSound():void {
        if (this._sound) {
            this._soundChannel = this._sound.play();
        }
    }

    public function stopFighterSound():void {
        if (Boolean(this._sound) && Boolean(this._soundChannel)) {
            this._soundChannel.stop();
        }
    }
}
}
