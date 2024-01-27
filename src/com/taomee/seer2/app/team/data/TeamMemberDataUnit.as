package com.taomee.seer2.app.team.data {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.common.dataList.DataUnit;
import com.taomee.seer2.app.net.Command;

import flash.utils.IDataInput;

public class TeamMemberDataUnit extends DataUnit {


    private var _info:TeamMemberInfo;

    public function TeamMemberDataUnit(param1:int, param2:Command) {
        this._info = new TeamMemberInfo();
        super(param1, param2);
        this._info.userId = param1;
    }

    override protected function parseData(param1:IDataInput):void {
        this._info.userId = param1.readUnsignedInt();
        this._info.teamId = param1.readUnsignedInt();
        this._info.nick = param1.readUTFBytes(UserInfo.NICK_DATA_LEN);
        this._info.titleId = param1.readUnsignedByte();
        this._info.contribution = param1.readUnsignedInt();
        this._info.contributionLevel = param1.readUnsignedInt();
    }

    override public function get data():* {
        return this._info;
    }
}
}
