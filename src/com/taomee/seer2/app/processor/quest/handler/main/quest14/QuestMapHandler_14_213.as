package com.taomee.seer2.app.processor.quest.handler.main.quest14 {
import com.taomee.seer2.app.animationInteractive.Interactive_13;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_14_213 extends QuestMapHandler {


    private var _interactive_14:Interactive_13;

    public function QuestMapHandler_14_213(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var event:DialogCloseEvent = param1;
        var params:String = event.params;
        if (params == "14_1") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.completeStep(_quest.id, 1);
        }
        if (params == "14_2") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("14_0"), function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[4, "我知道在哪里了！沙爪氏族！沙爪氏族！！谢谢占卜婆婆！！！我去也……"]], ["（前往沙爪氏族）"], [function ():void {
                    QuestManager.completeStep(_quest.id, 3);
                    SceneManager.changeScene(SceneType.LOBBY, 360);
                }]);
            });
        }
    }

    override public function processMapDispose():void {
        if (this._interactive_14) {
            this._interactive_14.dispose();
            this._interactive_14 = null;
        }
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
    }
}
}
