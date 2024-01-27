package com.taomee.seer2.app.processor.activity.yiteFigthPve {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.RankManager;
import com.taomee.seer2.app.net.parser.Parser_1521;

public class YiTeEndingGetInfo {

    private static var yiteEnding:YiTeEndingGetInfo;


    public var hasGetAward:int = 0;

    public var currentTeamID:int;

    public var selfRank:int = -2;

    private const TEAM_ID:Vector.<int> = Vector.<int>([603030, 603031]);

    private const RANK_TYPE:int = 4;

    public var hasGetInfo:int = 0;

    public function YiTeEndingGetInfo() {
        super();
        if (YiTeEndingGetInfo.yiteEnding != null) {
            throw new Error("该类是单例类");
        }
    }

    public static function getInstance():YiTeEndingGetInfo {
        if (yiteEnding == null) {
            yiteEnding = new YiTeEndingGetInfo();
        }
        return yiteEnding;
    }

    public function getRankInfo():void {
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.getItemHandle);
        ItemManager.requestSpecialItemList();
    }

    private function getItemHandle(param1:ItemEvent):void {
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.getItemHandle);
        this.infoHandler();
    }

    private function infoHandler():void {
        this.currentTeamID = 0;
        if (ItemManager.getSpecialItem(this.TEAM_ID[0])) {
            this.currentTeamID = this.TEAM_ID[0];
        } else if (ItemManager.getSpecialItem(this.TEAM_ID[1])) {
            this.currentTeamID = this.TEAM_ID[1];
        }
        this.getCurrentTeamRank();
    }

    private function getCurrentTeamRank():void {
        if (this.currentTeamID == 0) {
            this.selfRank = -1;
            this.hasGetInfo = 1;
        } else {
            RankManager.getRankList(this.RANK_TYPE, this.onGetRank, 0, 2);
        }
    }

    private function onGetRank(param1:Parser_1521):void {
        var _loc2_:int = int(param1.rankInfoList.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (param1.rankInfoList[_loc3_].userId == this.currentTeamID) {
                this.selfRank = param1.rankInfoList[_loc3_].currRank;
            }
            _loc3_++;
        }
        this.hasGetInfo = 1;
    }
}
}
