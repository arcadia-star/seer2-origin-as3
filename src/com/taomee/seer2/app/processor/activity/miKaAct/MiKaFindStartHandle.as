package com.taomee.seer2.app.processor.activity.miKaAct {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.rightToolbar.toolbar.TorchRelayorToolbar;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;

import org.taomee.utils.DomainUtil;

public class MiKaFindStartHandle {


    private var _map:MapModel;

    private var _resLib:ApplicationDomain;

    private var _mikaMail:MovieClip;

    public function MiKaFindStartHandle(param1:MapModel) {
        var map:MapModel = param1;
        super();
        this._map = map;
        if (this.isActTime()) {
            this.getURL(function ():void {
                _mikaMail = getMovie("MikaMail");
                _mikaMail.buttonMode = true;
                _map.content.addChild(_mikaMail);
                _mikaMail.x = 928;
                _mikaMail.y = 526;
                _mikaMail.addEventListener(MouseEvent.CLICK, onMiKaMailClick);
            });
        }
    }

    private function onMiKaMailClick(param1:MouseEvent):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc2_.hours == 13) {
            TorchRelayorToolbar.playFullMovie();
            StatisticsManager.newSendNovice("2014活动", "米咔雪娃娃", "信封打开");
        } else {
            AlertManager.showAlert("《米咔的雪娃娃》活动时间13:00—14:00,来就有机会获得精灵米咔哦!");
        }
    }

    private function getURL(param1:Function = null):void {
        var callBack:Function = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("miKaFindAct/miKaFindActRes0"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            if (null != callBack) {
                callBack();
            }
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function isActTime():Boolean {
        var _loc1_:Boolean = false;
        if (DateUtil.isInTime(new Date(2014, 11, 26), new Date(2015, 0, 8, 23, 59, 59))) {
            _loc1_ = true;
        }
        return _loc1_;
    }

    public function dispose():void {
        if (this._mikaMail) {
            this._mikaMail.removeEventListener(MouseEvent.CLICK, this.onMiKaMailClick);
            this._mikaMail = null;
        }
        this._map = null;
        this._resLib = null;
    }
}
}
