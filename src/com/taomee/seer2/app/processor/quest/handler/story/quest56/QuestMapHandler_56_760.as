package com.taomee.seer2.app.processor.quest.handler.story.quest56 {
import com.taomee.seer2.app.dialog.NpcDialog;
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

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_56_760 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_56_760(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 5) && QuestManager.isStepComplete(_quest.id, 6) == false) {
            this.initNPC();
        }
    }

    private function initNPC():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_3");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkHandler);
    }

    private function npcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(107, "神翼总督", [[0, "这块【璞玉】是一个心愿，是希望伙伴能够变强的心愿。我想，刚铎和萨兰古尔做出了最好的选择。"]], [], [function ():void {
            NpcDialog.show(107, "神翼总督", [[0, "有时候，命运并没有给我们天生的可供翱翔的翅膀，但我们却可以依靠自己的力量去看一看天空的模样。永远不要放弃这个信念。"]], ["嗯！秘宝已经物归原主，回去向辛迪船长汇报吧！"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepCompleteHandler);
                QuestManager.completeStep(_quest.id, 6);
            }]);
        }]);
    }

    private function onStepCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
        Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
        Connection.send(CommandSet.ITEM_EXCHANGE_1055, 449, 1, 0);
        SceneManager.changeScene(SceneType.LOBBY, 10);
    }

    private function onGetReward(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:SwapInfo = new SwapInfo(_loc2_);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
    }
}
}
