package com.taomee.seer2.app.team.data {
import flash.utils.IDataInput;

public class TeamMainInfo {


    public var id:uint;

    public var name:String;

    public var logoFront:uint;

    public var logoBack:uint;

    public var logoColor:uint;

    public var userPost:uint;

    public var dissolveDay:uint;

    public var teamTotalExp:uint;

    public var teamTodayExp:uint;

    public var teamExpLevel:uint;

    public var teamLevelNeedExp:uint;

    public var userTotalContribute:uint;

    public var userTodayContribute:uint;

    public var userContributeLevel:uint;

    public var userLevelNeedContribute:uint;

    public var teamMaxExpPerday:int;

    public var userMaxContributePerday:int = 500;

    public var rank:uint;

    public var actorActive:uint;

    public var actorSetExp:uint;

    public var dayActorActive:uint;

    public var isCre:uint = 0;

    public var msg:String = "";

    public function TeamMainInfo() {
        super();
    }

    public static function readBaseInfo(param1:TeamMainInfo, param2:IDataInput):void {
        param1.id = param2.readUnsignedInt();
        param1.name = param2.readUTFBytes(25);
        param1.logoFront = param2.readUnsignedInt();
        param1.logoBack = param2.readUnsignedInt();
        param1.logoColor = param2.readUnsignedInt();
    }

    public static function readMoreInfo(param1:TeamMainInfo, param2:IDataInput):void {
        param1.dissolveDay = param2.readUnsignedInt();
        param1.userPost = param2.readUnsignedByte();
        param1.userTotalContribute = param2.readUnsignedInt();
        param2.readUnsignedInt();
    }

    public static function readTeamExpInfo(param1:TeamMainInfo, param2:IDataInput):void {
        param1.teamTotalExp = param2.readUnsignedInt();
        param1.teamMaxExpPerday = param2.readUnsignedInt();
        param1.teamTodayExp = param2.readUnsignedInt();
        param1.teamExpLevel = param2.readUnsignedByte();
        param1.teamLevelNeedExp = param2.readUnsignedInt() + param1.teamTotalExp;
        param1.userTotalContribute = param2.readUnsignedInt();
        param1.userTodayContribute = param2.readUnsignedInt();
        param1.userContributeLevel = param2.readUnsignedByte();
        param1.userLevelNeedContribute = param2.readUnsignedInt() + param1.userTotalContribute;
    }

    public static function readMsgInfo(param1:TeamMainInfo, param2:IDataInput):void {
        var _loc3_:uint = uint(param2.readUnsignedInt());
        param1.msg = param2.readUTFBytes(_loc3_);
    }

    public function clear():void {
        this.id = 0;
        this.name = "";
        this.logoFront = 0;
        this.logoBack = 0;
        this.logoColor = 0;
        this.userPost = 0;
        this.dissolveDay = 0;
    }

    public function changeBaseInfo(param1:TeamMainInfo):void {
        this.id = param1.id;
        this.name = param1.name;
        this.logoFront = param1.logoFront;
        this.logoBack = param1.logoBack;
        this.logoColor = param1.logoColor;
    }
}
}
