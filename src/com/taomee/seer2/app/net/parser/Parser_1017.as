package com.taomee.seer2.app.net.parser {
import com.taomee.seer2.app.pet.data.PetInfo;

import flash.utils.IDataInput;

public class Parser_1017 {


    public var petInfo:PetInfo;

    public function Parser_1017(param1:IDataInput, param2:PetInfo = null) {
        super();
        if (param2 != null) {
            this.petInfo = param2;
        } else {
            this.petInfo = new PetInfo();
        }
        PetInfo.readBaseInfo(this.petInfo, param1);
        PetInfo.readDetailInfo(this.petInfo, param1);
    }
}
}
