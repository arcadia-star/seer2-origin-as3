package com.taomee.seer2.app.processor.quest.handler.story.quest26 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_26_470 extends QuestMapHandler {


    private var _diNpc:MovieClip;

    public function QuestMapHandler_26_470(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false) {
            this.createAcceptNpc();
            this._diNpc["di"].addEventListener(MouseEvent.CLICK, this.onAcceptClick);
        } else if (QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false) {
            this.createInprogressNpc();
            this._diNpc["di"].addEventListener(MouseEvent.CLICK, this.onInterimNpcClick);
        }
    }

    private function onAcceptClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(55, "神月老大", [[0, "大板牙已经出发召集了？很好！洒家喜欢有行动力的人！"]], ["真的要决战吗？"], [function ():void {
            NpcDialog.show(57, "先知", [[0, "地沙之战……势在必行……化解多年的积怨……除非你死……便是我亡……！"]], ["化解积怨不能通过战争啊！！"], [function ():void {
                NpcDialog.show(55, "神月老大", [[0, "无礼！先知大人曾引领我族走过重重危急！只要是先知大人的旨意，洒家绝对尊崇！"]], ["就不问清楚原因吗……"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccepted);
                    QuestManager.accept(_quest.id);
                }]);
            }]);
        }]);
    }

    private function onAccepted(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
            this._diNpc.removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
            this.onInterimNpcClick(null);
        }
    }

    private function onInterimNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(55, "神月老大", [[0, "多亏了先知大人，洒家才看清楚沙爪财奴的真面目！如今洒家一定会将他们一举铲除！！你！陪洒家去约定地点：三八跑道线走一遭！"]], ["（去三八跑道线（地）！）"], [function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 390);
        }]);
    }

    private function createInprogressNpc():void {
        this._diNpc = _processor.resLib.getMovieClip("npc_0_1");
        this._diNpc.x = 434;
        this._diNpc.y = 413;
        _map.content.addChild(this._diNpc);
        this._diNpc["di"].buttonMode = true;
    }

    private function createAcceptNpc():void {
        this._diNpc = _processor.resLib.getMovieClip("npc_0_0");
        this._diNpc.x = 434;
        this._diNpc.y = 413;
        _map.content.addChild(this._diNpc);
        this._diNpc["di"].buttonMode = true;
    }

    private function clearDiNpc():void {
        if (this._diNpc) {
            this._diNpc["di"].removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
            this._diNpc["di"].removeEventListener(MouseEvent.CLICK, this.onInterimNpcClick);
            DisplayObjectUtil.removeFromParent(this._diNpc);
            this._diNpc = null;
        }
    }

    override public function processMapDispose():void {
        this.clearDiNpc();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        super.processMapDispose();
    }
}
}
