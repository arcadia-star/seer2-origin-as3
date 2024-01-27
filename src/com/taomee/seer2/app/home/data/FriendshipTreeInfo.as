package com.taomee.seer2.app.home.data {
import flash.utils.IDataInput;

public class FriendshipTreeInfo {


    public var hasTree:Boolean;

    public var hasFruit:Boolean;

    public var hasWatering:Boolean;

    public var userDayUsedCount:uint;

    public var treeTotalCount:uint;

    public function FriendshipTreeInfo(param1:IDataInput) {
        super();
        this.hasTree = param1.readBoolean();
        this.hasFruit = param1.readBoolean();
        this.hasWatering = param1.readBoolean();
        this.userDayUsedCount = param1.readUnsignedByte();
        this.treeTotalCount = param1.readUnsignedByte();
        param1.readUnsignedByte();
    }
}
}
