package com.taomee.seer2.app.processor.quest.handler.story.quest56 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.utils.IDataInput;

public class QuestMapHandler_56_160 extends QuestMapHandler {


    public function QuestMapHandler_56_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "56_2") {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
            QuestManager.completeStep(_quest.id, 2);
        }
    }

    private function onStepCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
        Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
        Connection.send(CommandSet.ITEM_EXCHANGE_1055, 445, 1, 0);
        SceneManager.changeScene(SceneType.LOBBY, 192);
    }

    private function onGetReward(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:SwapInfo = new SwapInfo(_loc2_);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
    }
}
}
