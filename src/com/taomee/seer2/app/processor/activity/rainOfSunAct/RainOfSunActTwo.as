package com.taomee.seer2.app.processor.activity.rainOfSunAct {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.system.ApplicationDomain;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class RainOfSunActTwo {

    private static const BEAT_NUM_FOR:uint = 203104;

    private static const BEAT_SWAP:int = 1762;


    private var _map:MapModel;

    private var _resLib:ApplicationDomain;

    private const BOSS_BLOOD_MAX:int = 20;

    private const POS_LIST:Array = [[132, 195], [290, 60], [675, 178]];

    private var _bossList:Vector.<MovieClip>;

    public function RainOfSunActTwo(param1:MapModel) {
        super();
        this._map = param1;
        this.getURL();
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("rainOfSunAct/RainOfSunActTwo"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            init();
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function init():void {
        ActiveCountManager.requestActiveCount(BEAT_NUM_FOR, function (param1:uint, param2:uint):void {
            addBossList(3 - param2);
        });
    }

    private function addBossList(param1:int):void {
        var _loc2_:MovieClip = null;
        var _loc3_:int = 0;
        this._bossList = new Vector.<MovieClip>();
        _loc3_ = 0;
        while (_loc3_ < param1) {
            _loc2_ = this.getMovie("Boss");
            _loc2_.x = this.POS_LIST[_loc3_][0];
            _loc2_.y = this.POS_LIST[_loc3_][1];
            _loc2_.curBlood = this.BOSS_BLOOD_MAX;
            this._map.content.addChild(_loc2_);
            this._bossList.push(_loc2_);
            _loc3_++;
        }
        if (this._bossList.length > 0) {
            ShootController.addEventListener(ShootEvent.PLAY_END, this.onShootOver);
        }
    }

    private function onShootOver(param1:ShootEvent):void {
        var _loc2_:ShootInfo = param1.info;
        var _loc3_:int = 0;
        while (_loc3_ < this._bossList.length) {
            if (this._bossList[_loc3_]["boss"].hitTestPoint(_loc2_.endPos.x, _loc2_.endPos.y)) {
                --this._bossList[_loc3_].curBlood;
                this.updateBlood(this._bossList[_loc3_]);
                if (this._bossList[_loc3_].curBlood <= 0) {
                    SwapManager.swapItem(BEAT_SWAP);
                    DisplayUtil.removeForParent(this._bossList[_loc3_]);
                    this.playBeatOkAnim(this._bossList[_loc3_]);
                    this._bossList.splice(_loc3_, 1);
                    break;
                }
            }
            _loc3_++;
        }
    }

    private function playBeatOkAnim(param1:MovieClip):void {
        var anima:MovieClip = null;
        var val:MovieClip = param1;
        anima = this.getMovie("BossDeathMC");
        this._map.content.addChild(anima);
        anima.x = val.x + 25;
        anima.y = val.y - 45;
        MovieClipUtil.playMc(anima, 2, anima.totalFrames, function ():void {
            DisplayUtil.removeForParent(anima);
        }, true);
    }

    private function updateBlood(param1:MovieClip):void {
        if (param1) {
            (param1["bloodShow"]["bar"] as MovieClip).scaleX = Number(param1.curBlood / this.BOSS_BLOOD_MAX);
        }
    }

    public function dispose():void {
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.onShootOver);
        var _loc1_:int = 0;
        while (_loc1_ < this._bossList.length) {
            DisplayUtil.removeForParent(this._bossList[_loc1_]);
            _loc1_++;
        }
        this._bossList = null;
    }
}
}
