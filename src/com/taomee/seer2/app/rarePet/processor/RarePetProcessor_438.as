package com.taomee.seer2.app.rarePet.processor {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.baseData.ItemSwapInfo;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;

import flash.events.MouseEvent;

public class RarePetProcessor_438 extends BaseRarePetProcessor {

    private static const TREASURE_RES_ID:uint = 400210;

    private static const FIGHT_AFRO_REWARD_ID:uint = 26;


    public function RarePetProcessor_438(param1:int, param2:int) {
        super(param1, param2);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.active.mapID == _mapId) {
            if (QuestManager.isStepComplete(16, 3) && QuestManager.isStepComplete(16, 4) == false) {
                return;
            }
            _npc.buttonMode = true;
            _npc.addEventListener(MouseEvent.CLICK, this.onNPCClick);
        }
    }

    private function onNPCClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(438, "爆炸头", [[0, "Hey you！！来跟我一起唱！I love rock and roll！！"]], ["我想和你较量一下！", "也~~也~~也~~！"], [function ():void {
            NpcDialog.show(438, "爆炸头", [[0, "迷穴的财宝，你准备好了没？Say again，你准备好了没？？"]], ["迷穴财宝？", "我准备好了！"], [function ():void {
                NpcDialog.show(438, "爆炸头", [[0, "沙漠的深处~~有一座迷穴~~！成堆的财宝~~剧毒的侍卫~~！击败那砂吉塔~~带回那宝藏~~！我看得高兴~~就和你对战~~！"]], ["（那就去沙之迷穴看看吧）"]);
            }, startFightAfro]);
        }, null]);
    }

    private function startFightAfro():void {
        if (ItemManager.hasGetItem) {
            this.onGetItemList();
        } else {
            ItemManager.requestItemList(this.onGetItemList);
        }
    }

    private function onGetItemList():void {
        if (ItemManager.getItemQuantityByReferenceId(TREASURE_RES_ID)) {
            InteractiveRewardManager.requestReward(FIGHT_AFRO_REWARD_ID, this.onRequestFightAfroSuccess, this.onRequestFightAfroError);
        } else {
            NpcDialog.show(438, "爆炸头", [[0, "Hey you！！没有那财宝，休想来挑战！！"]], ["（呃，不能通融一下嘛）"]);
        }
    }

    private function onRequestFightAfroSuccess(param1:Parser_1060):void {
        var _loc2_:ItemSwapInfo = null;
        for each(_loc2_ in param1.addItemVec) {
            this.parseItem(_loc2_.id, _loc2_.count);
        }
        param1.removeItem();
    }

    private function parseItem(param1:uint, param2:uint):void {
        if (param1 == 16) {
            this.showAfroFightDialog(param2);
        }
    }

    private function showAfroFightDialog(param1:uint):void {
        switch (param1) {
            case 3:
                NpcDialog.show(438, "爆炸头", [[0, "Oh no~~参与奖！三回合！！"]], ["三回合就够了！！"], [this.fightAfro]);
                break;
            case 5:
                NpcDialog.show(438, "爆炸头", [[0, "Oh baby~~还不赖！五回合！！"]], ["赶快开始吧！！"], [this.fightAfro]);
                break;
            case 7:
                NpcDialog.show(438, "爆炸头", [[0, "Oh yeah ~~特别奖！七回合！！"]], ["说话要算话！"], [this.fightAfro]);
        }
    }

    private function fightAfro():void {
        FightManager.startFightWithWild(29);
    }

    private function onRequestFightAfroError(param1:uint):void {
        NpcDialog.show(438, "爆炸头", [[0, "Hey you！！没有那财宝，休想来挑战！！"]], ["（呃，不能通融一下嘛）"]);
    }

    override public function processMapDispose():void {
        if (SceneManager.active.mapID == _mapId) {
            _npc.buttonMode = false;
            _npc.removeEventListener(MouseEvent.CLICK, this.onNPCClick);
        }
        super.processMapDispose();
    }
}
}
