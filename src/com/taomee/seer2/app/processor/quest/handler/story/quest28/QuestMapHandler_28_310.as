package com.taomee.seer2.app.processor.quest.handler.story.quest28 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_28_310 extends QuestMapHandler {


    private var _shaNpc:MovieClip;

    public function QuestMapHandler_28_310(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false) {
            this.createInprogressNpc();
            this._shaNpc.addEventListener(MouseEvent.CLICK, this.onInprogressNpcClick);
        }
    }

    private function onInprogressNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(56, "神爪财团老板", [[0, "哼，慢吞吞的地月粗鬼，连时间概念都没有吗？"]], ["三思啊大老板……"], [function ():void {
            NpcDialog.show(56, "神爪财团老板", [[0, "不用三思了，我决心已定。另外，我需要一个使者出面交涉，你一直是一个理想的人选。"]], ["……"], [function ():void {
                NpcDialog.show(56, "神爪财团老板", [[0, "我没兴趣和地月粗鬼说不必要的废话。这是我亲手签名的使者令，收好了。"]], ["亲手签名啊……"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onCompleted);
                    QuestManager.completeStep(_quest.id, 1);
                }]);
            }]);
        }]);
    }

    private function onCompleted(param1:QuestEvent):void {
        if (param1.questId == 28) {
            this.processMapDispose();
            this.showMessage();
        }
    }

    private function showMessage():void {
        if (QuestManager.isCanAccepted(25) || QuestManager.isCanAccepted(26)) {
            ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>地月氏族主城</font> 找 <font color=\'#ffcc00\'>神月老大</font>");
        } else if (QuestManager.isStepComplete(25, 1) == false) {
            ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>乌黑矿坑</font> 找 <font color=\'#ffcc00\'>大板牙</font>");
        } else if (QuestManager.isStepComplete(26, 1) == false) {
            ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>三八跑道线(地)</font> 找 <font color=\'#ffcc00\'>神月老大</font>");
        } else {
            ServerMessager.addMessage("下一步: 决战一触即发?！ 赶快前往 <font color=\'#ffcc00\'>三八跑道线(地)</font>");
        }
    }

    private function createInprogressNpc():void {
        this._shaNpc = _processor.resLib.getMovieClip("npc_1_0");
        this._shaNpc.x = 321;
        this._shaNpc.y = 319;
        _map.content.addChild(this._shaNpc);
        this._shaNpc.buttonMode = true;
    }

    private function clearNpc():void {
        if (this._shaNpc) {
            this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onInprogressNpcClick);
            DisplayObjectUtil.removeFromParent(this._shaNpc);
            this._shaNpc = null;
        }
    }

    override public function processMapDispose():void {
        this.clearNpc();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleted);
        super.processMapDispose();
    }
}
}
