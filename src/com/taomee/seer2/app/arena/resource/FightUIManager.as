package com.taomee.seer2.app.arena.resource {
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.media.Sound;
import flash.system.ApplicationDomain;
import flash.utils.ByteArray;

import org.taomee.utils.DomainUtil;

public class FightUIManager {

    public static var initialized:Boolean = false;

    private static var _domain:ApplicationDomain;

    private static var _questDomain:ApplicationDomain;


    public function FightUIManager() {
        super();
    }

    public static function setup(param1:ApplicationDomain):void {
        _domain = param1;
        initialized = true;
    }

    public static function setupQuest(param1:ApplicationDomain):void {
        _questDomain = param1;
    }

    public static function getClass(param1:String):Class {
        return DomainUtil.getClass(param1, _domain);
    }

    public static function getMovieClip(param1:String):MovieClip {
        return DomainUtil.getMovieClip(param1, _domain);
    }

    public static function getButton(param1:String):SimpleButton {
        return DomainUtil.getSimpleButton(param1, _domain);
    }

    public static function getBitmapData(param1:String):BitmapData {
        return DomainUtil.getBitmapData(param1, _domain);
    }

    public static function getSound(param1:String):Sound {
        return DomainUtil.getSound(param1, _domain);
    }

    public static function getSprite(param1:String):Sprite {
        return DomainUtil.getSprite(param1, _domain);
    }

    public static function getByteArray(param1:String):ByteArray {
        return DomainUtil.getByteArray(param1, _domain);
    }

    public static function getQuestMovieClip(param1:String):MovieClip {
        return DomainUtil.getMovieClip(param1, _questDomain);
    }

    public static function hasDefinition(param1:String):Boolean {
        return _domain.hasDefinition(param1);
    }
}
}
