package com.taomee.seer2.app.peakbattle {
import com.taomee.seer2.app.manager.RankManager;
import com.taomee.seer2.app.net.parser.baseData.RankServerInfo;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_57;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.URLUtil;

public class PeakBattleModel {

    private static var _instance:PeakBattleModel;


    private var _oldGrade:int = -1;

    private var _nowGrade:int;

    public function PeakBattleModel() {
        super();
    }

    public static function getInstance():PeakBattleModel {
        if (!_instance) {
            _instance = new PeakBattleModel();
        }
        return _instance;
    }

    public function requestMyScore():void {
        RankManager.getActorRank(2, this.getScoreInfo);
        ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57, this.getBuffer);
    }

    private function getBuffer(param1:ServerBuffer):void {
        var _loc2_:int = param1.readDataAtPostion(ServerBufferPosition_57.IS_PLAY_PEAKBATTLE);
        if (_loc2_ == 0) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57, ServerBufferPosition_57.IS_PLAY_PEAKBATTLE, 1);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("PeakBattleFull"));
        }
    }

    private function getScoreInfo(param1:RankServerInfo):void {
        if (this._oldGrade == -1) {
            this._oldGrade = param1.score;
        } else {
            this.nowGrade = param1.score;
        }
    }

    public function set nowGrade(param1:int):void {
        this._nowGrade = param1;
        var _loc2_:int = this._nowGrade - this._oldGrade;
        if (_loc2_ < 0) {
            ServerMessager.addMessage("你输了，被无情的扣掉" + -_loc2_ + "点竞技场积分!");
        } else if (_loc2_ != 0) {
            ServerMessager.addMessage("恭喜你获得了" + _loc2_ + "点竞技场积分!");
        }
        this._oldGrade = this._nowGrade;
    }
}
}
