package com.taomee.seer2.app.processor.quest.handler.branch.quest10162 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.OnlyFlagManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class QuestMapHandler_10162_193 extends QuestMapHandler {


    public function QuestMapHandler_10162_193(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false && SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.doWin();
            }
        }
    }

    private function doWin():void {
        OnlyFlagManager.RequestFlag(function ():void {
            if (OnlyFlagManager.getFlag(629) != 1) {
                SwapManager.swapItem(916, 1, onSwap);
            }
        });
    }

    private function onSwap(param1:IDataInput):void {
        var data:IDataInput = param1;
        var swap:SwapInfo = new SwapInfo(data, false);
        if (swap.itemCount != 0) {
            ItemManager.requestItemList(function ():void {
                ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, getItemHandle);
                ItemManager.requestSpecialItemList();
            });
        }
    }

    private function getItemHandle(param1:ItemEvent):void {
        var num:int = 0;
        var evt:ItemEvent = param1;
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.getItemHandle);
        if (ItemManager.getSpecialItem(500543)) {
            num = int(ItemManager.getSpecialItem(500543).quantity);
            if (num >= 10) {
                OnlyFlagManager.RequestFlag(function ():void {
                    if (OnlyFlagManager.getFlag(629) == 0) {
                        SwapManager.swapItem(921, 1, onSwapHandler);
                    }
                });
            } else {
                ServerMessager.addMessage("恭喜你获得1个阿卡纳斯碧玉！还需要" + (10 - num) + "个");
            }
        }
    }

    private function onSwapHandler(param1:IDataInput):void {
        var _loc2_:SwapInfo = new SwapInfo(param1);
        OnlyFlagManager.updataFlag(629, 1);
        ModuleManager.toggleModule(URLUtil.getAppModule("BlackGoldSuitPanel"), "正在打开面板...");
    }

    override public function processMapDispose():void {
        ItemManager.removeEventListener(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.getItemHandle);
    }
}
}
