package com.taomee.seer2.app.arena.effect {
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.skill.PetSkillSettingDefinition;
import com.taomee.seer2.app.pet.data.SkillInfo;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.utils.URLUtil;

import flash.media.Sound;
import flash.media.SoundChannel;

public class SkillSound {


    private var _fighterResourceId:uint;

    private var _info:SkillInfo;

    private var _sound:Sound;

    private var _soundChannel:SoundChannel;

    public function SkillSound(param1:uint, param2:SkillInfo) {
        super();
        this._fighterResourceId = param1;
        this._info = param2;
    }

    public function get skillId():uint {
        return this._info.id;
    }

    public function getSoundUrl():String {
        var _loc1_:PetSkillSettingDefinition = PetConfig.getPetSkillSettingDefinition(this._info.id);
        this._info.soundId = _loc1_.getSoundId(this._fighterResourceId);
        if (this._info.soundId == null || this._info.soundId == "") {
        }
        return URLUtil.getSkillSound(this._info.soundId);
    }

    public function onSoundLoaded(param1:ContentInfo):void {
        this._sound = param1.content as Sound;
    }

    public function play():void {
        if (this._sound) {
            this._soundChannel = this._sound.play();
        }
    }

    public function stop():void {
        if (Boolean(this._sound) && Boolean(this._soundChannel)) {
            this._soundChannel.stop();
        }
    }

    public function dispose():void {
        this._info = null;
        this._sound = null;
        this._soundChannel = null;
        this._fighterResourceId = 0;
    }
}
}
