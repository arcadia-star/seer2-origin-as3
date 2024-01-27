package com.taomee.seer2.core.effects {
import com.taomee.seer2.core.ui.UIManager;

import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

public class SoundEffects {

    private static var _soundTransform:SoundTransform = new SoundTransform(0.6);


    public function SoundEffects() {
        super();
    }

    public static function setButton(param1:InteractiveObject, param2:Boolean = true, param3:Boolean = true):void {
        if (param2) {
        }
        if (param3) {
            param1.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
        }
    }

    private static function onButtonOver(param1:MouseEvent):void {
        playSound("Sound_MouseOver");
    }

    private static function onButtonClick(param1:MouseEvent):void {
        playSound("Sound_MouseClick");
    }

    public static function playSoundMouseClick(param1:Number = 0.6):void {
        playSound("Sound_MouseClick", param1);
    }

    public static function setArrow(param1:InteractiveObject, param2:Boolean = true, param3:Boolean = true):void {
        if (param2) {
        }
        if (param3) {
            param1.addEventListener(MouseEvent.CLICK, onButtonMove, false, 0, true);
        }
    }

    private static function onButtonMove(param1:MouseEvent):void {
        playSound("Sound_Move");
    }

    public static function setMapButton(param1:InteractiveObject):void {
        param1.addEventListener(MouseEvent.CLICK, onButtonMove, false, 0, true);
    }

    private static function onMapButtonOver(param1:MouseEvent):void {
        playSound("Sound_MapOver");
    }

    public static function playSkillReset():void {
        playSound("Sound_SkillReset");
    }

    public static function playBtnClick():void {
        playSound("Sound_BtnClick");
    }

    public static function playFightSound(param1:String, param2:Number = 0.6):void {
        playSound(param1, param2);
    }

    private static function playSound(param1:String, param2:Number = 0.6):void {
        var _loc4_:SoundChannel = null;
        _soundTransform.volume = param2;
        var _loc3_:Sound = UIManager.getSound(param1);
        if (_loc3_) {
            if (_loc4_ = _loc3_.play()) {
                _loc4_.soundTransform = _soundTransform;
            }
        }
    }
}
}
