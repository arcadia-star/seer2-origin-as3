package com.taomee.seer2.app.processor.quest.handler.branch.quest10182 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10182_40 extends QuestMapHandler {


    public function QuestMapHandler_10182_40(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "10182_0") {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "快，让我看看吧，说不定是撒旦的故事哟。"]], ["打开纸片看看"], [function ():void {
                ModuleManager.addEventListener("SadanPuzzleGameThreePanel", "PuzzleGameThreeSuccess", onSucessPuzzlePanel);
                ModuleManager.toggleModule(URLUtil.getAppModule("SadanPuzzleGameThreePanel"), "正在打开面板...");
            }]);
        }
    }

    private function onSucessPuzzlePanel(param1:ModuleEvent):void {
        var evr:ModuleEvent = param1;
        ModuleManager.removeEventListener("SadanPuzzleGameThreePanel", "PuzzleGameThreeSuccess", this.onSucessPuzzlePanel);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10182_2"), function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "原来这就是撒旦的身世，怪不得撒旦需要吸取暗月石的能量来使自己强大。不好，如果撒旦过分吸收暗月石能量的话……"]], ["那将不可设想"], [function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "快，我们要赶快救出月神，阻止这灾难的发生，让我们去参加活动“直捣魔窟！拯救月神！”吧。"]], ["Gogogo"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onCompleteHandler);
                    QuestManager.completeStep(_quest.id, 2);
                }]);
            }]);
        }, true, false, 2);
    }

    private function onCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteHandler);
    }
}
}
