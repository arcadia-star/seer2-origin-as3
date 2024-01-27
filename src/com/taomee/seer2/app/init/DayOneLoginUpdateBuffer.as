package com.taomee.seer2.app.init {
import com.taomee.seer2.app.serverBuffer.ServerBufferData;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.manager.TimeManager;

public class DayOneLoginUpdateBuffer {


    public function DayOneLoginUpdateBuffer() {
        super();
    }

    public static function setServerBuffer():void {
        updateTime();
        updateMagicActivity();
        updatePetKingDayQuest();
        updateAnswer();
    }

    private static function updateAnswer():void {
        var _loc1_:Vector.<ServerBufferData> = Vector.<ServerBufferData>([]);
        var _loc2_:int = 0;
        while (_loc2_ < 8) {
            _loc1_.push(new ServerBufferData(_loc2_, 0));
            _loc2_++;
        }
        ServerBufferManager.updateServerBufferGroup(ServerBufferType.ANSWER_BUFF, _loc1_);
    }

    private static function updatePetKingDayQuest():void {
        ServerBufferManager.updateServerBuffer(ServerBufferType.PET_KING_DAY, 0, 0);
    }

    private static function updateTime():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:Vector.<ServerBufferData> = Vector.<ServerBufferData>([]);
        _loc2_.push(new ServerBufferData(0, _loc1_.fullYear, 4));
        _loc2_.push(new ServerBufferData(4, _loc1_.month));
        _loc2_.push(new ServerBufferData(5, _loc1_.date));
        ServerBufferManager.updateServerBufferGroup(ServerBufferType.DAY_ONE_LOGIN, _loc2_);
    }

    private static function updateMagicActivity():void {
        ServerBufferManager.updateServerBuffer(ServerBufferType.MAGIC_ACTIVITY, 0, 0);
    }
}
}
