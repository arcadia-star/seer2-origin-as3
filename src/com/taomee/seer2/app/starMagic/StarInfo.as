package com.taomee.seer2.app.starMagic {
public class StarInfo {


    public var user_id:int;

    public var id:int;

    public var buffId:int;

    public var time:int;

    public var level:int;

    public var exp:int;

    public var nextExp:int;

    public var maxLevel:int;

    public var level_cof:int;

    public var pos:int;

    public var petCatchTime:int;

    public var sell_exp:int;

    public var type:int;

    public var nextExpArr:Array;

    public var nameT:String;

    public var buffSwf:int;

    public var effdesc:String;

    public var effvalue:Array;

    public var desc:Array;

    public function StarInfo() {
        super();
    }

    public static function updateStarInfo(param1:StarInfo, param2:StarInfo):void {
        param2.user_id = param1.user_id;
        param2.id = param1.id;
        param2.buffId = param1.buffId;
        param2.time = param1.time;
        param2.level = param1.level;
        param2.exp = param1.exp;
        param2.nextExp = param1.nextExp;
        param2.maxLevel = param1.maxLevel;
        param2.level_cof = param1.level_cof;
        param2.pos = param1.pos;
        param2.petCatchTime = param1.petCatchTime;
        param2.sell_exp = param1.sell_exp;
        param2.type = param1.type;
        param2.desc = param1.desc;
        param2.nextExpArr = param1.nextExpArr;
        param2.effdesc = param1.effdesc;
        param2.buffSwf = param1.buffSwf;
        param2.effvalue = param1.effvalue;
    }
}
}
