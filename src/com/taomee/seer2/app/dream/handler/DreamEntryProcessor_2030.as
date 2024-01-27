package com.taomee.seer2.app.dream.handler {
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;

public class DreamEntryProcessor_2030 extends DreamEntryProcessor {

    private static const DREAM_NPC_CATEGORY:uint = 418;

    private static const NPC_COUNT:uint = 3;

    private static const NPC_ID:Array = [5011, 5012, 5013];


    public function DreamEntryProcessor_2030() {
        _category = DREAM_NPC_CATEGORY;
        super();
    }

    override protected function getDreamMapID():uint {
        var _loc1_:int = Math.ceil(Math.random() * 100);
        if (_loc1_ < 30) {
            return 221;
        }
        if (_loc1_ < 60) {
            return 222;
        }
        return 223;
    }

    override protected function createNpc():void {
        var _loc2_:Mobile = null;
        _dreamNpcVec = new Vector.<Mobile>();
        var _loc1_:uint = 0;
        while (_loc1_ < NPC_COUNT) {
            _loc2_ = MobileManager.getMobile(NPC_ID[_loc1_], MobileType.NPC);
            _dreamNpcVec.push(_loc2_);
            _loc1_++;
        }
    }
}
}
