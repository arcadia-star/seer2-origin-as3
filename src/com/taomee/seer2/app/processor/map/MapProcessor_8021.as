package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.christmas.ChristmasInfoManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_8021 extends TitleMapProcessor {


    private var _announcementBtn:MovieClip;

    private var _snowEffect:SnowEffect;

    public function MapProcessor_8021(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initSnowEffect();
        this.initAnnouncement();
    }

    private function initSnowEffect():void {
        this._snowEffect = new SnowEffect();
        this._snowEffect.start(_map.width, _map.height, _map.libManager.getClass("snow"), 10, 2000);
        _map.front.addChild(this._snowEffect);
    }

    private function disposeSnowEffect():void {
        this._snowEffect.finish();
    }

    private function initAnnouncement():void {
        this._announcementBtn = _map.content["AnnouncementBtn"];
        this._announcementBtn.buttonMode = true;
        TooltipManager.addCommonTip(this._announcementBtn, "圣诞打工牌");
        if (ChristmasInfoManager.isActivitySo() == false) {
            this._announcementBtn.gotoAndStop(1);
        } else {
            this._announcementBtn.gotoAndStop(2);
        }
        this._announcementBtn.addEventListener(MouseEvent.CLICK, this.onAnnouncement);
    }

    private function onAnnouncement(param1:MouseEvent):void {
        var _loc3_:Object = null;
        this._announcementBtn.gotoAndPlay(2);
        if (ChristmasInfoManager.isActivitySo() == false) {
            ChristmasInfoManager.addActivitySo();
        }
        var _loc2_:int = ChristmasInfoManager.getQuestStatus();
        if (_loc2_ == 1 || _loc2_ == 2 || _loc2_ == 3) {
            _loc3_ = new Object();
            _loc3_.index = _loc2_;
            ModuleManager.showModule(URLUtil.getAppModule("ChristmasQuestPanel"), "正在打开圣诞面板...", _loc3_);
        } else {
            ModuleManager.showModule(URLUtil.getAppModule("ChrismasSockQuestPanel"), "正在打开圣诞面板...");
        }
    }

    override public function dispose():void {
        if (this._announcementBtn) {
            this._announcementBtn.removeEventListener(MouseEvent.CLICK, this.onAnnouncement);
            TooltipManager.remove(this._announcementBtn);
        }
        this._announcementBtn = null;
        this.disposeSnowEffect();
        super.dispose();
    }
}
}

import flash.display.Sprite;

import org.taomee.utils.Tick;

class SnowEffect extends Sprite {


    private var _width:Number;

    private var _height:Number;

    private var _skinCls:Class;

    private var _count:int;

    private var _particleVec:Vector.<SnowParticle>;

    public function SnowEffect() {
        super();
    }

    public function start(param1:Number, param2:Number, param3:Class, param4:int, param5:int):void {
        this._width = param1;
        this._height = param2;
        this._skinCls = param3;
        this._count = param4;
        this._particleVec = new Vector.<SnowParticle>();
        Tick.instance.addRender(this.onEnter);
        Tick.instance.addRender(this.onTick, param5);
        mouseEnabled = false;
        mouseChildren = false;
    }

    private function onEnter(param1:int):void {
        var _loc2_:SnowParticle = null;
        for each(_loc2_ in this._particleVec) {
            if (_loc2_.isShow) {
                _loc2_.x += _loc2_.vx;
                _loc2_.y += _loc2_.vy;
                if (_loc2_.x - _loc2_.width / 2 < 0 || _loc2_.x + _loc2_.width / 2 > this._width || _loc2_.y + _loc2_.height / 2 > this._height) {
                    _loc2_.recycle();
                }
            }
        }
    }

    private function onTick(param1:int):void {
        var _loc2_:SnowParticle = null;
        if (this._particleVec.length >= this._count) {
            for each(_loc2_ in this._particleVec) {
                if (!_loc2_.isShow) {
                    this.resetParticle(_loc2_);
                    break;
                }
            }
        } else {
            _loc2_ = new SnowParticle(this._skinCls);
            this.resetParticle(_loc2_);
            addChild(_loc2_);
            this._particleVec.push(_loc2_);
        }
    }

    public function finish():void {
        Tick.instance.removeRender(this.onEnter);
        Tick.instance.removeRender(this.onTick);
    }

    private function resetParticle(param1:SnowParticle):void {
        var _loc2_:Number = Math.random() * 2 + 2;
        _loc2_ *= Math.random() < 0.5 ? 1 : -1;
        var _loc3_:Number = Math.random() * 2 + 2;
        param1.reset(_loc2_, _loc3_, Math.random() * 0.5 + 0.5);
        param1.x = Math.random() * this._width / 2 + this._width / 4;
        param1.y = 0;
    }
}

import flash.display.Bitmap;
import flash.display.Sprite;

class SnowParticle extends Sprite {


    public var vx:Number;

    public var vy:Number;

    public var bitmap:Bitmap;

    public var isShow:Boolean;

    public function SnowParticle(param1:Class) {
        super();
        this.bitmap = new Bitmap(new param1());
        this.bitmap.smoothing = true;
    }

    public function reset(param1:Number, param2:Number, param3:Number):void {
        this.isShow = true;
        this.vx = param1;
        this.vy = param2;
        this.bitmap.rotation = this.bitmap.scaleX = this.bitmap.scaleY = param3;
        addChild(this.bitmap);
        this.cacheAsBitmap = true;
    }

    public function recycle():void {
        this.isShow = false;
        removeChild(this.bitmap);
    }
}
