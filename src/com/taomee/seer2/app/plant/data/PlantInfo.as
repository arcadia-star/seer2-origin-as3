package com.taomee.seer2.app.plant.data {
import com.taomee.seer2.app.config.info.SeedInfo;
import com.taomee.seer2.app.plant.event.PlantEvent;
import com.taomee.seer2.app.plant.event.PlantEventControl;
import com.taomee.seer2.core.manager.TimeManager;

import flash.utils.IDataInput;

public class PlantInfo {


    public var userId:uint;

    public var plantId:uint;

    public var plantIsOpen:uint;

    public var plantIsVip:uint;

    public var plantSeedId:uint;

    public var startTime:uint;

    public var duringTime:uint;

    public var getCount:uint;

    public var seasonCount:uint;

    public var stealCount:uint;

    public var plantStatus:uint;

    public var plantStatusStartTime:uint;

    public var plantNextStatusTime:uint;

    public var fertilizer:uint;

    private var prevSeedStage:int;

    public var serTime:uint;

    public var seedStage:int;

    public var stageEndTime:uint;

    public var seedInfo:SeedInfo;

    public function PlantInfo() {
        super();
    }

    public function parseInit(param1:uint):void {
        this.userId = 0;
        this.plantId = param1;
        this.plantSeedId = 0;
        this.duringTime = 0;
        this.getCount = 0;
        this.seasonCount = 0;
        this.stealCount = 0;
        this.plantIsOpen = 0;
        if (param1 >= 12) {
            this.plantIsVip = 1;
        } else {
            this.plantIsVip = 0;
        }
    }

    public function parseInfo(param1:IDataInput):void {
        this.plantSeedId = param1.readUnsignedInt();
        this.duringTime = param1.readUnsignedInt();
        this.getCount = param1.readUnsignedInt();
        this.seasonCount = param1.readUnsignedInt();
        this.stealCount = param1.readUnsignedInt();
        this.plantStatus = param1.readUnsignedInt();
        this.plantStatusStartTime = param1.readUnsignedInt();
        this.fertilizer = param1.readUnsignedInt();
        this.plantIsOpen = 1;
    }

    public function updateInfo():void {
        if (TimeManager.getPrecisionServerTime() >= this.duringTime) {
            this.seedStage = 4;
            this.stageEndTime = 0;
            if (this.prevSeedStage != this.seedStage) {
                PlantEventControl.dispatchEvent(PlantEvent.SEED_STATUS_CHANGE, this.plantId, this.seedStage);
                this.prevSeedStage = this.seedStage;
            }
            return;
        }
        var _loc1_:uint = this.duringTime - TimeManager.getPrecisionServerTime();
        if (_loc1_ >= this.seedInfo.harvestTime * 60) {
            _loc1_ = this.seedInfo.harvestTime * 60 - 1;
        }
        this.seedStage = 3 - uint(_loc1_ / uint(this.seedInfo.harvestTime * 60 / 3));
        this.stageEndTime = _loc1_ % (this.seedInfo.harvestTime * 60);
        if (this.prevSeedStage != this.seedStage) {
            PlantEventControl.dispatchEvent(PlantEvent.SEED_STATUS_CHANGE, this.plantId, this.seedStage);
            this.prevSeedStage = this.seedStage;
        }
    }
}
}
