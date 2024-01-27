package com.taomee.seer2.app.rightToolbar.config {
public class RightToolbarInfo {


    public var type:String;

    public var sort:uint;

    public var dayList:String;

    public var startTime:String;

    public var endTime:String;

    public var classStr:String;

    public var clickType:String;

    public var clickParams:String;

    public var tip:String;

    public var url:String;

    public var lightStartTime:String;

    public var bufIndex:int;

    public var isBufOpen:Boolean;

    public var isDefinedOpen:Boolean = true;

    public var weekLimit:uint;

    public var swapId:uint;

    public var lightIndex:int;

    public var isShowPoint:int;

    public var showPointIndex:int;

    public var toolbarInfoList:Vector.<RightToolbarInfo>;

    public function RightToolbarInfo() {
        super();
    }
}
}
