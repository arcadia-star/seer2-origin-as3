package com.taomee.seer2.app.processor.activity.petKingFightStart {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.record.FightRecordData;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;

public class PetKingFightStart {

    private static const mapIdList:Vector.<uint> = Vector.<uint>([400, 401, 404, 405, 408, 409, 416, 417, 420, 421, 81, 402, 403, 406, 407, 410, 411, 418, 419, 422, 423]);

    private static const countList:Vector.<uint> = Vector.<uint>([1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]);

    private static var _index:uint = 0;


    public function PetKingFightStart() {
        super();
    }

    public static function start():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
        Connection.addCommandListener(CommandSet.ITEM_MAX_NOTIFY_INFO_1200, onMessage);
    }

    private static function onMessage(param1:MessageEvent):void {
        _index = 1;
    }

    private static function onComplete(param1:SceneEvent):void {
        var _loc2_:int = mapIdList.indexOf(SceneManager.active.mapID);
        if (_loc2_ == -1) {
            return;
        }
        if (_index == 1) {
            _index = 0;
            return;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_PVP_WOHOO) {
                ServerMessager.addMessage("您获得了2块争霸赛奖牌!");
            } else if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_PVP_TRAINER) {
                ServerMessager.addMessage("您获得了2块争霸赛奖牌!");
            } else if (DateUtil.isInHourScope(14, 16)) {
                ServerMessager.addMessage("您获得了" + countList[_loc2_] * 2 + "块争霸赛奖牌!");
            } else {
                ServerMessager.addMessage("您获得了" + countList[_loc2_] + "块争霸赛奖牌!");
            }
        }
    }
}
}
