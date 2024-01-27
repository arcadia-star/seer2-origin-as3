package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.Tick;

public class PetKingPowerToolbar extends RightToolbar {

    public static var isGetAwardSymbol:int = -1;

    private static var timeIndex:int = -1;

    private static const TIME_DIFFERENCE:int = 30;

    public static const TIME_VEC:Vector.<Date> = Vector.<Date>([new Date(2012, 6, 27, 14), new Date(2012, 6, 27, 14, 20), new Date(2012, 6, 27, 14, 40), new Date(2012, 6, 28, 14), new Date(2012, 6, 28, 14, 20), new Date(2012, 6, 28, 14, 40), new Date(2012, 6, 29, 14), new Date(2012, 6, 29, 14, 20), new Date(2012, 6, 29, 14, 40)]);

    public static const TIME_MAX:Number = 1200;


    private var _whichDay:int = 0;

    public function PetKingPowerToolbar() {
        super();
        this.initUI();
        Tick.instance.addRender(this.showLight, 5000);
    }

    private function showLight(param1:* = null):void {
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc2_:Number = Number(TimeManager.getServerTime());
        var _loc3_:int = 0;
        while (_loc3_ < TIME_VEC.length) {
            _loc5_ = (_loc4_ = TIME_VEC[_loc3_].getTime() / 1000) + TIME_DIFFERENCE;
            if (_loc2_ >= _loc4_ && _loc2_ <= _loc5_) {
                if (timeIndex != _loc3_) {
                    timeIndex = _loc3_;
                    setShowTimeComplete(true);
                    break;
                }
                break;
            }
            _loc3_++;
        }
    }

    private function initUI():void {
        Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142, this.isGetAward);
        Connection.send(CommandSet.ACTIVE_COUNT_1142, 1, 202050);
    }

    private function judgeTime():void {
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc1_:Number = Number(TimeManager.getServerTime());
        var _loc2_:int = 0;
        var _loc3_:int = int(TIME_VEC.length);
        while (_loc2_ < _loc3_) {
            _loc5_ = (_loc4_ = TIME_VEC[_loc2_].getTime() / 1000) + TIME_MAX;
            if (_loc1_ >= _loc4_ && _loc1_ < _loc5_) {
                break;
            }
            _loc2_++;
        }
        if (_loc2_ < _loc3_) {
            this._whichDay = _loc2_ / 3 + 1;
        }
    }

    private function isGetAward(param1:MessageEvent):void {
        var _loc3_:Parser_1142 = null;
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:Boolean = false;
        Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142, this.isGetAward);
        var _loc2_:IDataInput = param1.message.getRawData();
        if (_loc2_.bytesAvailable > 0) {
            this.judgeTime();
            _loc3_ = new Parser_1142(_loc2_);
            _loc4_ = _loc3_.infoVec[0];
            _loc5_ = 2;
            _loc6_ = false;
            if (this._whichDay == 0) {
                _loc6_ = true;
            }
            if (_loc4_ == 1 && _loc6_) {
                setShowTimeComplete(true);
            }
        }
    }

    override protected function onClick(param1:MouseEvent):void {
        _isShowTimeComplete = false;
        setShowTimeComplete(false);
        ModuleManager.toggleModule(URLUtil.getAppModule("PetKingPowerPanel"), "精灵王争霸之抢分赛");
    }
}
}
