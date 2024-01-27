package com.taomee.seer2.app.gameRule.door.core {
public class ServerReward {

    public static const PET_REWARD:uint = 1;

    public static const ITEM_REWARD:uint = 2;


    public var rewardId:uint = 0;

    public var rewardType:uint = 0;

    public function ServerReward(param1:uint, param2:uint) {
        super();
        this.rewardId = param1;
        this.rewardType = param2;
    }

    public function printInfo():void {
    }
}
}
