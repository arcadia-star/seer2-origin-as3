package com.taomee.seer2.app.gameRule.door.warrior {
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.Base50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.core.ServerReward;
import com.taomee.seer2.app.gameRule.door.support.Base21LevelDoorSupport;
import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
import com.taomee.seer2.app.popup.AlertManager;

public class Warrior50V50DoorSuport extends Base50V50DoorSupport {

    private static var _instance:Warrior50V50DoorSuport;


    public function Warrior50V50DoorSuport(param1:Block) {
        super();
        if (param1 == null) {
            throw new Error("Singleton Instance!");
        }
        _supportInfo = new DoorSupportInfo(DoorRule.WARRIOR_DOOR, DoorType.Door_50V50, 405, "WarriorDoorStartPanel");
        _ITEMS = [100092, 100091, 100090, 100089, 100088];
    }

    public static function getInstance():Warrior50V50DoorSuport {
        if (_instance == null) {
            _instance = new Warrior50V50DoorSuport(new Block());
        }
        return _instance;
    }

    override protected function dealWithFightResult(param1:uint):void {
        if (param1 == FightSide.RIGHT) {
            updateGuardStatus(Base21LevelDoorSupport.STAND_STATUS);
            AlertManager.showDoorResult(false, _supportInfo.doorType, _supportInfo.doorRule);
        } else if (param1 == FightSide.LEFT) {
            if (_doorLevel >= 21) {
                _guard_mc.visible = false;
                showEquip();
            } else {
                canLevelNow = false;
                _guard_mc.addEventListener(Base21LevelDoorSupport.ESCAPE_END_EVENT, onUpdateNextTrailHandler);
                updateGuardStatus(Base21LevelDoorSupport.ESCAPE_STATUS);
            }
        }
    }

    override public function set rewardId(param1:uint):void {
        _rewardId = param1;
        if (_doorLevel == 7) {
            this.reward7();
        } else if (_doorLevel == 14) {
            this.reward14();
        }
    }

    private function reward7():void {
        _rewardIDList = Vector.<ServerReward>([new ServerReward(200213, ServerReward.ITEM_REWARD), new ServerReward(200214, ServerReward.ITEM_REWARD), new ServerReward(200002, ServerReward.ITEM_REWARD)]);
        AlertManager.showDoorReward(true, _supportInfo.doorType, _supportInfo.doorRule, _rewardId, _rewardIDList);
    }

    private function reward14():void {
        _rewardIDList = Vector.<ServerReward>([new ServerReward(200214, ServerReward.ITEM_REWARD), new ServerReward(200221, ServerReward.ITEM_REWARD), new ServerReward(200003, ServerReward.ITEM_REWARD)]);
        AlertManager.showDoorReward(true, _supportInfo.doorType, _supportInfo.doorRule, _rewardId, _rewardIDList);
    }
}
}

class Block {


    public function Block() {
        super();
    }
}
