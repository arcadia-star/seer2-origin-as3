package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1525 {


    private var petTime:uint;

    private var chara:uint;

    private var spareChara:uint;

    private var practiceCount:uint;

    private var userDayPracticeCount:uint;

    public function Parser_1525(param1:IDataInput) {
        super();
        this.petTime = param1.readUnsignedInt();
        this.chara = param1.readByte();
        this.spareChara = param1.readByte();
        this.practiceCount = param1.readUnsignedInt();
        this.userDayPracticeCount = param1.readUnsignedShort();
    }

    public function getPetTime():uint {
        return this.petTime;
    }

    public function getChara():uint {
        return this.chara;
    }

    public function getSpareChara():uint {
        return this.spareChara;
    }

    public function getPracticeCount():uint {
        return this.practiceCount;
    }

    public function getUserDayPracticeCount():uint {
        return this.userDayPracticeCount;
    }
}
}
