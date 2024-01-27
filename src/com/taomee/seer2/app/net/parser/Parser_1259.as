package com.taomee.seer2.app.net.parser {
import com.taomee.seer2.app.pet.data.PetInfoManager;

import flash.utils.IDataInput;

public class Parser_1259 {


    public function Parser_1259(param1:IDataInput) {
        var _loc4_:uint = 0;
        super();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = uint(param1.readUnsignedInt());
            PetInfoManager.deletePet(_loc4_);
            _loc3_++;
        }
    }
}
}
