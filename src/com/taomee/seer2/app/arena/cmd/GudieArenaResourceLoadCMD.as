package com.taomee.seer2.app.arena.cmd {
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.data.TeamInfo;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.pet.data.PetInfoManager;

import flash.utils.ByteArray;

public class GudieArenaResourceLoadCMD implements IArenaBaseCMD {


    private var _arenaData:ArenaDataInfo;

    private var _onGetInfoComplete:Function;

    public function GudieArenaResourceLoadCMD(param1:ArenaDataInfo, param2:Function) {
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
        _loc1_.writeUnsignedInt(this.getResourceId(PetInfoManager.getFirstPetInfo().resourceId));
        _loc1_.writeByte(1);
        _loc1_.writeShort(9);
        _loc1_.writeUnsignedInt(200);
        _loc1_.writeUnsignedInt(200);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(this.getNormalSkilId(PetInfoManager.getFirstPetInfo().resourceId));
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
        _loc1_.writeUnsignedInt(43);
        _loc1_.writeByte(1);
        _loc1_.writeShort(2);
        _loc1_.writeUnsignedInt(150);
        _loc1_.writeUnsignedInt(150);
        _loc1_.writeUnsignedInt(1);
        _loc1_.writeUnsignedInt(10034);
        _loc1_.writeByte(0);
        _loc1_.writeByte(0);
        _loc1_.writeUnsignedInt(0);
        this.onGetResourceInfo(_loc1_);
    }

    private function getResourceId(param1:uint):uint {
        var _loc2_:uint = 0;
        switch (param1) {
            case 1:
                _loc2_ = 1;
                break;
            case 4:
                _loc2_ = 4;
                break;
            case 7:
                _loc2_ = 7;
                break;
            default:
                _loc2_ = param1;
        }
        return _loc2_;
    }

    private function getNormalSkilId(param1:uint):uint {
        var _loc2_:uint = 0;
        switch (param1) {
            case 1:
                _loc2_ = 10001;
                break;
            case 4:
                _loc2_ = 10018;
                break;
            case 7:
                _loc2_ = 10034;
        }
        return _loc2_;
    }

    private function getSpecialSkilId(param1:uint):uint {
        var _loc2_:uint = 0;
        switch (param1) {
            case 1:
                _loc2_ = 10013;
                break;
            case 4:
                _loc2_ = 10030;
                break;
            case 7:
                _loc2_ = 10046;
        }
        return _loc2_;
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
        this._arenaData = null;
        this._onGetInfoComplete = null;
    }
}
}
