package com.taomee.seer2.app.activity.data {
public class ActivityWildPet extends ActivityPet {


    private var _fightIndex:uint;

    public function ActivityWildPet(param1:uint, param2:uint = 0) {
        this._fightIndex = param2;
        super(param1);
    }

    override protected function addClickEventListener():void {
    }

    public function get fightIndex():uint {
        return this._fightIndex;
    }
}
}
