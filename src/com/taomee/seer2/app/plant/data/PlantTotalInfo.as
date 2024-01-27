package com.taomee.seer2.app.plant.data {
import com.taomee.seer2.app.config.SeedConfig;
import com.taomee.seer2.core.manager.TimeManager;

import flash.utils.IDataInput;

public class PlantTotalInfo {


    public var userId:uint;

    public var infoList:Vector.<PlantInfo>;

    public function PlantTotalInfo() {
        this.infoList = Vector.<PlantInfo>([]);
        super();
    }

    public function parseInfo(param1:IDataInput):void {
        var _loc4_:uint = 0;
        var _loc5_:uint = 0;
        var _loc6_:PlantInfo = null;
        this.userId = param1.readUnsignedInt();
        this.initInfo();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(param1.readUnsignedInt());
            for each(_loc6_ in this.infoList) {
                if (_loc6_.plantId == _loc5_) {
                    _loc6_.userId = _loc4_;
                    _loc6_.parseInfo(param1);
                    _loc6_.seedInfo = SeedConfig.getSeedInfo(_loc6_.plantSeedId);
                }
            }
            _loc3_++;
        }
    }

    public function initInfo():void {
        var _loc1_:PlantInfo = null;
        var _loc2_:int = 0;
        while (_loc2_ < 16) {
            _loc1_ = new PlantInfo();
            _loc1_.parseInit(_loc2_);
            this.infoList.push(_loc1_);
            _loc2_++;
        }
        _loc1_ = new PlantInfo();
        _loc1_.parseInit(1000);
        this.infoList.push(_loc1_);
    }

    public function initUpdateInfo():void {
        var _loc1_:PlantInfo = null;
        for each(_loc1_ in this.infoList) {
            if (_loc1_.plantSeedId != 0) {
                _loc1_.serTime = TimeManager.getServerTime();
                _loc1_.updateInfo();
            }
        }
    }

    public function updateInfo():void {
        var _loc1_:PlantInfo = null;
        for each(_loc1_ in this.infoList) {
            if (_loc1_.plantSeedId != 0) {
                _loc1_.updateInfo();
            }
        }
    }
}
}
