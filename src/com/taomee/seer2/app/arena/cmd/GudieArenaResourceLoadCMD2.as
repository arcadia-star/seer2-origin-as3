package com.taomee.seer2.app.arena.cmd {
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.data.TeamInfo;
import com.taomee.seer2.app.arena.util.FightSide;

import flash.utils.ByteArray;

public class GudieArenaResourceLoadCMD2 implements IArenaBaseCMD {


    private var _arenaData:ArenaDataInfo;

    private var _onGetInfoComplete:Function;

    public function GudieArenaResourceLoadCMD2(param1:ArenaDataInfo, param2:Function) {
        super();
        this._arenaData = param1;
        this._onGetInfoComplete = param2;
    }

    public function init():void {
    }

    public function send():void {
        var _loc1_:ByteArray = new ByteArray();
        _loc1_.writeByte(1);
        _loc1_.writeByte(1);
        _loc1_.writeUnsignedInt(50233);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(50233);
        var _loc2_:ByteArray = new ByteArray();
        _loc2_.writeUTFBytes("233");
        _loc2_.length = 16;
        _loc1_.writeBytes(_loc2_, 0, 16);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(20);
        _loc1_.writeUnsignedInt(435);
        _loc1_.writeByte(1);
        _loc1_.writeShort(100);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(5);
        _loc1_.writeUnsignedInt(13110);
        _loc1_.writeUnsignedInt(13113);
        _loc1_.writeUnsignedInt(13115);
        _loc1_.writeUnsignedInt(13123);
        _loc1_.writeUnsignedInt(13119);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(2);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(0);
        var _loc3_:ByteArray = new ByteArray();
        _loc3_.writeUTFBytes("XXX");
        _loc3_.length = 16;
        _loc1_.writeBytes(_loc3_, 0, 16);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(2);
        _loc1_.writeUnsignedInt(20);
        _loc1_.writeUnsignedInt(433);
        _loc1_.writeByte(1);
        _loc1_.writeShort(100);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(500);
        _loc1_.writeUnsignedInt(5);
        _loc1_.writeUnsignedInt(13077);
        _loc1_.writeUnsignedInt(13078);
        _loc1_.writeUnsignedInt(13082);
        _loc1_.writeUnsignedInt(13087);
        _loc1_.writeUnsignedInt(13086);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeUnsignedInt(0);
        _loc1_.writeByte(0);
        _loc1_.writeByte(0);
        this.onGetResourceInfo(_loc1_);
    }

    private function onGetResourceInfo(param1:ByteArray):void {
        param1.position = 0;
        this._arenaData.fightMode = param1.readUnsignedByte();
        var _loc2_:TeamInfo = new TeamInfo(param1, this._arenaData.fightMode);
        var _loc3_:TeamInfo = new TeamInfo(param1, this._arenaData.fightMode);
        if (_loc2_.clientSide == FightSide.LEFT) {
            this._arenaData.leftTeam = new FighterTeam(_loc2_);
            this._arenaData.rightTeam = new FighterTeam(_loc3_);
        } else {
            this._arenaData.rightTeam = new FighterTeam(_loc2_);
            this._arenaData.leftTeam = new FighterTeam(_loc3_);
        }
        if (this._arenaData.leftTeam.subFighterInfo != null || this._arenaData.rightTeam.subFighterInfo != null) {
            this._arenaData.isDoubleMode = true;
        }
        this._arenaData.fightWeather = param1.readUnsignedByte();
        this._arenaData.canCatch = param1.readUnsignedByte() == 0;
        this._onGetInfoComplete();
        this.dispose();
    }

    public function dispose():void {
    }
}
}
