package com.taomee.seer2.app.processor.quest.handler.branch.quest10023 {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.inventory.events.InventoryEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;

public class QuestMapHandler_10023_360 extends QuestMapHandler {

    private static const ITEM_RES_ID:uint = 400223;


    private var _funnyFlower:MovieClip;

    public function QuestMapHandler_10023_360(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false) {
            if (SwapManager.isSwapNumberMax(192)) {
                this._funnyFlower = _map.content["funnyFlower"];
                this._funnyFlower.addEventListener(Event.ENTER_FRAME, this.onFunnyFlowerEnd);
                ItemManager.addEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemUpdate);
            }
        }
    }

    private function onItemUpdate(param1:InventoryEvent):void {
        if (param1.itemReferenceId == ITEM_RES_ID) {
            ItemManager.removeEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemUpdate);
            if (ItemManager.hasGetItem) {
                this.onGetItemList();
            } else {
                ItemManager.requestItemList(this.onGetItemList);
            }
        }
    }

    private function onFunnyFlowerEnd(param1:Event):void {
        if (this._funnyFlower.currentFrame == this._funnyFlower.totalFrames) {
            this._funnyFlower.removeEventListener(Event.ENTER_FRAME, this.onFunnyFlowerEnd);
            DisplayObjectUtil.removeFromParent(_processor.mouseHint);
        }
    }

    private function onGetItemList():void {
        var _loc1_:uint = uint(ItemManager.getItemQuantityByReferenceId(ITEM_RES_ID));
        if (_loc1_ >= 6) {
            ServerMessager.addMessage("收集到足够的温暖之心，快去 <font color=\'#ff0000\'>三八跑道线(地)</font> 找 <font color=\'#ffcc00\'>兰德妈妈</font>");
        } else {
            ServerMessager.addMessage("还需要收集 <font color=\'#ff0000\'>" + (6 - _loc1_) + "</font> 颗温暖之心");
        }
    }

    override public function processMapDispose():void {
        ItemManager.removeEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemUpdate);
        if (this._funnyFlower) {
            DisplayObjectUtil.removeFromParent(_processor.mouseHint);
            this._funnyFlower.removeEventListener(Event.ENTER_FRAME, this.onFunnyFlowerEnd);
            this._funnyFlower = null;
        }
        super.processMapDispose();
    }
}
}
