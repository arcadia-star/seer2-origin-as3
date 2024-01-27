package com.taomee.seer2.app.processor.quest.handler.branch.quest10023 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10023_390 extends QuestMapHandler {

    private static const ITEM_RES_ID:uint = 400223;


    private var _mamaNpc:Mobile;

    private var _luluShow:MovieClip;

    public function QuestMapHandler_10023_390(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) == false && QuestManager.isComplete(23) == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onPreQuestComplete);
        } else if (QuestManager.isAccepted(_quest.id) == false) {
            this.processAccept();
        } else if (QuestManager.isComplete(_quest.id) == false) {
            this.processStep1();
        }
    }

    private function onPreQuestComplete(param1:QuestEvent):void {
        if (param1.questId == 23) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onPreQuestComplete);
            this.processAccept();
        }
    }

    private function processAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccepted);
        this.createMamaNpc();
        var _loc1_:AcceptableMark = new AcceptableMark();
        this._mamaNpc.addOverHeadMark(_loc1_);
    }

    private function onAccepted(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
            SceneManager.changeScene(SceneType.LOBBY, 360);
        }
    }

    private function processStep1():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep1);
        this.createMamaNpc();
        var _loc1_:InProgressMark = new InProgressMark();
        this._mamaNpc.addOverHeadMark(_loc1_);
    }

    private function onStep1(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "10023_1") {
            if (ItemManager.hasGetItem) {
                this.onGetItemList();
            } else {
                ItemManager.requestItemList(this.onGetItemList);
            }
        }
    }

    private function onGetItemList():void {
        var _loc1_:uint = uint(ItemManager.getItemQuantityByReferenceId(ITEM_RES_ID));
        if (_loc1_ >= 6) {
            this.showEnoughDialog();
        } else if (_loc1_ == 0) {
            this.showNothingDialog();
        } else {
            this.showNotEnoughDialog(_loc1_);
        }
    }

    private function showNothingDialog():void {
        NpcDialog.show(53, "兰德妈妈", [[3, "不，是黄金之路的奇特的植物酝酿的“温暖之心”！坏孩子，欺骗家长要打屁股！"]], ["（再去黄金之路找找！）"], [null]);
    }

    private function showNotEnoughDialog(param1:uint):void {
        var _loc2_:uint = uint(6 - param1);
        NpcDialog.show(53, "兰德妈妈", [[1, "还要收集 <font color=\'#ffcc00\'>" + _loc2_ + "</font> 颗温暖之心哦~ 加油，你的努力一定可以唤醒鲁鲁！"]], ["加油！"], [null]);
    }

    private function showEnoughDialog():void {
        NpcDialog.show(53, "兰德妈妈", [[1, "终于到6颗了！我们把这颗“温暖之心”也放沙砾中吧。"]], ["好期待好期待！！"], [function ():void {
            _luluShow = _processor.resLib.getMovieClip("mc_1_0");
            _map.front.addChild(_luluShow);
            MovieClipUtil.playMc(_luluShow, 1, _luluShow.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(_luluShow);
                _luluShow = null;
                NpcDialog.show(53, "兰德妈妈", [[1, "鲁鲁看起来很喜欢你，所以我决定……让你带走它！"]], ["真的？谢谢妈妈！！"], [function ():void {
                    NpcDialog.show(53, "兰德妈妈", [[1, "要像对待自己的亲人一般好好呵护和养育它，它一定可以成为你的忠实伙伴。"], [1, "还有……希望有一天，地沙两族的矛盾可以化解……孩子们也……"]], ["我明白，我一定会努力！！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                        QuestManager.completeStep(_quest.id, 1);
                    }]);
                }]);
            }, true);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10023) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            this.clearMamaNpc();
        }
    }

    private function createMamaNpc():void {
        var _loc1_:XML = <npc id="53" resId="53" name="兰德妈妈" dir="1" width="25" height="120" pos="336,448"
                              actorPos="350,450" path="">
            <dialog npcId="53" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[我现在是不是太粗鲁了呢……兰德爸爸不会嫌弃我吧？]]></node>
                    <reply action="close"><![CDATA[（那你就改嘛！）]]></reply>
                </branch>
            </dialog>
            <eventHandler>
                <click>
                    <HandlerOpenDialogPanel/>
                </click>
            </eventHandler>
        </npc>;
        this._mamaNpc = MobileManager.createNpc(new NpcDefinition(_loc1_));
        this._mamaNpc.buttonMode = true;
    }

    private function clearMamaNpc():void {
        if (this._mamaNpc) {
            this._mamaNpc.removeOverHeadMark();
            MobileManager.removeMobile(this._mamaNpc, MobileType.NPC);
            this._mamaNpc = null;
        }
    }

    private function clearLuluShow():void {
        if (this._luluShow) {
            DisplayObjectUtil.removeFromParent(this._luluShow);
            this._luluShow = null;
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onPreQuestComplete);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        this.clearLuluShow();
        this.clearMamaNpc();
        super.processMapDispose();
    }
}
}
