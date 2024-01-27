package com.taomee.seer2.app.home.data {
import flash.utils.IDataInput;

public class DecorateInfo {


    public var completeList:Array;

    public var inprogressQuest:uint;

    public var hasCheer:Boolean;

    public var totalCheerCount:uint;

    public var resideTime:uint;

    public var beCheeredCount:uint;

    public function DecorateInfo(param1:IDataInput) {
        super();
        this.completeList = new Array();
    }
}
}
